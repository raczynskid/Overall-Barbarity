extends Node2D
onready var crown = get_node("Crown")
onready var stump = get_node("Stump")
onready var smoke = get_node("Smoke")
onready var burnt_crown = get_node("BurntCrown")

# stats
export var hp : float = 100.0

# states
onready var burning = false
onready var dead = false
onready var fire = get_node("OnFire")

func _ready():
	pass

func _physics_process(delta):
	if not dead:
		if hp <= 0:
			dead = true
	else:
		die()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		crown.modulate.a = 0.5


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		crown.modulate.a = 1

func take_damage(dmg):
	hp -= dmg

func burn():
	burning = true
	fire.start()

func die():
	crown.visible = false
	stump.visible = false
	burnt_crown.visible = true
	smoke.emitting = true
	get_node("StaticBody2D/CollisionShape2D").disabled = true
