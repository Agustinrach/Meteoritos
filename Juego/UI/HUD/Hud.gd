extends CanvasLayer

onready var info_zona_recarga:ContenedorInfo = $InfoZonaRecarga
onready var info_meteoritos:ContenedorInfo = $InfoMeteoritos
onready var info_laser:ContenedorInformacionEnergia = $InfoLaser
onready var info_escudo:ContenedorInformacionEnergia = $InfoEscudo
onready var info_tiempo :ContenedorInfo =$InfoTiempoRestante

func _ready()->void:
	conectar_seniales()


#metodos

func conectar_seniales()->void:
	Eventos.connect("nivel_iniciado",self,"fade_out")
	Eventos.connect("nivel_terminado",self,"fade_in")
	Eventos.connect("detecto_zona_recarga",self,"_on_detecto_zona_recarga")
	Eventos.connect("cambio_nro_meteorito",self,"_on_actualizar_info_meteoritos")
	Eventos.connect("desaparecer_info_meteoritos",self,"_desaparecer_info_meteoritos")
	Eventos.connect("cambio_energia_laser",self,"_on_cambio_energia_laser")
	Eventos.connect("ocultar_info_laser",info_laser,"ocultar_suavizado")
	Eventos.connect("cambio_energia_escudo",self,"_on_cambio_energia_escudo")
	Eventos.connect("ocultar_info_escudo",info_escudo,"ocultar_suavizado")
	Eventos.connect("nave_destruida",self,"_on_nave_destruida")
	Eventos.connect("actualizar_tiempo",self,"_on_actualizar_tiempo")
#metodos custom
func fade_in()->void:
	$FadeCnvas/AnimationPlayer.play("fade_in")
	
func fade_out()->void:
	$FadeCnvas/AnimationPlayer.play_backwards("fade_in")

func _on_detecto_zona_recarga(en_zona : bool)->void:
	if en_zona:
		info_zona_recarga.mostrar_suavizado()
	else:
		info_zona_recarga.ocultar_suavizado()
			
func _on_actualizar_info_meteoritos ( nro:int)->void:
	info_meteoritos.mostrar_suavizado()
	info_meteoritos.modificar_texto(
		"Meteoritos Restantes\n {cantidad}".format({"cantidad":nro})
	)

func _desaparecer_info_meteoritos()->void:
	info_meteoritos.ocultar_suavizado()

func _on_cambio_energia_laser(energia_max:float, energia_actual:float)->void:
	info_laser.mostrar()
	info_laser.actualizar_energia(energia_max,energia_actual)
	
	
func _on_cambio_energia_escudo(energia_max:float, energia_actual:float)->void:
	info_escudo.mostrar()
	info_escudo.actualizar_energia(energia_max,energia_actual)

func _on_nave_destruida(nave:NaveBase, _posicion,_explosiones) ->void:
	if nave is Player:
		get_tree().call_group("contenedor_info","set_esta_activo",false)
		get_tree().call_group("contenedor_info","ocultar")
		info_tiempo.ocultar_suavizado()

func _on_actualizar_tiempo (tiempo_restante : int) ->void:
	var minutos:int = floor(tiempo_restante * 0.016666666667)
	var segundos : int = tiempo_restante %60
	info_tiempo.modificar_texto(
		"Tiempo Restante\n%02d:%02d" % [minutos,segundos]
	)
	info_tiempo.mostrar()
	

		

	
	
	
	
	
