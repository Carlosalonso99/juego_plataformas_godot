extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tiempo = 0.00
# Called when the node enters the scene tree for the first time.
var timer 
func _ready():
	timer = $Panel/Timer
	timer.wait_time = 0.01 # Actualiza cada segundo
	timer.start()



func _process(delta):
	$Panel/LabelPuntos.text = str("Monedas: ", Global.monedas)
	$Panel/LabelVidas.text = str("Vidas: ", Global.vidas)





func _on_ButtonReset_pressed():
	get_tree().reload_current_scene()
	Global.monedas = 0
	Global.vidas = 3


func _on_Timer_timeout():
	tiempo += 0.01
	Global.tiempo = tiempo
	# Actualiza el texto del nodo Label con el tiempo transcurrido
	$Panel/LabelTiempo.text = str("Time:", tiempo)


func _on_WinPannel_draw():
	timer.stop()

