extends KinematicBody2D
export (int) var HP = 100
export (int) var acceleration = 40 
export (int) var maxSpeed = 300
export (int) var gravity = 35
export (int) var jumpForce = 600
export (int) var maxFallSpeed = 1000
var staticSword = preload("res://scenes/StaticBody2D.tscn")
var SwordInstance = null
var up = Vector2(0,-1)
var velocity = Vector2.ZERO
var facingRight = true
var isSpawned = false
var isIdle = true
var STATE = UIMODE
var LASTSTATE = 0

enum {UIMODE, HEALMODE,SWORDMODE, IDLE, SHIELDMODE, PLACEMODE, THROWMODE, ATTACKMODE}

func stateChoice():
	if Input.is_action_just_pressed("heal") && isSpawned == false:
		STATE = HEALMODE
		print(STATE)
		$AnimationPlayer.play("SwordShove")
		isSpawned == true	
	if Input.is_action_just_pressed("attackMode"):
		STATE = SWORDMODE
		print(STATE)
		if isSpawned == true:
			SwordInstance.queue_free()
		isSpawned = false
	if Input.is_action_just_pressed("attack") && STATE == SWORDMODE :
		print(STATE)
		print("debug")
		$AnimationPlayer.play("attack")
		
	#if Input.is_action_just_pressed("shield"):
		#STATE = SHIELDMODE
		
		#isSpawned = false
		#print(STATE)
	
func staticSwordSpawn():
	
	if facingRight == true:
		isSpawned = true
		SwordInstance = staticSword.instance()
		SwordInstance.position = get_node("SwordShoveSpawnLeft").get_global_position()
		get_parent().add_child(SwordInstance)
	else:
		isSpawned = true
		SwordInstance = staticSword.instance()
		SwordInstance.position = get_node("SwordShoveSpawnRight").get_global_position()
		get_parent().add_child(SwordInstance)
	
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
	if HP <= 0:
		die()
		
func die():
		get_tree().reload_current_scene()
		var hitbox = get_node("/root/mainscene/player/heath/hitbox")
		hitbox.get_shape().set_extents(Vector2(200,27.162))
		
func realMovement(delta):
	if facingRight == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	velocity.y += + gravity
	if velocity.y > maxFallSpeed:
		velocity.y = maxFallSpeed
	
	if Input.is_action_pressed("right"):
		facingRight = true
		velocity.x += acceleration
		$AnimationPlayer.play("move")
	elif Input.is_action_pressed("left"):
		facingRight= false
		velocity.x -= acceleration
		$AnimationPlayer.play("move")
	else:
		velocity.x = lerp(velocity.x,0,0.2)
		STATE = IDLE
		
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jumpForce
	else:
		$AnimationPlayer.play("jump")
	velocity.x = clamp(velocity.x, - maxSpeed, maxSpeed)
	velocity = move_and_slide(velocity,up)
	
func _physics_process(delta):
	#print(isSpawned)
	stateChoice()
	realMovement(delta)
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SwordShove":
		staticSwordSpawn()
		$AnimationPlayer.play("idle")
	if anim_name == "attack":
		#staticSwordSpawn()
		$AnimationPlayer.play("idle")
	
