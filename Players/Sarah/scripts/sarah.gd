extends CharacterBody2D
class_name player_character

#region /// Player Variables
#Character Nodes
@onready var Sprite : Sprite2D = $Sprite2D
@onready var Normal_Collision : CollisionShape2D = $normal_collision
@onready var Sliding_Collision : CollisionShape2D = $sliding_collision
@onready var animationplayer : AnimationPlayer = $AnimationPlayer
@onready var States :  = $StateMachine

#Physics Variables
const Gravity = 300
@export var speed : float = 200.0 # Base horizontal movement speed
@export var dash_speed : float = 800.0 
@export var jump_velocity : float = -350.0 # Maximum jump strength
@export var dash_jump_velocity_x : float = 800.0
@export var dash_jump_velocity_y : float = -300 
@export var double_jump_velocity : float = -250

var move_speed = speed
var can_dash : bool = false
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
	
	## Enter the initial STate!! 
	current_state.EnterState()
	
#func _draw():
	#current_state.Draw()
	
func _physics_process(delta: float) -> void:
	
	## NOTE
	## Run the Update process of the active state!
	if current_state:
		current_state.Update(delta)
	
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_velocity
#
	## Get the input direction and handle the movement/deceleration.
	#var direction := Input.get_axis("left", "right")
	#if direction:
		#velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		#
	#move_and_slide()
		
func ChangeState(new_state):
	if (new_state != null):
		previous_state = current_state
		current_state = new_state
		previous_state.ExitState()
		current_state.EnterState()
		print("State Change From: " + previous_state.name + " to: " + current_state.name)
		
		
	#GetInputStates()
		#
	##Handles Horizontal Movement
	#HorizontalMovement()
	#
	##Handle Gravity
	##HandleGravity(delta)
	#
	##handle Jumps
	#HandleJump()
	#
	##Update current state
	#current_state.Update()
	#
	##Commit Movements
	#move_and_slide()
	#
	##Handle Animaitons
	#HandleAnimation()
	
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
	
	if velocity.x:
		$Sprite2D.flip_h = velocity.x < 0

func HandleJump():
	if (jump_Pressed):
		if is_on_floor():
			#normal jump
			velocity.y = jump_velocity
		elif not has_double_jumped:
			#double jump in air
			velocity.y = double_jump_velocity 
			has_double_jumped = true

func HandleLanding():
	if (is_on_floor()):
		has_double_jumped = false
		ChangeState(States.Idle)

func HandleGravity(delta):
	if (!is_on_floor()):
		velocity.y += Gravity * delta

func HandleAnimation():
	#Flip the sprite
	Sprite.flip_h = (facing < 0)
	
	if(is_on_floor()):
		if (velocity.x !=0):
			animationplayer.play("run")
		else: 
			animationplayer.play("idle")
	
		
	else:
		if (velocity.y < 0):
			animationplayer.play("jump")
		else:
			animationplayer.play("falling")
			
	
func _on_idle_timeout_timeout():
	#When the timer times out, play the second idle animation
	animationplayer.play("idle_timeout")


func _on_animation_player_animation_finished(anim_name):
	#If the secondary idle animation finishes, return to default idle
	if anim_name == "idle_timeout":
		animationplayer.play("idle")
	#restart timer
	
#endregion
	
