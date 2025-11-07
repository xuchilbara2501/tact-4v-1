extends PlayerState

#Jump/Wall Jump State should handle double jump and air dash

func EnterState():
	name = "Jump"
	Player.velocity.y = Player.jump_velocity
	Player.animationplayer.play("jump") 

func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	Player.GetInputStates()
	Player.HandleJump()
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	Player.HandleDodge()
	
	Player.HandleFall()
	
	Player.move_and_slide()
