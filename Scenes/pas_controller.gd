extends Node2D

@export var gravity_handler = self
@onready var c_body_scene = preload("res://Scenes/c_body.tscn")

signal pressed

func _on_pressed():
	var new_cbd = c_body_scene.instantiate()
	new_cbd.global_position = get_global_mouse_position()
	#new_cbd.mass = 2000
	gravity_handler.add_child(new_cbd)
	gravity_handler.update_cbodies()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click_or_tap"):
		pressed.emit()
