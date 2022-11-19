extends Node



func _ready():
	OS.set_window_fullscreen(true)
	
	MusicaJuego.play_musica(MusicaJuego.get_lista_musica().menu_principal)


func _on_BotonSalir_pressed():
	get_tree().quit()


func _on_BotonJugar_pressed():
	get_tree().change_scene("res://Juego/Niveles/Nivel1.tscn")
