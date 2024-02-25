extends Area2D


func _on_Hitbox_body_entered(body):
	if body is Player:
#		Le paso la colision shape del enemigo
		body.emit_signal("enemy_hit", get_child(0))
		Global.vidas -= 1
		if(Global.vidas <= 0):
			body.emit_signal("sin_vidas")

