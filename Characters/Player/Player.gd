extends KinematicBody2D
class_name Player

#Layer: por que es afectado; 
#Mask a quien busca afectar;
signal sin_vidas

#Para que reciba la colision shape del enemigo que interactua para anularla momentaneamente
signal enemy_hit(colisionShape)

#Señal para que se reproduzca el sonido de la moneda ya que si la quiero borrar, no le da tiempo areproducirse
signal coin_colected

signal finish_game


export(Resource) var moveData

#onready var wallCheckR= $RayCastR
#onready var wallCheckL= $RayCastL

var start_position = Vector2(0,100)
var velocity = Vector2.ZERO
var win_pannel
func _ready():
	position = start_position
	win_pannel = $Camera2D/HUD/WinPannel
	win_pannel.hide()
	print(win_pannel)
	$AnimatedSprite.flip_h = true
	print("Hello world")


var is_enemy_hit_playing = false



func _physics_process(_delta):
	if (global_position.y > 250):
		Global.vidas -= 1
		if global_position.x < 795:
			position = start_position
		else:
			print ("pasa")
			position = Vector2(870,0)
		if(Global.vidas <= 0):
			emit_signal("sin_vidas")
		
	apply_gravity()

	

	var input = Vector2.ZERO
	
	#CDiferenciaentre las teclas pulsadas (+1 = R) (-1 = L)
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if is_on_floor():
		#Si no se pulsa ni R ni L aplicas friccion
		if input.x == 0:
			apply_friction()
			if not is_enemy_hit_playing:
				$AnimatedSprite.play("Idle")
			
		else:
			if not is_enemy_hit_playing:
				$AnimatedSprite.play("Run")
#			Igualamos a una comparacion para que segun sea true o false cambie
			$AnimatedSprite.flip_h = input.x > 0

			apply_acceleration(input.x)
			
		#Y si pulsa up salta
		if Input.is_action_just_pressed("ui_up"):
			
			if not $PlayerJumpAudio.playing:
				$PlayerJumpAudio.play()
			#Altura de salto maxima
			velocity.y = moveData.JUMP_FORCE
			
	#Si no esta en el suelo
	else:
		#Si suelta la tecla up y la v < 30(Va hacia arriba) => la v = -30
		if Input.is_action_just_released("ui_up") and velocity.y < moveData.JUMP_RELEASE_FORCE:
			#Altura de salto minima
				
			
			velocity.y = moveData.JUMP_RELEASE_FORCE
		#Si esta callendo sumamos 2 a la gravedad
		if velocity.y > 0:
			velocity.y += moveData.ADDITIONAL_FALL_GRAVITY
		if velocity.y <= 0:
			if not is_enemy_hit_playing:
				$AnimatedSprite.play("Jump")

	velocity = move_and_slide(velocity , Vector2.UP)

#Gravedad
#Gravedad
func apply_gravity():
	velocity.y += moveData.GRAVITY
	velocity.y = min(velocity.y, 300)
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, moveData.FRICTION)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, moveData.MAX_SPEED * amount, moveData.ACELERATION)




func _on_Player_sin_vidas():
	Global.monedas = 0
	Global.vidas = 3
	get_tree().reload_current_scene()
	



var colision_shape 


func _on_AnimatedSprite_animation_finished():
	if is_enemy_hit_playing:
		is_enemy_hit_playing = false
		colision_shape.set_deferred("disabled", false)


func _on_Player_enemy_hit(colisionShape):
	$EnemyHitAudio.play()
	colision_shape = colisionShape
	colision_shape.set_deferred("disabled", true)
	is_enemy_hit_playing = true
	$AnimatedSprite.play("EnemyHit")




func _on_Player_coin_colected():
	$CoinSound.play()


func _on_Player_finish_game():
	win_pannel.show()
	set_physics_process(false)


