extends PlayerState

func EnterState():
	pass
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update():
	Player.HandleFalling()
	Player.HandleJump()
	Player.HorizontalMovement()
	if (Player.moveDirectionX != 0):
		Player.ChangeState(States.Run)
	
	#HandleDodge()
	HandleAnimations()
	
#func HandleDodge()
	#if Input.is_action_just_pressed("ability") and velocity.is_zero_approx():
		#can_dash = false
		#dash_timer = dash_time
		#velocity.x = dash_speed * -look_dir_x
		#velocity.y = 0
		#AnimationPlayer.play("dodge")
	

func HandleAnimations():
	Player.animationplayer.play("idle") 
	Player.HandleFlipH()
