extends KinematicBody2D

# player node
var player

# stats
export onready var hp : float = 50.0
export onready var SHOT_RANGE : int = 500

# states
onready var burning = false
onready var fire = get_node("OnFire")

# movement and pathfinding
export var speed : float = 50
var velocity = Vector2.ZERO
var threshold = 100
var retreat : bool = false

# animation
onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

# combat
onready var target_ray = get_node("Targeting")
onready var arrow
export(Resource) var missile

func _ready():
	yield(owner, "ready")
	player = owner.player

func get_player_vector(delta):
	return (global_position - player.global_position) * speed * delta

func _on_Awareness_body_entered(body):
	if body == player:
		retreat = true

func _on_Awareness_body_exited(body):
	if body == player:
		retreat = false

func _physics_process(delta):
	if hp <= 0:
		die()
	look_at(Global.Player.position)
	if retreat:
		move_and_slide(get_player_vector(delta))

func burn():
	burning = true
	fire.start()

func die():
	queue_free()
	
func take_damage(dmg_points):
	sprite.self_modulate = Color(255,0,0)
	hp -= dmg_points

func _on_Shooting_timeout():
	if (global_position.distance_to(player.global_position)) < SHOT_RANGE:
		animation_player.play("Shoot")
		arrow = missile.instance()
		arrow.shooter = self
		arrow.target_object = player
		arrow.set_position(self.get_position())

func _on_fire_shot():
	owner.add_child(arrow) 
