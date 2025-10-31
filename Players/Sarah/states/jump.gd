extends PlayerState

#Jump/Wall Jump State should handle double jump and air dash

func EnterState():
	name = "Jump"
	Player.velocity.y = Player.jump_velocity
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update():
	Player.HandleGravity()
	Player.HorizontalMovement()
	
	HandleJumpToFall()
	HandleAnimations()
	
func HandleJumpToFall():
	if (Player.velocity.y >= 0):
		Player.ChangeState(States.Fall)
		
func HandleAnimations():
	Player.animationplayer.play("jump") 
	Player.HandleFlipH()
