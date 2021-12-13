extends Control

var player

func _ready():
	yield(owner, "ready")
	player = owner.player

func _physics_process(delta):
	set_global_position(player.global_position - Vector2(200,200))
