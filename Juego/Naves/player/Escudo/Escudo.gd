#Escudo.gd
class_name Escudo
extends Area2D

#atributos
var esta_activado:bool = false setget, get_esta_activado
var energia_original : float
## atributos export

export var energia:float = 8.0
export var radio_desgaste:float = -1.6 

##setters & getters

func get_esta_activado() -> bool:
	return esta_activado

func _process(delta: float) -> void:
	controlar_energia(radio_desgaste*delta)

##metodos

func _ready() -> void:
	energia_original = energia
	set_process(false)
	controlar_colisionador(true)
	
	
## metodos custom

func controlar_colisionador(esta_Desactivado:bool) -> void:
	$CollisionShape2D.set_deferred("disabled", esta_Desactivado)

func activar()-> void:
	if energia <=0.0:
		return
	
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("Activando")
	
func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("Activando")			

##señales internas

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "Activando" and esta_activado:
		$AnimationPlayer.play("Activado")
		set_process(true)
		


func _on_body_entered(body: Node) -> void:
	body.queue_free()

func controlar_energia(consumo:float) -> void:
	energia+=consumo
	print("energia escudo : ", energia)
	
	if energia <= 0.0:
		desactivar()
