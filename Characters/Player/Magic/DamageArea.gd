extends Area2D

onready var base = get_parent()
export onready var immediate_dmg = 10

func _physics_process(delta):
	if base.enabled:
		for body in get_overlapping_bodies():
			if body.is_in_group("flammeable"):
				body.burn()
				body.hp -= immediate_dmg * delta

