extends Area2D


func _ready():
	$Sprite.play("default")

func _on_Area2D_body_entered(body):
	if body is Player:
		body.emit_signal("coin_colected")
		queue_free()
		Global.monedas += 1
