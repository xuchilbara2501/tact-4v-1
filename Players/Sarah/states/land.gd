extends PlayerState

func EnterState():
	name = "Land"

func ExitState():
	pass
	
func Draw():
	pass
	
func Update():
	Player.HandleIdle()
	Player.HorizontalMovement()
	if (Player.moveDirectionX != 0):
		Player.ChangeState(States.Run)
	elif (Player.moveDirectionX == 0):
		Player.ChangeState(States.Idle)
	
	HandleAnimations()
	
func HandleAnimations():
	Player.animationplayer.play("Land") 
	Player.HandleFlipH()
