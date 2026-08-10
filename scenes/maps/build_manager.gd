class_name BuildManager
extends Node

var selected_type: NetworkTypes.Type
@onready var network_manager: NetworkManager = $"../NetworkManager"


func _on_hud_node_type_selected(type_node: NetworkTypes.Type) -> void:
	selected_type = type_node

func build(position: Vector2i) -> void:
	var node = NetworkNode.new()
	node.position = position
	node.network_type = selected_type
	network_manager.add_node(node)
