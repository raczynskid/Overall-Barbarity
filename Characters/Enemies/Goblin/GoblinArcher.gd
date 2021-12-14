extends KinematicBody2D

# player node
var player

# stats
export onready var hp : float = 50.0

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
