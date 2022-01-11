extends Area2D


# player node
var player
onready var dialog = get_node("Dialog")

func _ready():
	var world = get_parent().get_node("World")
	player = world.get_node("Player")

func _on_DungeonEntrance_body_entered(body):
	if body == player:
		get_tree().change_scene("res://Levels/Dungeon.tscn")