class_name Pc

extends RigidBody2D

@onready var information_control: Control = $InformationControl
@onready var loading_time: Timer = $LoadingTime


var is_power_on:bool = false
var is_connect_to_internet:bool = false
var is_connect_to_power_supply: bool = false

signal update_data (cpu_ghz,temperature, watts)
signal signal_status_info(power:bool,status:String)

var status: String = "OFF":
	set(value):
		status = value
		update_status()

var cpu_ghz: float = 0.0:
	set(value):
		cpu_ghz = value
		update()

var cpu_used: float = 0:
	set(value):
		cpu_used = value
		update()

var temperature: float = 0.0:
	set(value):
		temperature = value
		update()

var watts_consumption: float = 0.0:
	set(value):
		watts_consumption = value
		update()


func power_sw():
	if not is_power_on:
		powerOn()
	else:
		powerOff()


func _on_button_pressed() -> void:
	power_sw()
	print(is_power_on)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("clic"):
		information_control.visible = !information_control.visible
		

func powerOn():
	if not is_connect_to_power_supply:
		status = "power is out"
		update_status()
		return 
	
	status = "Loading"
	update_status()
	await get_tree().create_timer(3.0).timeout
	is_power_on = true
	loading_time.start()
	status = "Starte"
	if is_connect_to_internet:
		status = "Oneline"

func powerOff():
	loading_time.stop()
	status = "Turn off"
	update_status()
	await get_tree().create_timer(3.0).timeout
	is_power_on = false
	cpu_used = 0.0
	temperature = 0.0
	status = "OFF"
	update_status()


func  update_status():
	signal_status_info.emit(is_power_on,status)

func update():
	update_data.emit(cpu_ghz,cpu_used,temperature,watts_consumption)

func running():
	cpu_used = randi_range(1, 5)
	temperature = randi_range(30, 35)


func _on_loading_time_timeout() -> void:
	running()


func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("power_line"):
		is_connect_to_power_supply = true
	if area.is_in_group("ethernet_line"):
		is_connect_to_internet = true
