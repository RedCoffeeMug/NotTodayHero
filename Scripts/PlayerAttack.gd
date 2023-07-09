extends Area2D

func _ready():
	hide()
	$CollisionShape2D.disabled = true

func _unhandled_input(event):
	if Input.is_action_just_released("player_attack"):
		show()
		$CollisionShape2D.disabled = false
		$AttackTimer.start()


func _on_AttackTimer_timeout():
	hide()
	$CollisionShape2D.disabled = true


func _on_AttackArea_area_entered(area):
	Playervars.enemyhealth -= 2
	$EnemyHurt.play()
