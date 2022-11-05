extends Node2D
class_name EstacionRecarga

# car onready

onready var carga_Sfx:AudioStreamPlayer = $Carga_sfx

##atributos export

export var energia:float=6.0
export var radio_energia_entregada:float = 0.5

#atributos

var nave_player:Player = null
var player_en_zona: bool = false
#metodos

func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
		
	energia -= radio_energia_entregada
	print("energia estacion: ", energia)
	
	if event.is_action("recargar_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	
	elif event.is_action("recargar_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)
		

##señales internas 

func _on_AreaColision_body_entered(body):
	if body.has_method("destruir"):
		body.destruir()


func _on_AreaRecarga_body_entered(body):
	if body is Player:
		nave_player= body
	
	body.set_gravity_scale(0.1)
	player_en_zona = true

func _on_AreaRecarga_body_exited(body):
	body.set_gravity_scale(0.0)
	player_en_zona = true
	
func puede_recargar(event: InputEvent) -> bool:
	var hay_input = event.is_action("recargar_escudo") or event.is_action("recargar_laser")
	if hay_input and player_en_zona and (energia >0.0):
		if !carga_Sfx.playing:
			carga_Sfx.play()
		return true
	carga_Sfx.stop()
	return false	

func controlar_energia()->void:
	energia = radio_energia_entregada
	if energia<=0.0:
		$Vacio_sfx.play()
	print("energia estacion: ", energia)
