extends Node2D
@onready var piso: TileMapLayer = $Piso
@onready var cursor_tile: Sprite2D = $CursorTile
@onready var build_manager: BuildManager = $"../BuildManager"


func _ready():
	cursor_tile.visible = false


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var celda = piso.local_to_map(piso.to_local(mouse_pos))

		if piso.get_cell_source_id(celda) != -1:
			print("Tile:", celda)
		if event.is_action_pressed("clic_left"):
			build_manager.build(celda)
			
		if event.is_action_pressed("clic_right"):
			print("Borrar nodo")
			build_manager.delete_node(celda)
			
		if event.is_action_pressed("clic_middle"):
			print("Mover camara")


func _process(_delta):
	var mouse = get_global_mouse_position()
	
	var celda = piso.local_to_map(
		piso.to_local(mouse)
	)
	
	if piso.get_cell_source_id(celda) != -1:
		cursor_tile.visible = true
		cursor_tile.position = piso.map_to_local(celda)+ Vector2(0, 8)
	else:
		cursor_tile.visible = false
