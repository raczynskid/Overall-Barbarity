extends Node2D

onready var flames = get_node("Flames")
export onready var burn_durability : float = 5.0
onready var timer = get_node("Timer")

onready var character = get_parent()

func _ready():
	pass

func start():
	if burn_durability <= 0:
		flames.emitting = true
		timer.start(3)
	else:
		burn_durability -= 0.1

func _physics_process(delta):
	if flames.emitting:
		character.hp -= 10 * delta

func stop():
	flames.emitting = false

func _on_Timer_timeout():
	stop()
