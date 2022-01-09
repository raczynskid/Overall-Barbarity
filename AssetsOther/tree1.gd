extends Node2D
onready var crown = get_node("Crown")

func _ready():
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		crown.modulate.a = 0.5
		

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		crown.modulate.a = 1
