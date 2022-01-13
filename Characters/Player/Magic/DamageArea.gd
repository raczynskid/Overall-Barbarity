extends Area2D

onready var base = get_parent()
export var immediate_dmg = 10

func _physics_process(delta):
	if base.enabled:
		for body in get_overlapping_bodies():
			if body.is_in_group("flammeable"):
				body.burn()
				body.hp -= immediate_dmg * delta

		for area in get_overlapping_areas():
			if area.get_parent().is_in_group("flammeable"):
				var flammeable_obj = area.get_parent()
				flammeable_obj.burn()
				flammeable_obj.hp -= immediate_dmg * delta
				