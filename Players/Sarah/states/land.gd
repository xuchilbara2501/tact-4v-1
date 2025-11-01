extends PlayerState

#resets back to the grounded states...may need animation lock?


func EnterState():
	name = "Land"
	## You only need to play non loop anims when entering the state
	Player.animationplayer.play("Land")

func ExitState():
	pass
	
func Draw():
	pass
	
func Update(_delta: float):
	#Player.HandleIdle()
	## Maybe cannot move while landing?
	#Player.HorizontalMovement()
	
	## This is not ideal but it works, as long as no other animation besides lands can play here, its good
	await Player.finished_landing
	
	if (Player.move_direction != 0):
		Player.ChangeState(States.Run)
	elif (Player.move_direction == 0):
		Player.ChangeState(States.Idle)
