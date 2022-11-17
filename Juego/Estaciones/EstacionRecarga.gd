extends Node2D
class_name EstacionRecarga

# car onready

onready var carga_Sfx:AudioStreamPlayer = $Carga_sfx
onready var barra_energia:ProgressBar =$BarraEnergia
##atributos export

export var energia:float=6.0
export var radio_energia_entregada:float = 0.5

#atributos

var nave_player:Player = null
var player_en_zona: bool = false
#metodos

func _ready():
	barra_energia.max_value=energia
	barra_energia.value=energia

func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
		
	controlar_energia()
	
	if event.is_action("recargar_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	
	elif event.is_action("recargar_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)
	
	if event.is_action_released("recargar_escudo"):
		Eventos.emit_signal("ocultar_info_laser")	
	
	elif event.is_action_released("recargar_escudo"):
		Eventos.emit_signal("ocultar_info_escudo")	

##señales internas 

func _on_AreaColision_body_entered(body):
	if body.has_method("destruir"):
		body.destruir()


func _on_AreaRecarga_body_entered(body):
	if body is Player:
		player_en_zona = true
		nave_player= body
		Eventos.emit_signal("detecto_zona_recarga",true)
	
	

func _on_AreaRecarga_body_exited(body):

	if body is Player:
		player_en_zona = false
		nave_player= body
		Eventos.emit_signal("detecto_zona_recarga",false)
	
func puede_recargar(event: InputEvent) -> bool:
	var hay_input = event.is_action("recargar_escudo") or event.is_action("recargar_laser")
	if hay_input and player_en_zona and (energia >0.0):
		if !carga_Sfx.playing:
			carga_Sfx.play()
		return true
	carga_Sfx.stop()
	return false	

func controlar_energia()->void:
	energia -= radio_energia_entregada
	if energia<=0.0:
		$Vacio_sfx.play()
	barra_energia.value=energia
