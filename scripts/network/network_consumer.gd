class_name NetworkConsumer
extends Node2D

var network_type: NetworkTypes.Type
var has_power: bool = false

@export var connection_position: Vector2i


func set_power_state(powered: bool) -> void:
	has_power = powered
