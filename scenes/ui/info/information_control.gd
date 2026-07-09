extends Control

@onready var txt_status: Label = $PanelContainer/MarginContainer/GridContainer/txtStatus

func _on_pc_signal_status_info(power: bool) -> void:
	txt_status.text = "ON" if power else "OFF"
