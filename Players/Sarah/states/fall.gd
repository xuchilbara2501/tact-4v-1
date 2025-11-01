extends PlayerState

#const Gravity = 300
#@export var double_jump_velocity : float = -250
#var has_double_jumped = false
#When not jumping and falling

func EnterState():
	name = "fall"

func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	#Player.HandleDoubleJump()
	Player.HandleLanding()
	
#func state_input(event : InputEvent):
	#if(event.is_action_pressed("jump") && !has_double_jumped):
		#Player.velocity.y = double_jump_velocity 
		#has_double_jumped = true
		#Player.animationPlayer.play("double_jump")
	
	HandleAnimations()
	HandleFalltoLand()
	

		
	Player.move_and_slide()
	
func HandleFalltoLand():
	if (Player.velocity.y == 0):
		Player.ChangeState(States.Land)
	
func HandleAnimations():
	Player.animationplayer.play("falling") 
