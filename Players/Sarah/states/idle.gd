extends PlayerState

#Idle State
#Should handle "dodge" ability since 0 movement and can clide 
#Idle animation timeout timer?

func EnterState():
	Player.animationplayer.play("idle") 
	pass
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	Player.GetInputStates()
	Player.HandleJump()
	Player.HorizontalMovement()
	if (Player.move_direction != 0):
		Player.ChangeState(States.Run)
	
	Player.HandleFall()
	#HandleDodge()

#func HandleDodge()
	#if Input.is_action_just_pressed("ability") and velocity.is_zero_approx():
		#can_dash = false
		#dash_timer = dash_time
		#velocity.x = dash_speed * -look_dir_x
		#velocity.y = 0
		#AnimationPlayer.play("dodge")

func _on_idle_timeout_timeout() -> void:
	
	pass # Replace with function body.
