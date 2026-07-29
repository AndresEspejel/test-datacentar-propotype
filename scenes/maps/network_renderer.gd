extends Node2D
@onready var tile_map_air: TileMapLayer = $TileMap
@export var power_line: PackedScene

func draw_node(node: NetworkNode):
	print("Dibujando nodo")
	var power_line_instance = power_line.instantiate()
	add_child(power_line_instance)
	power_line_instance.global_position = tile_map_air.map_to_local(node.position)
	
func update_node(node: NetworkNode):
	pass


func _on_network_manager_draw_node(node: NetworkNode) -> void:
	draw_node(node)
