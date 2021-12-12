extends Area2D

onready var base = get_parent()

func _physics_process(delta):
	if base.enabled:
		for body in get_overlapping_bodies():
			if body.is_in_group("flammeable"):
				body.burn()

