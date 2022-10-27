#Nivel.gd
class_name Nivel
extends Node2D

## atributos export 

export var explosion:PackedScene = null
export var meteorito:PackedScene 

## atributos onready
onready var contenedor_proyectiles:Node
onready var contenedor_meteoritos : Node
## metodos 
func _ready() -> void:
	conectar_Seniales()
	crear_contenedores()

## metodos custom	


func conectar_Seniales() -> void:
		Eventos.connect("disparo", self, "_on_disparo")
		Eventos.connect("nave_destruida", self, "_on_nave_destruida")
		Eventos.connect("spawn_meteorito", self, "on_spawn_meteoritos")
		
func crear_contenedores() -> void:
	contenedor_proyectiles = Node.new()
	contenedor_proyectiles.name = "ContenedorProyectiles"
	add_child(contenedor_proyectiles)
	
	contenedor_meteoritos = Node.new()
	contenedor_meteoritos.name = "ContenedorProyectiles"
	add_child(contenedor_meteoritos)
	

func _on_disparo(proyectil:Proyectil) -> void:
	contenedor_proyectiles.add_child(proyectil)	

func  _on_nave_destruida(posicion: Vector2) -> void:
	var new_explosion: Node2D = explosion.instance()
	new_explosion.global_position = posicion
	add_child(new_explosion)

func on_spawn_meteoritos(pos_spawn: Vector2, dir_meteorito: Vector2, tamanio:float) -> void:
	var new_meteorito:Meteorito = meteorito.instance()
	new_meteorito.crear(
		pos_spawn,
		dir_meteorito,
		tamanio
	)
	contenedor_meteoritos.add_child(new_meteorito)
