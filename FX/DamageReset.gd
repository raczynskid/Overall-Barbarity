extends Node
onready var character_sprite = get_parent().get_node("Sprite")


func _ready():
	pass

func _on_Timer_timeout():
	character_sprite.set_self_modulate(Color(1,1,1))
