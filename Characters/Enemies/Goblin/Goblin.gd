extends KinematicBody2D

# player node
var player

# stats
export var hp : float = 100.0

# states
onready var burning = false
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

# other
onready var label = get_node("Label")

func _ready():
	yield(owner, "ready")
	nav = owner.nav
	player = owner.player

# warning-ignore:unused_variable
func _physics_process(delta):
	if hp < 0:
		die()
	var move_distance = speed * delta
	if not in_range:
		animation_player.play("Walk")
	else:
		animation_player.play("Strike")

	if path.size() > 0:
		look_at(path[0])
		move_to_target()
	else:
		animation_player.play("Idle")
	label.text = str(hp)

func move_to_target():
	if global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = global_position.direction_to(path[0])
		velocity = direction * speed
		velocity = move_and_slide(velocity)
		
func get_target_path(target_pos):
	path = nav.get_simple_path(global_position, target_pos, true)

func _on_AttackArea_body_entered(body):
	if body == player:
		in_range = true
		pivot_to_player()

func _on_AttackArea_body_exited(body):
	if body == player:
		in_range = false

func pivot_to_player():
	look_at(player.global_position)

func burn():
	burning = true
	fire.start()

func die():
	queue_free()
