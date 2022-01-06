extends KinematicBody2D

export var dmg : float = 10
export var speed : float = 300
onready var target_object : Object
onready var target : Vector2
onready var start : Vector2
onready var shooter
onready var sparks = preload("res://FX/BounceParticles.tscn")
var velocity
var deflected : bool = false

func _ready():
	target = target_object.global_position
	look_at(target)

func _physics_process(delta):
	velocity = position.direction_to(target) * speed * delta
	translate(velocity)
	move_and_collide(velocity)


func _on_Hurtbox_body_entered(body):
	if body != shooter:
		if body.is_in_group("player") or body.is_in_group("enemy"):
			body.take_damage(dmg)
			queue_free()
		fire_sparks()
		queue_free()
	else:
		if deflected:
			body.take_damage(dmg)
			queue_free()



func _on_Hurtbox_area_entered(area):
	if area.is_in_group("hurtbox_melee"):
		deflect_projectile()
		fire_sparks()

func _on_Destroy_timeout():
	queue_free()

func deflect_projectile():
	deflected = true
	randomize()
	var deflection_randomization = rand_range(-100.0, 100.0)
	var new_target = Vector2(shooter.global_position.x + deflection_randomization, shooter.global_position.y + deflection_randomization)
	target = new_target
	look_at(new_target)

func fire_sparks():
	var bounce_sparks = sparks.instance()
	bounce_sparks.set_position(self.get_position())
	shooter.owner.add_child(bounce_sparks) 
	bounce_sparks.emitting=true
