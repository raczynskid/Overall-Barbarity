extends Node2D
# player node
var player
onready var dialog = get_node("Dialog")

func _ready():
	var world = get_parent().get_parent().get_node("World")
	player = world.get_node("Player")


func _on_Area2D_body_entered(body):
	if body == player:
		dialog.visible = true


func _on_Area2D_body_exited(body):
	if body == player:
		dialog.visible = false
