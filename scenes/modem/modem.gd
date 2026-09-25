class_name Modem
extends NetworkConsumer

@onready var loading_time: Timer = $LoadingTime
@onready var tile_map: TileMapLayer = $"../../../NetworkRenderer/TileMap"

var connected_devices: int = 0
var consumption_devices: float = 0

var status: String = "OFF":
	set(value):
		status = value

var ethernet_output: float = 0.0:
	set(value):
		ethernet_output = value


func power_sw():	
	if not has_power:
		powerOn()
	else:
		powerOff()

func powerOn():
	if not has_power:
		status = "power is out"
		return 
	status = "Loading"
	await get_tree().create_timer(3.0).timeout
	has_power = true
	loading_time.start()
	status = "Online"

func powerOff():
	loading_time.stop()
	status = "Turn off"
	await get_tree().create_timer(3.0).timeout
	has_power = false
	status = "OFF"


func set_power_state(powered: bool) -> void:
	if has_power == powered:
		return
	has_power = powered
	if has_power:
		print("Modem: "+str(name)+": Energía recibida")
	else:
		powerOff()
		print("Modem: "+str(name)+": Sin energía")

func _on_power_pressed() -> void:
	power_sw()
