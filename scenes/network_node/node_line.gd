class_name NodeLine
extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var my_node: NetworkNode


func setup(node: NetworkNode):
	my_node = node

func update_visual(node: NetworkNode):
	if node != my_node:
		return
	print("Soy"+str(node.position)+"TENGO :"+ str( node.neighbors.size()))
	if node.neighbors.size() >=  2 :
		animated_sprite.play("default")
