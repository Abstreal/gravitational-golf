extends CharacterBody2D

@export var mass: float = 2000
@export var density: float = 1
@export var initial_vel: Vector2 = Vector2()

const PI = 3.141592

func _ready():
	velocity += initial_vel

func _physics_process(delta: float) -> void:
	
	var radius: float = sqrt(mass/(PI * density))
	$CollisionShape2D.shape.radius = radius
	$Polygon2D.scale = Vector2(1, 1) * radius/10
	
	var collision_data = move_and_collide(velocity)
	
	if collision_data != null:
		get_parent().handle_collision(self, collision_data.get_collider())
