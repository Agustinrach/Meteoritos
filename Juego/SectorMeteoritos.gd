class_name SectorMeteoritoss
extends Node2D

## atributos export

export var cantidad_meteoritos : int = 10
export var intervalo_spawn : float= 1.2

#atributos 

var spawners: Array

# metodos

func _ready():
	almacenar_spawners()
	conectar_seniales_detectores()
	$Timer.wait_time = intervalo_spawn
		
# metodos custom

func almacenar_spawners() -> void:
	for spawner in $Spawners.get_children():
		spawners.append(spawner)

func spawner_aleatorio() -> int:
	randomize()
	return randi() % spawners.size()
	
func conectar_seniales_detectores() -> void:
		for detector in $DetectorFueraZona.get_children():
			detector.connect("body_entered", self, "_on_detector_body_entered")
		#$DetectorFueraZona/DetectorIzq.connect("body_entered", self, "_on_DetectorIzq_body_entered")
		#$DetectorFueraZona/DetectorDer.connect("body_entered", self, "_on_DetectorDer_body_entered")
		#$DetectorFueraZona/DetectorInf.connect("body_entered", self, "_on_DetectorInf_body_entered")
		#$DetectorFueraZona/DetectorSup.connect("body_entered", self, "_on_DetectorSup_body_entered")	
		
		
#señales internas

func _on_Timer_timeout():
	
	if cantidad_meteoritos ==0:
		$Timer.stop()
		return
	
	spawners[spawner_aleatorio()].spawnear_meteorito()
	cantidad_meteoritos -=1	
	
func _on_detector_body_entered(body:Node):
	body.set_esta_en_sector(false)	

#constructor 
func crear(pos:Vector2, meteoritos:int) -> void:
	global_position=pos
	cantidad_meteoritos = meteoritos	
