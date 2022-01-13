extends Node2D

export onready var enabled : bool = false
onready var sprite = get_node("AnimatedSprite")
onready var dmg_area = get_node("DamageArea")
export var immediate_dmg = 100

func _ready():
	pass

func shoot():
	enabled = true
	sprite.visible = true
	if not sprite.is_playing():
		sprite.play()

func _on_AnimatedSprite_animation_finished():
	sprite.visible = false
	sprite.stop()
	sprite.frame = 0

	for body in dmg_area.get_overlapping_bodies():
		if body.is_in_group("env_body"):
			var obj = body.get_parent()
			obj.hp -= immediate_dmg
			if obj.is_in_group("flammeable"):
				obj.burn()
		if body.is_in_group("enemy") or body.is_in_group("destructible"):
			body.hp -= immediate_dmg
		if body.is_in_group("flammeable"):
			body.burn()

	enabled = false
