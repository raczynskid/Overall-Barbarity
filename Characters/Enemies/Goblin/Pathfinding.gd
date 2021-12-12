extends Node

onready var player = Global.Player

func _ready():
	pass

func _physics_process(delta):
	var current_scene = get_tree().get_current_scene()
	print(current_scene.name)
