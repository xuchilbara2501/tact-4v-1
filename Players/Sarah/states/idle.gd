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
	Player.HandleDodge()	
	Player.HandleFall()
	Player.move_and_slide()


func _on_idle_timeout_timeout() -> void:
	
	pass # Replace with function body.
