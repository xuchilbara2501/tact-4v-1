extends PlayerState

#When not jumping and falling

func EnterState():
	name = "Fall"
	print("Started falling!dad")

func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	Player.HandleGravity(delta)
	Player.HorizontalMovement()
	Player.HandleLanding()
	
	HandleAnimations()
	HandleFalltoLand()
	Player.move_and_slide()

func HandleFalltoLand():
	if (Player.is_on_floor()):
		Player.ChangeState(States.Land)
	
func HandleAnimations():
	Player.animationplayer.play("falling") 
	#Player.HandleFlipH()
