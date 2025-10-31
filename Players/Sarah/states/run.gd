extends PlayerState

#main movement state, should hand "dash" and "slide" - shoudln't need dodge bnecause dodge is no x movement input?

func EnterState():
	Name = "Run"
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	#handle movements
	Player.HorizontalMovement()
	Player.HandleJump()
	## Same as gravity??
	#Player.HandleFalling()
	Player.HandleGravity(delta)
	
	## Some animation names are wrong? check them all
	HandleAnimations()
	HandleIdle()
	#HandleDash()
	## NOTE
	## DONT forget to call move and slide on the update!
	Player.move_and_slide()
	

func HandleIdle():
	if (Player.move_direction == 0):
		Player.ChangeState(States.Idle)

##func HandleDash():
	#if Input.is_action_just_pressed("ability") and velocity.x != 0:
			#can_dash = false
			#dash_timer = dash_time
			#velocity.x = dash_speed * look_dir_x
			#velocity.y = 0
			#AnimationPlayer.play("dash")
			

func HandleAnimations():
	Player.animationplayer.play("run") 
	#Player.HandleFlipH()
