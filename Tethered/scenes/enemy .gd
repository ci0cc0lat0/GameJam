extends Area2D

export var speed = 100
export var moveDistance = 100

onready var startX = position.x 
onready var targetX = position.x + moveDistance

func _process(delta):
	position.x = move_to(position.x, targetX, speed*delta)
	if position.x == targetX:
		if targetX == startX:
			targetX = position.x+ moveDistance
		else:
			targetX = startX

func move_to(current, to, step):
	var new = current
	if new < to: 
		new += step
		if new > to:
			new = to
	else:
		new -= step
		if new < to:
			new = to
	return new

func _on_enemy__body_entered(body):
	if body.name == "player":
		body.updateUI()
		body.takeDamage()
