extends Control

onready var damageTick = 5
onready var timer = get_node("Timer")
onready var hitbox = get_node("hitbox")
onready var health_bar = get_node("heathBar")

func on_health_updated(health, amount):
	health_bar.value = health
	
func on_max_health_updated(max_health):
	health_bar.max_value = max_health

func on_Timer_timeout():
	pass
	#hitbox.get_shape().set_extents(Vector2(hitbox.get_shape().extents.x-damageTick *2, hitbox.get_shape().extents.y))
	#hitbox.position.x -= damageTick *2
	#health_bar.value -= damageTick
	
