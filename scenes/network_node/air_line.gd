extends Area2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var network_render = get_parent()


func _ready() -> void:
	if network_render:
		network_render.update_visual_air.connect(_update_visual)


func _update_visual(node: NetworkNode):
	print("Soy"+str(node.position)+"TENGO :"+ str( node.neighbors.size()))
	if node.neighbors.size() >=  2 :
		animated_sprite.play("idle_X")
