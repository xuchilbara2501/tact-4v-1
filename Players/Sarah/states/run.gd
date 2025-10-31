extends PlayerState

func EnterState():
	Name = "Run"
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update():
	#handle movements
	Player.HorizontalMovement()
	Player.HandleJump()
	Player.HandleFalling()
	
	HandleAnimations()
	HandleIdle()
	HandleDash()
	

func HandleIdle():
	if (Player.moveDirectionX == 0):
		Player.Changes(States.Idle)

func HandleDash():
	if Input.is_action_just_pressed("ability") and velocity.x != 0:
			can_dash = false
			dash_timer = dash_time
			velocity.x = dash_speed * look_dir_x
			velocity.y = 0
			AnimationPlayer.play("dash")
			

func HandleAnimations():
	Player.animationplayer.play("Run") 
	Player.HandleFlipH()
