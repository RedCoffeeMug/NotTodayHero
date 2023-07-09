extends KinematicBody2D


#movement vars
var speed = 200
var velocity = Vector2()
#animation
onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	pass


func _physics_process(delta):
	handle_input()

func handle_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		state_machine.travel("walk")
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		state_machine.travel("walk")
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		state_machine.travel("walk")
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		state_machine.travel("walk")
	velocity.normalized()
	move_and_slide(velocity * speed)
	if move_and_slide(velocity).x == 0 and move_and_slide(velocity).y == 0:
		state_machine.travel("idle")


