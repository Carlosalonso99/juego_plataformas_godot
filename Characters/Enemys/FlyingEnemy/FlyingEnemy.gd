extends KinematicBody2D



	
var cont = 0
var velocity = Vector2.LEFT *10




func _physics_process(delta):
	$AnimatedSprite.play("default")
	$AnimatedSprite.flip_h = velocity.x > 0
	cont = cont + 1
	if(cont == 200):
		cont = 0
		velocity = velocity*-1
	move_and_slide(velocity)
	



	
