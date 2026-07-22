class_name NetworkNode
extends RefCounted

var position:Vector2i
var network_type: NetworkTypes.Type
var active := false
var neighbors: Array[NetworkNode] = []



func connect_node(other: NetworkNode):
	#print("Nodo conectado: "+ str(position) +" Con: "+ str(other.position) )
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


func delete_neighbors_in(position_neig: Vector2i) -> void:
	var neigbor := get_neighbor_in(position_neig)
	if neigbor:
		disconnect_node(neigbor)
		print("Borrando el nodo" + str(neigbor))


func get_neighbor_in(position_neig:Vector2i) -> NetworkNode:
	var result_neighbor = null
	for neighbor in neighbors:
		if neighbor.position == position_neig:
			result_neighbor =  neighbor
	#print(" Buscando en "+ str(position_neig) + " Resultado: "+str(result_neighbor))
	return result_neighbor
