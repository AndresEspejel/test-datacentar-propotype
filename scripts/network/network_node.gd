class_name NetworkNode
extends RefCounted

var position:Vector2i
var network_type: NetworkTypes.Type
var active := false
var neighbors: Array[NetworkNode] = []


func connect_node(other: NetworkNode):
	if other == self:
		return
	if neighbors.has(other):
		return
	neighbors.append(other)
	if !other.neighbors.has(self):
		other.neighbors.append(self)

func disconnect_node(other: NetworkNode) -> void:
	neighbors.erase(other)
	other.neighbors.erase(self)
