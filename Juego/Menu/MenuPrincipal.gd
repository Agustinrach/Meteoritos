extends Node

func _ready():
	MusicaJuego.play_musica(MusicaJuego.get_lista_musica().menu_principal)



func _on_BotonJugar_pressed():
	MusicaJuego.play_boton()
	get_tree().change_scene("res://Juego/Niveles/NivelTest.tscn")
