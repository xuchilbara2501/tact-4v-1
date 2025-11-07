extends PlayerState

#main movement state, should hand "dash" and "slide" - shoudln't need dodge bnecause dodge is no x movement input?

func EnterState():
	Name = "Run"
	Player.animationplayer.play("run")
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	#handle movements
	Player.GetInputStates()
	Player.HorizontalMovement()
	Player.HandleJump()
	Player.HandleDash()
	## Same as gravity??
	
	Player.HandleFall()
	Player.HandleGravity(delta)
	
	## Some animation names are wrong? check them all
	#HandleAnimations()
	HandleIdle()
	#Player.HandleDash()
	## NOTE
	## DONT forget to call move and slide on the update!
	Player.move_and_slide()
	

func HandleIdle():
	if (Player.move_direction == 0):
		Player.ChangeState(States.Idle)
