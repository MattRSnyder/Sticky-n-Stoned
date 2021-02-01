extends KinematicBody2D

export (PackedScene) var GlueBullet

const run_speed := 100

var velocity := Vector2()

onready var player_sprite := $PlayerSprite


func _ready():
	pass


func _physics_process(_delta):
	$Muzzel.look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_up"):
		velocity.y = -run_speed
	elif Input.is_action_pressed("move_down"):
		velocity.y = run_speed
	else:
		velocity.y = 0
	if Input.is_action_pressed("move_right"):
		player_sprite.flip_h = false
		velocity.x = run_speed
	elif Input.is_action_pressed("move_left"):
		player_sprite.flip_h = true
		velocity.x = -run_speed
	else:
		velocity.x = 0
	if Input.is_action_just_pressed("shoot_glue"):
		shoot()
	player_sprite.animation = "run" if velocity != Vector2.ZERO else "idle"
	
	player_sprite.play()
	velocity = move_and_slide(velocity, Vector2.ZERO)

func shoot():
	var b = GlueBullet.instance()
	owner.add_child(b)
	b.transform = $Muzzel.global_transform
