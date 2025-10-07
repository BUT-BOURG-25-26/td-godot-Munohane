extends CharacterBody3D

var player: Player
var move_speed: float = 3
var move_inputs: Vector2

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	var direction = player.global_position - global_position
	direction = direction.normalized()
	
	var look_at_position = player.global_position
	look_at(look_at_position)
	
	velocity = direction*move_speed
	velocity.y = get_gravity().y
	
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision is Player:
			(collision as Player).take_damage(1)
			queue_free()
		
		
	
	if move_inputs != Vector2.ZERO:
		global_position += Vector3(move_inputs.x, 0.0, move_inputs.y)
	return
