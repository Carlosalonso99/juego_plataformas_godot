extends Node2D


func _ready():
	VisualServer.set_default_clear_color(Color.cornflower)
	$AmbientAudio.play()
	

func _process(delta):
	pass
