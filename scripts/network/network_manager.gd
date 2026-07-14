class_name NetworkManager
extends Node

var nodes: Dictionary = {
	NetworkTypes.Type.POWER:{},
	NetworkTypes.Type.DATA:{},
	NetworkTypes.Type.AIR:{},
}


func _ready() -> void:
	
	var nodeA = NetworkNode.new()
	nodeA.position = Vector2i(0,0)
	nodeA.network_type = NetworkTypes.Type.POWER
	
	var nodeB = NetworkNode.new()
	nodeB.position = Vector2i(0,1)
	nodeB.network_type = NetworkTypes.Type.POWER
	
	add_node(nodeA)
	add_node(nodeB)
	
	print(nodes)
	
func add_node(node:NetworkNode)-> void:
	nodes[node.network_type][node.position] = node

func remove_node(position: Vector2i) -> void:
	pass

func get_network_node(position: Vector2i)-> void:
	pass

func connect_neighbors(node:NetworkNode) -> void:
	pass
