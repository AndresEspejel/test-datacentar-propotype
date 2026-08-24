class_name BuildManager
extends Node

var selected_type: NetworkTypes.Type
var mode_move = true
var mode_deleted = false
var mode_add = false

@onready var network_manager: NetworkManager = $"../NetworkManager"


func _on_hud_node_type_selected(type_node: NetworkTypes.Type) -> void:
	print("MODO: agregar cables")
	mode_add = true
	mode_deleted = false
	mode_move = false
	selected_type = type_node

func build(position: Vector2i) -> void:
	var node = NetworkNode.new()
	node.position = position
	node.network_type = selected_type
	network_manager.add_node(node)

# Borra solamente el tipo actualmente seleccionado
func delete_node(position: Vector2i) -> void:
	network_manager.remove_node(position, selected_type)

# Borra TODOS los elementos de la celda
func delete_item(position: Vector2i) -> void:
	var nodes_to_delete = network_manager.get_nodes_in(position)
	for node in nodes_to_delete:
		network_manager.remove_node(
			node.position,
			node.network_type
		)

func _on_hud_node_deleted_selected() -> void:
	if mode_deleted == false:
		print("MODO: borrado")
		mode_add = false
		mode_deleted = true
		mode_move = false
	else:
		print("MODO: mover")
		mode_add = false
		mode_deleted = false
		mode_move = true
