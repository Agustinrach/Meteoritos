extends Node

signal disparo(proyectil)
signal nave_destruida (nave,posicion,num_explosiones)
signal spawn_meteorito(posicion, direccion, tamanio)
signal meteorito_destruido(posicion)
signal nave_en_sector_peligro(centro_camara, tipo_peligro, num_peligro)
signal base_destruida(base,posiciones)
signal spawn_orbital(orbital)

#hud

signal nivel_iniciado()
signal nivel_terminado()
signal detecto_zona_recarga(entrando)
signal cambio_nro_meteorito(numero)
signal desaparecer_info_meteoritos()
signal cambio_energia_laser(energia_max, energia_actual)
signal ocultar_info_laser()
signal cambio_energia_escudo(energia_max, energia_actual)
signal ocultar_info_escudo()
signal actualizar_tiempo(tiempo_restante)

signal minimapa_objeto_creado()
signal minimapa_objeto_destruido() 
