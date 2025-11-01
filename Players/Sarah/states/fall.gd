extends PlayerState

#When not jumping and falling

func EnterState():
	name = "Fall"
	Player.animationplayer.play("falling") 

func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	Player.GetInputStates()
	Player.HandleJump()
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	Player.HandleFalltoLand()
	
	Player.HandleFalltoLand()
	Player.move_and_slide()
