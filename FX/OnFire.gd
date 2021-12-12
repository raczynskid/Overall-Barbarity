extends Node2D

onready var flames = get_node("Flames")
export onready var burn_durability : float = 5.0

func _ready():
	pass

func start():
	if burn_durability <= 0:
		flames.emitting = true
	else:
		burn_durability -= 0.1

func stop():
	flames.emitting = false