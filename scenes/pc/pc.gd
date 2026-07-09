class_name Pc

extends RigidBody2D
@onready var information_control: Control = $InformationControl

var is_power_on:bool = false
var is_connect_to_internet:bool = true
var is_connect_to_power_supply: bool = true
var temperature: float = 0
@export var watts_consumption: int = 60

signal signal_status_info(power:bool)

func power_sw():
	if not is_power_on:
		is_power_on = true if is_connect_to_power_supply and is_connect_to_internet else false
	else:
		is_power_on = false
	
	signal_status_info.emit(is_power_on)


func _on_button_pressed() -> void:
	power_sw()
	print(is_power_on)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("clic"):
		print("clic en la pc")
		information_control.visible = !information_control.visible
