
class_name PowerGenerator
extends NetworkSource

@onready var tile_map: TileMapLayer = $"../../../NetworkRenderer/TileMap"

@onready var information_power_control: Control = $InformationPowerControl
@onready var timer_consumption: Timer = $TimerConsumption
@onready var power_switch: CheckButton = $PowerSwitch

var connected_devices: int = 0
var consumption_devices: float = 0

var is_power_on: bool = false:
	set(value):
		is_power_on = value
		is_active = value
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

signal signal_update_status(
	power: bool,
	electrical_out: float,
	autonomy: float,
	fuel_level: float
)


func _ready() -> void:
	print("===== POWER GENERATOR READY =====")
	print("Nombre: ", name)
	#print("Tipo de objeto: ", get_class())
	#print("NetworkManagerGlobal: ", NetworkManagerGlobal)
	
	network_type = NetworkTypes.Type.POWER
	var coordenada: Vector2i = tile_map.local_to_map(
		tile_map.to_local(global_position)
	)
	connection_position = coordenada
	print("Coordenada del generador: ", connection_position)
	#print("Antes de registrar fuente")
	NetworkManagerGlobal.register_source(self)
	#print("Después de registrar fuente")
	

func powerOn() -> void:
	if is_power_on:
		return
	print("Generador Encendido")
	is_power_on = true
	timer_consumption.start()
	NetworkManagerGlobal.recalculate_power()


func powerOff() -> void:
	if not is_power_on:
		return
	print("Generador Apagado")
	timer_consumption.stop()
	is_power_on = false
	NetworkManagerGlobal.recalculate_power()


func _on_power_switch_toggled(toggled_on: bool) -> void:
	if toggled_on:
		powerOn()
	else:
		powerOff()


func _on_detection_area_input_event(viewport: Node,event: InputEvent,shape_idx: int) -> void:
	if event.is_action_pressed("clic_left"):
		information_power_control.visible = !information_power_control.visible


func _on_timer_consumption_timeout() -> void:
	fuel_level -= 1.5
	if is_power_on and fuel_level <= 0:
		fuel_level = 0.0
		power_switch.set_pressed(false)
		powerOff()


func update_status() -> void:
	signal_update_status.emit(
		is_power_on,
		electrical_output,
		autonomy,
		fuel_level
	)
