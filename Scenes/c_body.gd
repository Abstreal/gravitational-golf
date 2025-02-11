extends CharacterBody2D

@export var mass: float = 1
@export var initial_vel: Vector2 = Vector2()

func _ready():
	velocity += initial_vel

func _physics_process(delta: float) -> void:

	move_and_slide()
	#print(velocity.length())
	
