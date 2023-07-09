extends Node2D

func _ready():
	set_health_bar()
	$PlayerHealth.max_value = Playervars.MAX_HEALTH
	$EnemyHealth.max_value = Playervars.MAX_ENEMY_HEALTH

func _process(delta):
	if $Music.playing == false:
		$Music.play()

func set_health_bar() -> void:
	$PlayerHealth.value = Playervars.playerhealth
	$EnemyHealth.value = Playervars.enemyhealth


func _on_UpdateHealth_timeout():
	set_health_bar()
	if Playervars.playerhealth <= 0:
		SceneTransition.change_scene("res://Scenes/GameOver.tscn")
		$DeathSound.play()
	if Playervars.enemyhealth <= 0:
		SceneTransition.change_scene("res://Scenes/Victory.tscn")
		$DeathSound.play()
