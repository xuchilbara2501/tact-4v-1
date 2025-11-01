extends PlayerState

@export var dash_speed : float = 800.0 
var can_dash : bool = false

#main movement state, should hand "dash" and "slide" - shoudln't need dodge bnecause dodge is no x movement input?

func EnterState():
	Name = "Run"
	
func ExitState():
	pass
	
func Draw():
	pass
	
func Update(delta: float):
	#handle movements
	Player.HorizontalMovement()
	Player.HandleJump()
	Player.HandleGravity(delta)
	
	HandleAnimations()
	HandleIdle()
	#HandleDash()
	
	Player.move_and_slide()
	
func HandleIdle():
	if (Player.move_direction == 0):
		Player.ChangeState(States.Idle)
	elif Input.is_action_just_pressed("jump"):
		Player.velocity.y = Player.jump_velocity
		Player.ChangeState(States.Jump)

#func HandleDash():
	#if Input.is_action_just_pressed("ability"):
		#can_dash = false
		#dash_timer = dash_time
		#velocity.x = dash_speed * move_direction
		#velocity.y = 0
		#Player.animationplayer.play("dash") 
			

func HandleAnimations():
	Player.animationplayer.play("run") 
