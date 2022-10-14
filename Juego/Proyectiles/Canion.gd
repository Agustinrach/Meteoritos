#Canion.gd
class_name Canion
extends Node2D

## atributos export

export var proyectil:PackedScene=null
export var cadencia_disparo:float = 0.8
export var velocidad_proyectil:int = 100
export var danio_proyectil:int = 1

## atributos onready
onready var disparo_sfx:AudioStreamPlayer2D = $DisparoSFX
onready var timer_enfriamiento:Timer = $TimerEnfriamiento
onready var esta_enfriado:bool = true
onready var esta_disparando:bool = false setget set_esta_disparando 

##atributos 

var punto_disparo:Array = []

##setter and getters

func set_esta_disparando(disparando:bool)-> void:
	esta_disparando= disparando 
