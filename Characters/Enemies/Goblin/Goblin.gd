extends KinematicBody2D

# states
onready var burning = false
onready var fire = get_node("OnFire")
onready var player = Global.Player

# movement and pathfinding
export var speed : float = 100
var velocity = Vector2.ZERO
var path = []
var threshold = 100
var nav = null

func _ready():
	yield(owner, "ready")
	nav = owner.nav

# warning-ignore:unused_variable
func _physics_process(delta):
	look_at(Global.Player.position)
	var move_distance = speed * delta
	if path.size() > 0:
		look_at(path[0])
		move_to_target()

func move_to_target():
	if global_position.distance_to(path[0]) < threshold:
		path.remove(0)
	else:
		var direction = global_position.direction_to(path[0])
		velocity = direction * speed
		velocity = move_and_slide(velocity)
		
func get_target_path(target_pos):
	path = nav.get_simple_path(global_position, target_pos, true)

func burn():
	burning = true
	fire.start()