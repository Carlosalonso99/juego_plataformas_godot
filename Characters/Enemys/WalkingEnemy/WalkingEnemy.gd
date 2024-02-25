extends KinematicBody2D


var direction = Vector2.RIGHT
var velocity = Vector2.ZERO


onready var ledgeCheckRight = $LedgeCheckRight
onready var ledgeCheckLeft = $LedgeCheckLeft

func _ready():
	pass
	


func _physics_process(delta):
	$AnimatedSprite.play("default")
	
	var found_wall = is_on_wall()
	var found_ledgeRight = not ledgeCheckRight.is_colliding()
	var found_ledgeLeft = not ledgeCheckLeft.is_colliding()
	
	if found_wall or found_ledgeRight or found_ledgeLeft:
		direction *= -1
		
		$AnimatedSprite.flip_h = direction.x > 0

	
	velocity = direction * 25
	move_and_slide(velocity, Vector2.UP)
