extends Node2D
@onready var tile_map_air: TileMapLayer = $TileMap
@export var power_line: PackedScene
@export var ethernet_line: PackedScene
@export var air_line: PackedScene



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
	line_instance.update_visual(node)

func _on_network_manager_draw_node(node: NetworkNode) -> void:
	draw_node(node)
