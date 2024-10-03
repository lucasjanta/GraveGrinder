class_name Player extends CharacterBody2D

@export var gravity : float = 750
@export var friction : float = 10.0
@export var acceleration : float = 75.0
@export var stamina_regen : float = 20

@onready var score = $HUD/Score
@onready var stopwatch_label = $HUD/StopwatchLabel
@onready var stopwatch = $Stopwatch

const MAX_SPEED : float = 400.0
var player_camera : Camera2D
var jump_force : float = -250
var max_stamina : float = 100
var stamina : float = max_stamina
var is_cam_shaking : bool = false
var game_over : bool = false

#variáveis do hud
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var velocity_bar = $HUD/Velocity
@onready var stamina_bar = $HUD/Stamina
@onready var vel_label = $HUD/vel_num

#variaveis do status
@onready var status_pop = $status_pop
@onready var status_pop_anim = $status_pop_anim



func _ready():
	player_camera = get_tree().get_first_node_in_group("Camera")
	print(player_camera)
	UI.player = self
	UI.tombstones_destroyed = 0
	UI.zombies_killed = 0
	UI.time_in_grind = "00:00"
	velocity_bar.max_value = MAX_SPEED


func _physics_process(delta):
	#Atualiza o hud
	handle_stopwatch()
	handle_velocity_bar()
	handle_stamina_bar(delta)
	handle_score(delta)
	#Adiciona gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#Adiciona fricção
	if is_on_floor():
		if velocity.x != 0:
			velocity.x = move_toward(velocity.x, 0, delta * friction)
	move_and_slide()

func take_hit(slow_amount, _body) -> void:
	if velocity.x < 200:
		game_over = true
	if velocity.x > 200:
		velocity.x -= slow_amount
		CameraHandle.shake_camera(player_camera, 0.3, 3)

func handle_stopwatch():
	stopwatch_label.text = stopwatch.time_to_string()
	UI.speedrun_time = stopwatch.time_to_string()
	
func handle_stamina_bar(delta):
	if stamina < max_stamina:
		stamina += delta * stamina_regen
	else:
		stamina = max_stamina
	stamina_bar.value = stamina
	if stamina_bar.value > 20:
		stamina_bar.tint_progress = "5bffff"
	else:
		stamina_bar.tint_progress = "ff0000"
		
func handle_velocity_bar():
	velocity_bar.value = velocity.x
	if velocity_bar.value < 175:
		velocity_bar.tint_progress = "ff0000"
	if velocity_bar.value >= 175 and velocity_bar.value < 300:
		velocity_bar.tint_progress = "ffff00"
	if velocity_bar.value >= 300 and velocity_bar.value <= 450:
		velocity_bar.tint_progress = "00ff00"
	vel_label.text = str(int(velocity.x))
		
func handle_score(delta):
	if velocity.x > 50 and velocity.x <= 100:
		UI.score += delta * 2
	if velocity.x > 100 and velocity.x <= 200:
		UI.score += delta * 4
	if velocity.x > 200 and velocity.x <= 300:
		UI.score += delta * 8
	if velocity.x > 300:
		UI.score += delta * 16
	score.text = "Score: " + str(int(UI.score))
	
func show_status(status):
	status_pop.text = status
	status_pop_anim.play("status_pop")
	
#func shake_camera(camera, duration, intensity, delta):
	#if is_cam_shaking:
		#if duration > 0:
			#print("funcionano")
			#duration -= delta
			#var shake_amt = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * intensity
			#camera.global_position += shake_amt
		#else:
			#is_cam_shaking = false
