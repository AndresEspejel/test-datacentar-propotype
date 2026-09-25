class_name Pc
extends NetworkConsumer

@onready var information_control: Control = $InformationControl
@onready var loading_time: Timer = $LoadingTime
@onready var tile_map: TileMapLayer = $"../../../NetworkRenderer/TileMap"


var is_power_on:bool = false
var is_connect_to_internet:bool = false

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

func _ready() -> void:
	network_type = NetworkTypes.Type.POWER
	var coordenada: Vector2i = tile_map.local_to_map(
		tile_map.to_local(global_position)
	)
	connection_position = coordenada
	NetworkManagerGlobal.register_consumer(self)

func power_sw():	
	if not is_power_on:
		powerOn()
	else:
		powerOff()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("clic_left"):
		information_control.visible = !information_control.visible


func set_power_state(powered: bool) -> void:
	if has_power == powered:
		return
	has_power = powered
	if has_power:
		print("PC: "+str(name)+": Energía recibida")
	else:
		powerOff()
		print("PC: "+str(name)+": Sin energía")

func powerOn():
	if not has_power:
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
		status = "Online"

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


func _on_io_pressed() -> void:
	power_sw()
	
