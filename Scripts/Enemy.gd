extends KinematicBody2D

export var path_to_player := NodePath()

var _velocity := Vector2.ZERO

onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _player := get_node(path_to_player)
onready var _timer: Timer = $UpdatePathfinding

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")


func _ready() -> void:
	_update_pathfinding()
	_timer.connect("timeout", self, "_update_pathfinding")


func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		return
	
	var direction := global_position.direction_to( _agent.get_next_location())
	
	var desired_velocity := direction * 20.0
	var steering := (desired_velocity - _velocity) * delta * 4.0
	_velocity += steering
	
	_velocity = move_and_slide(_velocity)
	
	#animation
	if move_and_slide(_velocity).x == 0 and move_and_slide(_velocity).y == 0:
		state_machine.travel("idle")
	if move_and_slide(_velocity).x < 0:
		state_machine.travel("walk_left")
	if move_and_slide(_velocity).x > 0:
		state_machine.travel("walk_right")

func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)



func _on_PlayerDetector_body_entered(body):
	Playervars.playerhealth -= 5
	$PlayerDetectorTimer.start()
	$"../../Hurt".play()




func _on_PlayerDetector_body_exited(body):
	$PlayerDetectorTimer.stop()


func _on_PlayerDetectorTimer_timeout():
	Playervars.playerhealth -= 5
	$"../../Hurt".play()

