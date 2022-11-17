extends NinePatchRect
class_name ContenedorInfo

onready var texto_contenedor:Label = $Label
onready var auto_ocultar_timer:Timer = $AutoOcultarTimer
onready var animaciones:AnimationPlayer = $AnimationPlayer



export var auto_ocultar : bool = false 

var esta_activo : bool = true setget set_esta_activo

#getters && setters

func set_esta_activo(valor : bool) ->void:
	esta_activo=valor

func set_auto_ocultar(valor : bool) ->void:
	auto_ocultar = valor

##metodos 


func mostrar()->void:
	if esta_activo:
		$AnimationPlayer.play("Mostrar")

func ocultar()->void:
	if not esta_activo:
		animaciones.stop()
	$AnimationPlayer.play("Ocultar")
	

func mostrar_suavizado()->void:	
	
	if not esta_activo:
		return
	$AnimationPlayer.play("mostrar_suavizado")	
	if auto_ocultar:
		auto_ocultar_timer.start()
		
func ocultar_suavizado()->void:
	if esta_activo:
		$AnimationPlayer.play("ocultar_suavizado ")		

func modificar_texto(txt:String)->void:
	texto_contenedor.text=txt

func _on_AutoOcultarTimer_timeout():
	ocultar_suavizado()
