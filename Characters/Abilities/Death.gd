extends Node


onready var  character = get_parent()
onready var sprite = character.get_node("Sprite")
onready var death_sprite = character.get_node("DeathSprite")

func _ready():
	pass
