extends Control

var selected_draw: NetworkTypes.Type


signal node_type_selected(type_node: NetworkTypes.Type)


func _on_air_node_pressed() -> void:
	select_node(NetworkTypes.Type.AIR)


func _on_power_node_pressed() -> void:
	select_node(NetworkTypes.Type.POWER)


func _on_ethernet_node_pressed() -> void:
	select_node(NetworkTypes.Type.ETHERNET)


func select_node(type_node: NetworkTypes.Type) -> void:
	selected_draw = type_node
	node_type_selected.emit(selected_draw)
