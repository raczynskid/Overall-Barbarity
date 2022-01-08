extends Control

var player
var camera

onready var HP = get_node("HP")
onready var MANA = get_node("Mana")

func _ready():
	yield(owner, "ready")
	player = owner.player
	camera = player.get_node("Camera2D")

func _physics_process(delta):
	#set_global_position(Vector2(camera.global_position.x - 500, camera.global_position.y - 350))
	HP.value = player.HP
	MANA.value = player.MANA
