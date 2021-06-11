extends Control

onready var health_bar = get_node("heathBar")
onready var timer = get_node("Timer")

func on_health_updated(health, amount):
	health_bar.value = health
	
func on_max_health_updated(max_health):
	health_bar.max_value = max_health

func on_Timer_timeout():
	health_bar.value -= 5
