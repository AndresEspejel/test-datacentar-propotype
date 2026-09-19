class_name PowerGenerator
extends Node2D

@onready var information_power_control: Control = $InformationPowerControl
@onready var timer_consumption: Timer = $TimerConsumption
@onready var power_switch: CheckButton = $PowerSwitch


var is_power_on:bool = false:
	set(value):
		is_power_on = value
		update_status()

var electrical_output: float = 0.0:
	set(value):
		electrical_output = value
		update_status()

var autonomy: float = 0.0:
	set(value):
		autonomy = value
		update_status()

var fuel_level: float = 0.0:
	set(value):
		fuel_level = value
		update_status()


signal  signal_update_status(power:bool,electrical_out:float,autonomy:float,fuel_level:float)

func powerOn() -> void:
	print("Encendido")
	is_power_on = true
	timer_consumption.start()
	
	
func powerOff() -> void:
	print("Apagado")
	timer_consumption.stop()
	is_power_on = false
	
	

func _on_power_switch_toggled(toggled_on: bool) -> void:
	if toggled_on:
		powerOn()
	else:
		powerOff()
		


func _on_detection_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("clic_left"):
		information_power_control.visible = !information_power_control.visible


func _on_timer_consumption_timeout() -> void:
	if is_power_on == true and fuel_level > 0:
		fuel_level -= 10
	else:
		power_switch.set_pressed(false)
		powerOff()

func update_status():
	signal_update_status.emit(is_power_on,electrical_output,autonomy,fuel_level)
