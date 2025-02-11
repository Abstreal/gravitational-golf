extends Node2D

@export var G: float = 10

var cbodies: Array = Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cbodies = get_children()

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

func apply_accels() -> void:
	for i in range(cbodies.size()):
		var accel = get_total_accel(i)
		cbodies[i].velocity += accel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	apply_accels()
