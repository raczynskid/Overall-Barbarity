extends KinematicBody2D

var attack
export onready var initial_sword_cooldown : float = 0.2
export onready var sword_cooldown : float = initial_sword_cooldown
export onready var MOVE_SPEED : int = 20000

onready var animation_player = get_node("AnimationPlayer")
onready var label = get_node("Label")
onready var fire = get_node("Fire")
onready var feet = get_node("Feet")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


# default are state.get_step(),speed are relative
func lookAtMouse(delta):
	look_at(get_global_mouse_position())


func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		if sword_cooldown <= 0:
			attack = true
			animation_player.play("Swing")
	if Input.is_action_pressed("alt_attack"):
		attack = true
		animation_player.play("Magic")
		fire.enable()


		
	var move_vec = Vector2()
	if Input.is_action_pressed("ui_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("ui_down"):
		move_vec.y += 1
	if Input.is_action_pressed("ui_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("ui_right"):
		move_vec.x += 1
		
	move_vec = move_vec.normalized()
	var vec=move_vec * MOVE_SPEED * delta

	if vec != Vector2.ZERO:
		feet.visible = true
		if not attack:
			animation_player.play("Walk")
	else:
		feet.visible = false
		if not attack:
			animation_player.play("Idle")
	move_and_slide(vec)
				
	lookAtMouse(delta) 

	if sword_cooldown >= 0:
		sword_cooldown -= delta
	label.text = str(sword_cooldown)
func attack_end():
	attack = false
	sword_cooldown = initial_sword_cooldown
	fire.disable()

