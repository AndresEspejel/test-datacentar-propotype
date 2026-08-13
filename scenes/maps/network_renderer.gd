extends Node2D
@onready var tile_map_air: TileMapLayer = $TileMap
@export var power_line: PackedScene
@export var ethernet_line: PackedScene
@export var air_line: PackedScene

var rendered_nodes: Dictionary = {}


func draw_node(node: NetworkNode):
	
	var line_instance = null
	
	if node.network_type == NetworkTypes.Type.AIR:
		line_instance= air_line.instantiate()
		
	if node.network_type == NetworkTypes.Type.POWER:
		line_instance= power_line.instantiate()

	if node.network_type == NetworkTypes.Type.ETHERNET:
		line_instance= ethernet_line.instantiate()
		
	line_instance.setup(node)
	add_child(line_instance)
	line_instance.global_position = tile_map_air.map_to_local(node.position)
	rendered_nodes[node.position] = line_instance
	line_instance.update_visual(node)

func _on_network_manager_draw_node(node: NetworkNode) -> void:
	draw_node(node)


func _on_network_manager_update_node_visual(node: NetworkNode) -> void:
	if rendered_nodes.has(node.position):
		var line_instance = rendered_nodes[node.position]
		line_instance.update_visual(node)

func delete_node(node: NetworkNode) -> void:
	if not rendered_nodes.has(node.position):
		return
	var line_instance = rendered_nodes[node.position]
	rendered_nodes.erase(node.position)
	line_instance.queue_free()



func _on_network_manager_deleted_node_visual(node: NetworkNode) -> void:
	delete_node(node)
