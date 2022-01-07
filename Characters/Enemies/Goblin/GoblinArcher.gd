extends KinematicBody2D

# player node
var player

# stats
export var hp : float = 100.0
export var SHOT_RANGE : int = 500

# states
onready var burning = false
onready var dead = false
onready var fire = get_node("OnFire")

# movement and pathfinding
export var speed : float = 50
var velocity = Vector2.ZERO
var threshold = 100
var retreat : bool = false

# animation
onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var death_sprite = get_node("DeathSprite")

# combat
onready var target_ray = get_node("Targeting")
onready var arrow
export(Resource) var missile

func _ready():
	yield(owner, "ready")
	var world = owner.get_node("World")
	var environment = owner.get_node("Environment")
	player = world.player

func get_player_vector(delta):
	return (global_position - player.global_position) * speed * delta

func _on_Awareness_body_entered(body):
	if body == player:
		retreat = true

func _on_Awareness_body_exited(body):
	if body == player:
		retreat = false

func _physics_process(delta):
	if not dead:
		if hp <= 0:
			die()
		look_at(Global.Player.position)
		if retreat:
			move_and_slide(get_player_vector(delta))

func burn():
	burning = true
	fire.start()

func die():
	sprite.visible = false
	death_sprite.visible = true
	get_node("CollisionShape2D").disabled = true
	animation_player.play("Die")
	dead = true
	
func take_damage(dmg_points):
	sprite.self_modulate = Color(255,0,0)
	hp -= dmg_points

func _on_Shooting_timeout():
	if not dead:
		if (global_position.distance_to(player.global_position)) < SHOT_RANGE:
			animation_player.play("Shoot")
			arrow = missile.instance()
			arrow.shooter = self
			arrow.target_object = player
			arrow.set_position(self.get_position())

func _on_fire_shot():
	owner.add_child(arrow) 
