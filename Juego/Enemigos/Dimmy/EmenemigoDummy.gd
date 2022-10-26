class_name EnemigoDummy
extends Node2D

var hitpoints:float = 10.0

onready var canion:Canion = $Canion

func _process(delta: float) -> void:
	canion.set_esta_disparando(true)	
	
	
	

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		body.destruir()

func recibir_danio(danio:float)-> void:
	hitpoints -= danio
	print(hitpoints)
	if hitpoints <= 0.0:
		Eventos.emit_signal("nave_destruida", global_position)
		queue_free()
