extends CamaraJuego
class_name CamaraPlayer


##var export

export var variacion_zoom : float = 0.1
export var zoom_minimo : float = 0.8
export var zoom_maximo : float = 1.5


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_acercar"):
		controlar_zoom(-variacion_zoom)	
	if event.is_action_pressed("zoom_alejar"):
		controlar_zoom(variacion_zoom)		

func controlar_zoom(mod_zoom : float) -> void:
	zoom.x = clamp(zoom.x + mod_zoom, zoom_minimo, zoom_maximo)
	zoom.y = clamp(zoom.y + mod_zoom, zoom_minimo, zoom_maximo)
	twee_zoom.start()
	