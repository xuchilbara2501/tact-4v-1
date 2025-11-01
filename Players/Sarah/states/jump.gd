extends PlayerState

const Gravity = 300
@export var double_jump_velocity : float = -250
var has_double_jumped = false
#Jump/Wall Jump State should handle double jump and air dash

func EnterState():
	name = "jump"
	Player.velocity.y = Player.jump_velocity
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	Player.HandleJump()
	
	HandleJumpToFall()
	HandleAnimations()
	#HandleDoubleJump()
	#HandleAirDash()
	Player.move_and_slide()
	
#func state_input(event : InputEvent):
	#if(event.is_action_pressed("jump") && !has_double_jumped):
		#Player.velocity.y = double_jump_velocity 
		#has_double_jumped = true
		#Player.animationPlayer.play("double_jump")
			
##Func HandleAirDash()
	#if Input.is_action_just_pressed("ability") and velocity.x != 0:
			#can_dash = false
			#dash_timer = dash_time
			#velocity.x = dash_speed * movement_directionx
			#velocity.y = 0
			#Player.animationPlayer.play("dash")
	
func HandleJumpToFall():
	if (Player.velocity.y >= 0):
		Player.ChangeState(States.Fall)
				
func HandleAnimations():
	Player.animationplayer.play("jump") 
