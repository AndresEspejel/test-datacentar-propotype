extends Node2D
@onready var piso: TileMapLayer = $Piso
@onready var cursor_tile: Sprite2D = $CursorTile
@onready var build_manager: BuildManager = $"../BuildManager"


func _ready():
	cursor_tile.visible = false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:

		# Revisar si el mouse está sobre un Control, por ejemplo IO
		var hovered_control = get_viewport().gui_get_hovered_control()
		if hovered_control != null:
			print("Clic en UI: ", hovered_control.name)
			return

		var mouse_pos = get_global_mouse_position()
		var celda = piso.local_to_map(piso.to_local(mouse_pos))
		if piso.get_cell_source_id(celda) != -1:
			print("Tile:", celda)
			
			if event.is_action_pressed("clic_left"):
				if build_manager.mode_add:
					build_manager.build(celda)
				elif build_manager.mode_deleted:
					build_manager.delete_item(celda)
				elif build_manager.mode_move:
					print("MOVER CAMARA")
			elif event.is_action_pressed("clic_right"):
				print("Borrar Elemento")
				build_manager.delete_item(celda)

			#elif event.is_action_pressed("clic_middle"):
				#print("Mover camara")
				
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
