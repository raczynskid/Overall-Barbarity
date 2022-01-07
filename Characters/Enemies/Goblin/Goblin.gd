extends KinematicBody2D

# player node
var player

# stats
export var hp : float = 100.0
export var MELEE_DMG : float = 10
export var CHASE_RANGE : float = 1000

# states
onready var burning = false
onready var dead = false
onready var fire = get_node("OnFire")

# movement and pathfinding
export var speed : float = 100.0
var velocity = Vector2.ZERO
var path = []
var threshold = 25
var nav = null
onready var in_range : bool = false

# animation
onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var death_sprite = get_node("DeathSprite")

# combat
onready var hurtbox = get_node("Hurtbox/CollisionShape2D")

# other
onready var label = get_node("Label")

func _ready():
	yield(owner, "ready")
	var world = owner.get_node("World")
	var environment = owner.get_node("Environment")
	player = world.player
	nav = environment.get_node("Navigation2D")

# warning-ignore:unused_variable
func _physics_process(delta):
	if not dead:
		if hp <= 0:
			die()
		var move_distance = speed * delta
		if not in_range:
			animation_player.play("Walk")
		else:
			animation_player.play("Strike")

		if path.size() > 0 and global_position.distance_to(player.global_position) < CHASE_RANGE:
			look_at(path[0])
			move_to_target()
		else:
			animation_player.play("Idle")
		label.text = str(hp)

func move_to_target():
	if not dead:
		if global_position.distance_to(path[0]) < threshold:
			path.remove(0)
		else:
			var direction = global_position.direction_to(path[0])
			velocity = direction * speed
			velocity = move_and_slide(velocity)
		
func get_target_path(target_pos):
	if not dead:
		path = nav.get_simple_path(global_position, target_pos, true)

func _on_AttackArea_body_entered(body):
	if not dead:
		if body == player:
			in_range = true
			pivot_to_player()

func _on_AttackArea_body_exited(body):
	if not dead:
		if body == player:
			in_range = false

func pivot_to_player():
	if not dead:
		look_at(player.global_position)

func burn():
	burning = true
	fire.start()

func die():
	dead = true
	death_sprite.visible = true
	sprite.visible = false
	animation_player.play("Die")
	get_node("CollisionShape2D").disabled = true

func take_damage(dmg_points):
	if not dead:
		sprite.self_modulate = Color(255, 0, 0)
		hp -= dmg_points

func _on_Hurtbox_body_entered(body):
	if not dead:
		if body == player:
			player.take_damage(MELEE_DMG)

func _on_attack():
	hurtbox.disabled = true

func _on_attack_end():
	hurtbox.disabled = false
