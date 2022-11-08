#NaveBase.gd
class_name NaveBase
extends RigidBody2D

##enums

enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

## atributos export 


export var hitpoints : float = 20.0

# atributos

var estado_actual:int = ESTADO.SPAWN

# atributos onready

onready var colisionador:CollisionShape2D = $CollisionShape2D
onready	var impacto_sfx: AudioStreamPlayer = $Impacto_sfx

onready var canion:Canion = $Canion



#metodos
func destruir() -> void:
	controlador_estados(ESTADO.MUERTO)
	

func _ready() -> void:
	controlador_estados(estado_actual)
	 


			

	


func controlador_estados(nuevo_estado:int) -> void:
		match nuevo_estado:
			ESTADO.SPAWN:
				colisionador.set_deferred("disabled", true)
				canion.set_puede_disparar(false)
			ESTADO.VIVO:
				colisionador.set_deferred("disabled", false)
				canion.set_puede_disparar(true)	
			ESTADO.INVENCIBLE:
				colisionador.set_deferred("disabled", true)
			ESTADO.MUERTO:
				colisionador.set_deferred("disabled", true)
				canion.set_puede_disparar(true)
				Eventos.emit_signal("nave_destruida", global_position)
				queue_free()
			_:
				printerr("error de estado")
		
		estado_actual = nuevo_estado					

func esta_input_activo() -> bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true	


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		controlador_estados(ESTADO.VIVO)

func recibir_danio(danio:float)-> void:
	impacto_sfx.play()
	hitpoints -= danio
	if hitpoints <=0.0:
		destruir()
	impacto_sfx.stop()


func _on_body_entered(body):
	if body is Meteorito:
		body.destruir()
		destruir()
