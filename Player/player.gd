class_name Player extends CharacterBody2D
#Teste teste teste
@export var gravity : float = 750
@export var friction : float = 10.0
@export var acceleration : float = 75.0
@export var stamina_regen : float = 20

@onready var score = $HUD/Score
@onready var stopwatch_label = $HUD/StopwatchLabel
@onready var stopwatch = $Stopwatch
@onready var camera_2d = $"../Camera2D"

const MAX_SPEED : float = 400.0

@export var jump_force : float = -250
var max_stamina : float = 100
var stamina : float = max_stamina
var balance : int = 0
var balance_dir : int = 1
var cursor_speed : int = 1
var max_balance_stamina : float = 100
var balance_stamina : float = max_balance_stamina

var on_grind : bool = false
var is_cam_shaking : bool = false
var game_over : bool = false

#variáveis do hud
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var velocity_bar = $HUD/Velocity
@onready var stamina_bar = $HUD/Stamina
@onready var vel_label = $HUD/vel_num
@onready var grind_stamina_ref = $HUD/grind_stamina
@onready var balance_bar_ref = $HUD/balance_bar


#variaveis do status
@onready var status_pop = $status_pop
@onready var status_pop_anim = $status_pop_anim

#Preciso adicionar mudanças nas collision shapes nas animações

func _ready():
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
	handle_grind()
	#Adiciona gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		
	#Adiciona uma fricção no chão e outra fricção no grind
	if is_on_floor():
		if !on_grind:
			if velocity.x != 0:
				velocity.x = move_toward(velocity.x, 0, delta * friction)
		else:
			if velocity.x != 0:
				velocity.x = move_toward(velocity.x, 0, delta * (friction/3))
	move_and_slide()

func take_hit(slow_amount, body) -> void:
	if velocity.x < 200:
		game_over = true
	if velocity.x > 200:
		velocity.x -= slow_amount
		body.pushed = true
		camera_2d.shake_camera(0.3, 3)

func handle_stopwatch():
	UI.run_time = stopwatch.time
	stopwatch_label.text = stopwatch.time_to_string()
	
	
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
	
func handle_grind():
	if on_grind:
		grind_stamina_ref.visible = true
		balance_bar_ref.visible = true
	else:
		grind_stamina_ref.visible = false
		balance_bar_ref.visible = false
	
func show_status(status):
	status_pop.text = status
	status_pop_anim.play("status_pop")
