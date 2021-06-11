extends KinematicBody2D
export (int) var HP = 100
export (int) var acceleration = 40 
export (int) var maxSpeed = 300
export (int) var gravity = 35
export (int) var jumpForce = 600
export (int) var maxFallSpeed = 1000
var up = Vector2(0,-1)
var velocity = Vector2.ZERO

func movement(delta):
	var direction = Vector2.ZERO
	direction .x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction = direction.normalized()
	velocity.y = velocity.y + gravity
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction*maxSpeed,acceleration*delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration*delta)
	if Input.is_action_just_pressed("jump"):
		velocity.y = jumpForce
	
	velocity = move_and_slide(velocity)

func updateUI():
	var hitbox = get_node("/root/mainscene/player/heath/hitbox")
	var health_bar = get_node("/root/mainscene/player/heath/heathBar")
	var damageTick = 5
	
	hitbox.get_shape().set_extents(Vector2(hitbox.get_shape().extents.x-damageTick *2, hitbox.get_shape().extents.y))
	hitbox.position.x -= damageTick *2
	health_bar.value -= damageTick
func takeDamage():
	HP -= 5;
	print(HP)	
func realMovement(delta):
	velocity.y += + gravity
	if velocity.y > maxFallSpeed:
		velocity.y = maxFallSpeed
	if Input.is_action_pressed("right"):
		velocity.x += acceleration
	elif Input.is_action_pressed("left"):
		velocity.x -= acceleration
	else:
		velocity.x = lerp(velocity.x,0,0.2)
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jumpForce
	velocity.x = clamp(velocity.x, - maxSpeed, maxSpeed)
	velocity = move_and_slide(velocity,up)
	
func _physics_process(delta):
	realMovement(delta)
