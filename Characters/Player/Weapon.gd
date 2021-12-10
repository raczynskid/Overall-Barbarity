extends Node2D
onready var player = get_parent()
onready var raycast = get_node("RayCast2D")
onready var weapon_knockback = 100
onready var struck : bool = false

func _physics_process(delta):
	pass

func _on_Area2D_body_entered(body):
	if not struck:
		body.add_central_force(to_global(raycast.cast_to)-global_transform.origin)
	struck = true
