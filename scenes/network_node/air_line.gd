extends Area2D

func _ready() -> void:
	print("Estoy vivo")
	flip()


func flip():
	scale.x *= -1
