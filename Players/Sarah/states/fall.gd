extends PlayerState

func EnterState():
	name = "Fall"

func ExitState():
	pass
	
func Draw():
	pass
	
func Update():
	Player.HandleGravity()
	Player.HorizontalMovement()
	Player.HandleLanding()
	
	HandleAnimations()
	HandleFalltoLand()
	
func HandleFalltoLand():
	if (Player.is_on_floor()):
		Player.ChangeState(States.Land)
	
func HandleAnimations():
	Player.animationplayer.play("Fall") 
	Player.HandleFlipH()
