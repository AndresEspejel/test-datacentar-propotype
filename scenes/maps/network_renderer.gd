extends Node2D
@onready var tile_map_air: TileMapLayer = $TileMapAir

func draw_node(node: NetworkNode):
	print("Dibujando nodo")
	tile_map_air.set_cell(
		node.position,
		0,
		Vector2i(3,2)
	)

func update_node(node: NetworkNode):
	pass


func _on_network_manager_draw_node(node: NetworkNode) -> void:
	draw_node(node)
