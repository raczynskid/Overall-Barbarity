extends KinematicBody2D

var attack
export onready var initial_sword_cooldown : float = 0.2
export onready var sword_cooldown : float = initial_sword_cooldown
export onready var MOVE_SPEED : int = 20000
export onready var MELEE_DMG : int = 25
export onready var HP : int = 100
export onready var MANA : int = 100
onready var mana_regeneration : bool = false

onready var animation_player = get_node("AnimationPlayer")
onready var label = get_node("Label")
onready var fire = get_node("Fire")
onready var thunder = get_node("Thunder")
onready var feet = get_node("Feet")
onready var hurtbox = get_node("MeleeHurtbox/CollisionShape2D")
onready var mana_regen_timer = get_node("ManaRegeneration")
onready var sprite = get_node("Sprite")
onready var magic = "thunder"

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.Player = self


# default are state.get_step(),speed are relative
func lookAtMouse(delta):
	look_at(get_global_mouse_position())

func spell_choice():
	if Input.is_action_just_pressed("spell1"):
		magic = "fire"
	if Input.is_action_just_pressed("spell2"):
		magic = "thunder"

func _physics_process(delta):
	spell_choice()
	if Input.is_action_just_pressed("attack"):
		if sword_cooldown <= 0:
			attack = true
			animation_player.play("Swing")
	if Input.is_action_pressed("alt_attack"):
		if magic == "fire":
			mana_regeneration = false
			mana_regen_timer = 3
			if MANA > 0:
				attack = true
				animation_player.play("Magic")
				fire.enable()
				MANA -= 10 * delta
		elif magic == "thunder":
			mana_regeneration = false
			mana_regen_timer = 3
			if MANA > 30:
				attack = true
				animation_player.play("Magic")
				thunder.shoot()
				MANA -= 30

	else:
		if mana_regeneration and MANA < 100:
			MANA += 100 * delta

		
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

func _on_MeleeHurtbox_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(MELEE_DMG)
	if body.is_in_group("projectile"):
		body.deflect_projectile()

func _on_ManaRegeneration_timeout():
	mana_regeneration = true

func hurtbox_enable():
	hurtbox.disabled = false

func attack_end():
	attack = false
	sword_cooldown = initial_sword_cooldown
	fire.disable()
	hurtbox.disabled = true

func take_damage(dmg_points):
	sprite.self_modulate = Color(255,255,255)
	HP -= dmg_points
