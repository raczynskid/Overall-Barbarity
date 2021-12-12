extends KinematicBody2D

onready var burning = false
onready var fire = get_node("OnFire")

func _ready():
	pass

func _physics_process(delta):
	look_at(Global.Player.position)

func burn():
	burning = true
	fire.start()

