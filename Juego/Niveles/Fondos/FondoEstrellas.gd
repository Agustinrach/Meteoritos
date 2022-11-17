tool
extends ParallaxBackground


export var color_fondo:Color = Color.black

func _ready():
	$ColorRect.color = color_fondo
	
func _process(delta):
	if Engine.editor_hint:
		$ColorRect.color = color_fondo		
