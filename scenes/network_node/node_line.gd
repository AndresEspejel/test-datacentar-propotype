class_name NodeLine
extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var my_node: NetworkNode


func setup(node: NetworkNode):
	my_node = node

func update_visual(node: NetworkNode):
	if node != my_node:
		return

	var up := false
	var down := false
	var left := false
	var right := false

	for neighbor in node.neighbors:
		var delta := neighbor.position - node.position
		match delta:
			Vector2i(0, -1):
				up = true
			Vector2i(0, 1):
				down = true
			Vector2i(-1, 0):
				left = true
			Vector2i(1, 0):
				right = true

	print(
		"Nodo:", node.position,
		" U:", up,
		" D:", down,
		" L:", left,
		" R:", right
	)

	# Elegir sprite
	if (up and right) or (right and down) or (down and left) or (left and up):
		animated_sprite.play("default_x")
	elif left and right:
		animated_sprite.play("default_l")
	elif up and down:
		animated_sprite.play("default_r")
	elif left or right:
		animated_sprite.play("default_l")
	elif up or down:
		animated_sprite.play("default_r")
	else:
		animated_sprite.play("default_l")

func deleted():
	queue_free()
