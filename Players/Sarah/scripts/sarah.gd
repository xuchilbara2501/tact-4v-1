extends CharacterBody2D
class_name player_character

## NOTE
## General notes, animation player interpolation mode (the upwards arrow on the right side of each track) needs to be set
## to nearest (squared white option) for sprite frames (this causes the animator to snap to that frame) if you leave it
## as linear (default), the animator will play ALL the frames in between so when looping back it will look janky

## You can put all reusable funcs in here such as HandleJump, HandleGravity etc, and just call them on the corresponding
## update function of each state that uses them, just make sure to call what you need, like gravity, inputs, jump etc
## also DONT forget to call MOVE_AND_SLIDE() at the end of any state that moves in its UPDATE function

## You dont need a HandleAnimations function, remember that when entering a state, you can just play the animation for
## that state once and the next state will automatically play theirs and so on

#region /// Player Variables
#Character Nodes
@onready var Sprite : Sprite2D = $Sprite2D
@onready var Normal_Collision : CollisionShape2D = $normal_collision
@onready var Sliding_Collision : CollisionShape2D = $sliding_collision
@onready var animationplayer : AnimationPlayer = $AnimationPlayer
@onready var States :  = $StateMachine
@onready var state_label: Label = $state_label


#Physics Variables
const Gravity : float = 600
@export var speed : float = 200.0 # Base horizontal movement speed
@export var dash_speed : float = 800.0 
@export var jump_velocity : float = -300.0 # Maximum jump strength
@export var dash_jump_velocity_x : float = 800.0
@export var dash_jump_velocity_y : float = -300 
@export var double_jump_velocity : float = -250

#Dash Variables
const dash_time: float = 2.0
var can_dash: bool = true
var is_dashing: bool = false
var can_dodge: bool = true
var dash_timer: float = 0.5
const slide_speed : float = 800.0
const slide_time: float = 0.12
var can_slide: bool = true #checks is sliding available
var is_sliding: bool = false #checks if sliding
var slide_timer: float = 0.0

## How hard it falls to land, play around with this and gravity to achieve the feel you wantd 
const hard_land_threshold: float = 400.0
var fall_velocity: float = 0.0

var move_speed = speed
var move_direction = 0
var has_double_jumped : bool = false
var facing = 1 

#Input Variables
var up : bool = false
var down : bool = false
var left : bool = false
var right : bool = false
var up_Pressed : bool = false
var down_Pressed : bool = false
var jump : bool = false
var jump_Pressed : bool = false
var ability: bool  = false
var ability_Pressed : bool = false
var shoot : bool = false
var shoot_Pressed: bool  = false
var oversoul : bool = false

# State Machine
var current_state : PlayerState = null
var previous_state : PlayerState = null

## Signals used in states
signal finished_landing

#endregion

#region /// Main Loop Functions

func _ready():
	#initialize state machine
	for state in States.get_children():
		if state is PlayerState:
			state.States = States
			state.Player = self
	previous_state = States.Fall
	current_state = States.Fall
	
	## ENTER the initial state!! (fall)
	current_state.EnterState()

func _physics_process(delta: float) -> void:
	## NOTE
	## Run the Update process of the active state!
	if current_state:
		state_label.text = current_state.name
		current_state.Update(delta)
		# Flip sprite
		if facing == 1:
			Sprite.flip_h = false
		else:
			Sprite.flip_h = true
			
	#_dash_logic(delta)
	#
		#if is_on_floor_only():
			#if dash_timer == 0.0:
				#can_dash = true
			

## NOTE this function ONLY changes a state from A to B, nothing else , UPDATE on each state handles the
## behaivour no need to do it here!
func ChangeState(new_state):
	if (new_state != null):
		previous_state = current_state
		current_state = new_state
		previous_state.ExitState()
		current_state.EnterState()
		## NOTE .name not Name, typo was causing this to be NULL
		print("State Change From: " + previous_state.name + " to: " + current_state.name)
	
	#endregion
	
#region /// Custom Functions
	
func GetInputStates():
	up = Input.is_action_pressed("up")
	up_Pressed = Input.is_action_just_pressed("up")
	down = Input.is_action_pressed("down")
	down_Pressed = Input.is_action_just_pressed("down")
	left = Input.is_action_pressed("left")
	right = Input.is_action_pressed("right")
	jump = Input.is_action_pressed("jump")
	jump_Pressed = Input.is_action_just_pressed("jump")
	ability = Input.is_action_pressed("ability")
	ability_Pressed = Input.is_action_just_pressed("ability")
	shoot = Input.is_action_pressed("shoot")
	shoot_Pressed = Input.is_action_just_pressed("shoot")
	
	if (right): facing = 1
	if (left): facing = -1
	
func HorizontalMovement():
	move_direction = Input.get_axis("left", "right")
	#velocity.x = move_toward(velocity.x, move_direction, speed)
	velocity.x = speed * move_direction

func HandleFall():
	if not is_on_floor():
		if velocity.y >= 0:
			ChangeState(States.Fall)

func HandleJump():
	if jump_Pressed:
		if is_on_floor():
			#normal jump
			ChangeState(States.Jump)
		else:
			#double jump in air
			if not has_double_jumped:
				ChangeState(States.Jump)
				has_double_jumped = true
		return

## Landing from a fall
func HandleFalltoLand():
	if is_on_floor():
		has_double_jumped = false
		## NOTE this is not neccesary depends on how you want land to behave, here for example, if youre falling
		## too fast, it will land, but if its a soft landing, it will idle instead
		print("Falling with velocity of ",fall_velocity)
		if fall_velocity > hard_land_threshold:
			ChangeState(States.Land)
		else:
			ChangeState(States.Idle)

func HandleDodge():
	if Input.is_action_just_pressed("ability") and can_dash:
		if velocity.is_zero_approx():
			can_dash = false
			dash_timer = dash_time
			velocity.x = dash_speed * -facing
			velocity.y = 0
			animationplayer.play("dodge")
		elif is_on_floor_only():
			if dash_timer == 0.0:
				can_dash = true

func HandleDash():
	if Input.is_action_just_pressed("ability") and can_dash:		
		can_dash = false
		dash_timer = dash_time
		velocity.x = dash_speed * facing
		velocity.y = 0
		animationplayer.play("dash")
	elif is_on_floor_only():
			if dash_timer == 0.0:
				can_dash = true
				#
#func HandleSlide():
	#if Input.is
			
			
				

func HandleGravity(delta):
	if (!is_on_floor()):
		velocity.y += Gravity * delta
		fall_velocity = velocity.y

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Land":
		finished_landing.emit()
	#restart timer

#endregion
	
