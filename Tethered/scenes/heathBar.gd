extends TextureProgress

onready var health_bar = $heathBar
onready var update_tween = $UpdateTween
func on_health_updated(health, amount):
	health_bar.value = health
	update_tween.interpolate_property(health_bar, "value", health_bar.value, health,0.4, Tween.EASE_IN_OUT)
	update_tween.start()
func on_heath_health_updated(max_health):
	health_bar.max_value = max_health
	
func _on_Timer_timeout():
	pass
	
