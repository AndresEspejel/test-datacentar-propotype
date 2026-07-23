class_name NetworkManager
extends Node

var nodes: Dictionary = {
	NetworkTypes.Type.POWER:{},
	NetworkTypes.Type.DATA:{},
	NetworkTypes.Type.AIR:{},
}


func _ready() -> void:
	
	var node_a = NetworkNode.new()
	node_a.position = Vector2i(0,0)
	node_a.network_type = NetworkTypes.Type.AIR
	
	var node_b = NetworkNode.new()
	node_b.position = Vector2i(0,1)
	node_b.network_type = NetworkTypes.Type.AIR
	
	var node_c = NetworkNode.new()
	node_c.position = Vector2i(0,-1)
	node_c.network_type = NetworkTypes.Type.AIR
	
	var node_d = NetworkNode.new()
	node_d.position = Vector2i(1,0)
	node_d.network_type = NetworkTypes.Type.AIR
	
	var node_f = NetworkNode.new()
	node_f.position = Vector2i(-1,0)
	node_f.network_type = NetworkTypes.Type.AIR
	
	add_node(node_a)
	add_node(node_b)
	add_node(node_c)
	add_node(node_d)
	add_node(node_f)
	
	print(nodes)
	print("Nodos en linea (aire acondicionado): "+ str(get_network_nodes(NetworkTypes.Type.POWER,Vector2i(0,0))))
	
	
	
func add_node(node:NetworkNode)-> void:
	nodes[node.network_type][node.position] = node
	find_neighbors(node)


func find_neighbors(node:NetworkNode)-> void:
	var position_center: Vector2i = Vector2i(node.position.x,node.position.y)
	
	var position_up: Vector2i = Vector2i(position_center.x,position_center.y-1)
	var position_right: Vector2i = Vector2i(position_center.x+1,position_center.y)
	var position_down: Vector2i = Vector2i(position_center.x,position_center.y+1)
	var position_left: Vector2i = Vector2i(position_center.x-1,position_center.y)
	
	
	#print("Central:"+ str(position_center)+"Up"+str(position_up) + "Right" +str(position_right)+"Dowm"+str(position_down)+"Left"+str(position_left))
	

	if (nodes[node.network_type].has(position_up)) :
		#print("Soy" +str(node.position) + " Tengo un nodo arriba "+ str(position_up))
		node.connect_node(nodes[node.network_type][position_up])
	else:
		node.delete_neighbors_in(position_up)
	
	if(nodes[node.network_type].has(position_right)):
		#print("Soy" +str(node.position) + " Tengo un nodo Derecha "+ str(position_right))
		node.connect_node(nodes[node.network_type][position_right])
	else:
		node.delete_neighbors_in(position_right)
	
	if(nodes[node.network_type].has(position_down)):
		#print("Soy" +str(node.position) + " Tengo un nodo abajo "+ str(position_down))
		node.connect_node(nodes[node.network_type][position_down])
	else:
		node.delete_neighbors_in(position_down)
	
	if(nodes[node.network_type].has(position_left)):
		#print("Soy" +str(node.position) + " Tengo un nodo izquerda "+ str(position_left))
		node.connect_node(nodes[node.network_type][position_left])
	else:
		node.delete_neighbors_in(position_left)


func get_network_nodes(type_networt: NetworkTypes.Type, _position: Vector2i):
	##TODO obtener los nodos conectado a partir de cieto tipo
	##TODO despues de obtener una red conectada, obtenerla a partir de una opsicion
	var explore_nodes = nodes[type_networt]
	var node_in_line = algorithm_dfs(explore_nodes)
	
	return node_in_line

func algorithm_dfs(explore_nodes:Dictionary):
	
	pass
	
	##Función DFS(nodo_actual, lista_visitados):
	#Marcar nodo_actual como visitado
	#Hacer algo con nodo_actual (ej. imprimir o procesar)
#
	#Para cada vecino en vecinos_de(nodo_actual):
		#Si el vecino no ha sido visitado:
			#Llamar a DFS(vecino, lista_visitados)
#extends Node
#
## Representación del grafo (nodos y sus conexiones)
#var grafo = {
	#"A": ["B", "C"],
	#"B": ["A", "D", "E"],
	#"C": ["A", "F"],
	#"D": ["B"],
	#"E": ["B", "F"],
	#"F": ["C", "E"]
#}
#
#var visitados: Array = []
#
#func _ready() -> Vector2:
	## Iniciamos la búsqueda desde el nodo "A"
	#dfs("A")
	#print("Recorrido completo: ", visitados)
	#return Vector2.ZERO
#
#func dfs(nodo_actual: String) -> void:
	## 1. Marcamos el nodo como visitado
	#visitados.append(nodo_actual)
	#print("Visitando: ", nodo_actual)
#
	## 2. Iteramos sobre los vecinos de este nodo
	#for vecino in grafo[nodo_actual]:
		## 3. Si el vecino no ha sido visitado, profundizamos en él
		#if not visitados.has(vecino):
			#dfs(vecino)
