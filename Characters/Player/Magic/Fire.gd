extends Node2D

export onready var enabled : bool = false
onready var particles = get_node("Fire")
onready var dmg_area = get_node("DamageArea")

func _ready():
	pass

func enable():
	enabled = true
	particles.emitting = true

func disable():
	enabled = false
	particles.emitting = false

