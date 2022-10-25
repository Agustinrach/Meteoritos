#Nivel.gd
class_name Nivel
extends Node2D

## atributos export 

export var explosion:PackedScene = null

## atributos onready
onready var contenedor_proyectiles:Node
## metodos 
func _ready() -> void:
	conectar_Seniales()
	crear_contenedores()

## metodos custom	


func conectar_Seniales() -> void:
		Eventos.connect("disparo", self, "_on_disparo")
		Eventos.connect("nave_destruida", self, "_on_nave_destruida")

func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)

func _on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)	

func  _on_nave_destruida(posicion: Vector2) -> void:
	var new_explosion: Node2D = explosion.instance()
	new_explosion.global_position = posicion
	add_child(new_explosion)
