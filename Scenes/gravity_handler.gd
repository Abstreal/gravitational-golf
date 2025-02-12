extends Node2D

@onready var c_body_scene = preload("res://Scenes/c_body.tscn")
@export var G: float = 10

var cbodies: Array = Array()

func update_cbodies() -> void:
	cbodies = get_children()

func _ready() -> void:
	update_cbodies()

func get_accel(pos: Vector2, attr_pos: Vector2, attr_mass: float) -> Vector2:
	if pos == attr_pos:
		return Vector2()
	
	var r_vec: Vector2 = attr_pos - pos
	var r: float = r_vec.length()
	
	var Gm_w: float = G * attr_mass
	
	return Gm_w * (1/pow(r, 3)) * r_vec
	
func get_total_accel(cbody_i: int) -> Vector2:
	var total: Vector2 = Vector2()
	var rl = range(cbodies.size())
	for j in rl:
		total += get_accel(cbodies[cbody_i].global_position, cbodies[j].global_position, cbodies[j].mass)
	return total

func apply_accels(delta: float) -> void:
	for i in range(cbodies.size()):
		var accel = get_total_accel(i)
		cbodies[i].velocity += accel * delta

func handle_collision(x1, x2):
	var new_cbd = c_body_scene.instantiate()
	new_cbd.global_position = (x1.global_position * x1.mass + x2.global_position * x2.mass)/(x1.mass + x2.mass)
	new_cbd.mass = x1.mass + x2.mass
	new_cbd.velocity = (x1.velocity * x1.mass + x2.velocity * x2.mass)/(x1.mass + x2.mass)
	remove_child(x1)
	x1.queue_free()
	update_cbodies()
	remove_child(x2)
	x2.queue_free()
	update_cbodies()
	add_child(new_cbd)
	update_cbodies()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_accels(delta)
