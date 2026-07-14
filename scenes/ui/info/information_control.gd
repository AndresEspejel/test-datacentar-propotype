extends Control

@onready var txt_power: Label = $PanelContainer/MarginContainer/GridContainer/txtPower
@onready var txt_status: Label = $PanelContainer/MarginContainer/GridContainer/txtStatus
@onready var txt_energy: Label = $PanelContainer/MarginContainer/GridContainer/txtEnergy
@onready var txt_cpu: Label = $PanelContainer/MarginContainer/GridContainer/txtCpu

@onready var pc_temperature: Label = $PanelContainer/MarginContainer/GridContainer/txtTemperature
@onready var txt_cpu_used: Label = $PanelContainer/MarginContainer/GridContainer/txtCpuUsed




func _on_pc_signal_status_info(power: bool,status:String) -> void:
	txt_power.text = "ON" if power else "OFF"
	txt_status.text = str(status)
	update_color_status(power,status)


func _on_pc_update_data(cpu_ghz: float,cpu_used:float, temperature: float, watts: float,) -> void:
	txt_cpu.text = str(cpu_ghz) + str(" GHz")
	txt_energy.text = str(watts)+ str(" KWh")
	pc_temperature.text = str(temperature)+ str(" °C")
	txt_cpu_used.text = str(cpu_used)+ str(" %")
	update_color_running(cpu_used,temperature)



func update_color_status(power: bool,status:String):
	print("Reporte estatus")
	if  status == "Starte":
		txt_power.modulate = Color.GREEN
		txt_status.modulate = Color.ORANGE
		return
	if status == "Oneline":
		txt_power.modulate = Color.GREEN
		txt_status.modulate = Color.GREEN
		return
	else:
		txt_power.modulate = Color.WHITE
		txt_status.modulate = Color.WHITE
	return

func update_color_running(cpu_used,temperature):

	match temperature:
		var t when t > 1 and t <= 35:
			pc_temperature.modulate = Color.AQUA
		var t when t > 36 and t <= 75:
			pc_temperature.modulate = Color.GREEN
		var t when t > 76 and t <= 90:
			pc_temperature.modulate = Color.YELLOW
		var t when t > 91:
			pc_temperature.modulate = Color.RED

	match cpu_used:
		var cpu when cpu > 1 and cpu <= 5 :
			txt_cpu_used.modulate = Color.AQUA
		var cpu when cpu > 6 and cpu <= 80 :
			txt_cpu_used.modulate = Color.GREEN
		var cpu  when cpu > 81 and cpu <= 90 :
			txt_cpu_used.modulate = Color.YELLOW
		var cpu when cpu > 91:
			txt_cpu_used.modulate = Color.RED

	if cpu_used == 0 and temperature == 0:
		pc_temperature.modulate = Color.WHITE
		txt_cpu_used.modulate = Color.WHITE
