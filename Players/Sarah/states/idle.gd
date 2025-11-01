extends PlayerState

#Idle State
#Should handle "dodge" ability since 0 movement and can slide 
#Idle animation timeout timer?

func EnterState():
	pass
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	
	Player.HandleJump()
	Player.HorizontalMovement()
	
	if (Player.move_direction != 0):
		Player.ChangeState(States.Run)
	elif Input.is_action_pressed("jump"):
		Player.ChangeState(States.Jump)
		
	Player.move_and_slide()
	
	#HandleDodge()
	HandleAnimations()
	
#func HandleDodge()
	#if Input.is_action_just_pressed("ability") and velocity.is_zero_approx():
		#can_dash = false
		#dash_timer = dash_time
		#velocity.x = dash_speed * -move_direction
		#velocity.y = 0
		#Player.animationplayer.play("dodge") 
	

func HandleAnimations():
	Player.animationplayer.play("idle") 
