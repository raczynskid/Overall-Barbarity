extends Control

var player
var camera

onready var HP = get_node("HP")
onready var MANA = get_node("Mana")

onready var fire_on = preload("res://UI/flame_icon_on.png")
onready var fire_off = preload("res://UI/flame_icon_off.png")
onready var thunder_on = preload("res://UI/thunder_icon_on.png")
onready var thunder_off = preload("res://UI/thunder_icon_off.png")

onready var fire_toggle = get_node("Fire")
onready var thunder_toggle = get_node("Thunder")

func _ready():
	yield(owner, "ready")
	player = owner.player
	camera = player.get_node("Camera2D")

func _physics_process(delta):
	#set_global_position(Vector2(camera.global_position.x - 500, camera.global_position.y - 350))
	HP.value = player.HP
	MANA.value = player.MANA

	if player.magic == "fire":
		fire_toggle.texture = fire_on
		thunder_toggle.texture = thunder_off
	if player.magic == "thunder":
		fire_toggle.texture = fire_off
		thunder_toggle.texture = thunder_on