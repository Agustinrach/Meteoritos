class_name BaseEnemiga
extends Node2D

#atributos export
export var hitpoints:float=30.0
export var orbital:PackedScene=null
export var intervalo_spawn : float=0.8
export var numero_orbitales : int =10
#atributos onready

onready var impacto_sfx:AudioStreamPlayer2D = $ImpactoSfx
onready var timer_spawner:Timer = $TimerSpawnEnemigos
onready var barra_salud : ProgressBar = $BarraSalud

#atributos
var esta_destruida : bool = false
var pos_spawn:Vector2 =Vector2.ZERO

func _ready()->void:
	timer_spawner.wait_time=intervalo_spawn
	$AnimationPlayer.play("Rotacion_horario") 
	barra_salud.set_valores(hitpoints)

func elegir_animacion_aleatoria()->String:
	randomize()
	var num_anim:int = $AnimationPlayer.get_animation_list().size()-1
	var indice_anim_aleatoria:int = randi()%num_anim+1
	var lista_animacion:Array = $AnimationPlayer.get_animation_list()
	return lista_animacion[indice_anim_aleatoria]


func recibir_danio(danio:float)->void:
	hitpoints -=danio
	if hitpoints<=0 and not esta_destruida:
		esta_destruida=true
		destruir()
	barra_salud.set_hitpoints_actual(hitpoints)
	impacto_sfx.play()	


func _on_AreaColision_body_entered(body):
	if body.has_method("destruir"):
		body.destruir()

func destruir()->void:
	var posicion_partes=[
		$Sprites/Sprite2.global_position,
		$Sprites/Sprite3.global_position,
		$Sprites/Sprite4.global_position,
		$Sprites/Sprite.global_position
	]
	Eventos.emit_signal("base_destruida",self,posicion_partes)
	Eventos.emit_signal("minimapa_objeto_destruido",self)
	queue_free()

func spawnear_orbital()->void:
	numero_orbitales-=1

	$RutaEnemigo.global_position=global_position
	var new_orbital = orbital.instance()
	new_orbital.crear(
		global_position + pos_spawn,
		self,
		$RutaEnemigo
	)
	Eventos.emit_signal("spawn_orbital",new_orbital)

func deteccion_cuadrante()->Vector2:
	var player_objetivo : Player = DatosJuego.get_player_actual()
	if not player_objetivo:
		return Vector2.ZERO
	
	var dir_player : Vector2 = player_objetivo.global_position - global_position
	var angulo_player:float = rad2deg(dir_player.angle())
	
	if abs(angulo_player)<=45.0:
		#player viene por derecha
		$RutaEnemigo.rotation_degrees=180.0
		return$PosicionesSpawn/Este.global_position
	
	elif abs(angulo_player) >135.0 and abs(angulo_player)<=180.0:
		#player viene por izquierda
		$RutaEnemigo.rotation_degrees=0.0
		return$PosicionesSpawn/Oeste.global_position	
		
	elif abs(angulo_player) >45.0 and abs(angulo_player)<=135.0:
		#player viene por arriba o abajo
		
		if sign(angulo_player)>0:
			#player viene por abajo
			$RutaEnemigo.rotation_degrees=270.0	
			return$PosicionesSpawn/Sur.global_position			
		else:
			$RutaEnemigo.rotation_degrees=90.0
			return$PosicionesSpawn/Norte.global_position	
	return$PosicionesSpawn/Norte.global_position	





func _on_VisibilityNotifier2D_screen_entered():
	#Spawn orbital
	$VisibilityNotifier2D.queue_free()
	pos_spawn = deteccion_cuadrante()
	spawnear_orbital()
	timer_spawner.start()




func _on_TimerSpawnEnemigos_timeout():
	if numero_orbitales==0:
		timer_spawner.stop()
		return
	spawnear_orbital()		
