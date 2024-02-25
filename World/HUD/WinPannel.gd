extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _draw():
	var monedas = Global.monedas
	var vidas = Global.vidas
	var tiempo = Global.tiempo
	print(Global.tiempo)
	$MonedasRecolectadas.text = str("Monedas: ", monedas)
	$VidasRestantes.text = str("Vidas sobrantes: ", vidas)
	$Tiempo.text = str("Tiempo: ", Global.tiempo)

	
	# Valores para ponderar cada componente de la puntuación
	var valor_por_moneda = 100 # La cantidad de puntos que cada moneda aporta a la puntuación final
	var valor_por_vida = 500 # La cantidad de puntos que cada vida restante aporta
	var penalizacion_por_tiempo = -2 # La cantidad de puntos que se restan por cada segundo transcurrido

	# Calcula la puntuación final
	var puntuacion_final = (monedas* valor_por_moneda) + (vidas * valor_por_vida) + (tiempo * penalizacion_por_tiempo)

	# Asegúrate de que la puntuación no sea negativa
	puntuacion_final = max(puntuacion_final, 0)
	
	$PuntuacionTotal.text = str("Puntuacion :", int(puntuacion_final))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RestartButon_pressed():
	get_tree().reload_current_scene()
	Global.monedas = 0
	Global.vidas = 3
