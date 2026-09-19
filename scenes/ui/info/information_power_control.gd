extends Control
@onready var txt_power: Label = $PanelContainer/MarginContainer/GridContainer/txtPower
@onready var txt_fuel: Label = $PanelContainer/MarginContainer/GridContainer/txtFuel
@onready var txt_energy: Label = $PanelContainer/MarginContainer/GridContainer/txtEnergy
@onready var txt_autonomy: Label = $PanelContainer/MarginContainer/GridContainer/txtAutonomy


func _on_power_generator_signal_update_status(power: bool, electrical_out: float, autonomy: float, fuel_level: float) -> void:
	txt_power.text = "ON" if power else "OFF"
	txt_energy.text = str(electrical_out)+str(" KWh")
	txt_fuel.text = str(fuel_level)+str(" %")
	txt_autonomy.text = str(autonomy)+str(" H")
