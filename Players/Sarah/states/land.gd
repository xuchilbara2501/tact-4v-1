extends PlayerState

#resets back to the grounded states...may need animation lock?

func EnterState():
	name = "Land"

func ExitState():
	pass
	
func Draw():
	pass
	
func Update(_delta: float):
	#Player.HandleIdle()
	Player.HorizontalMovement()
	if (Player.move_direction != 0):
		Player.ChangeState(States.Run)
	elif (Player.move_direction == 0):
		Player.ChangeState(States.Idle)
	
	HandleAnimations()
	
func HandleAnimations():
	Player.animationplayer.play("Land") 
	#Player.HandleFlipH()
