extends Area2D

const SPEED = 300
const DAMAGE = 50
var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):

	translate(velocity)
	$AnimatedSprite.play("shoot")
	velocity = Vector2((SPEED * delta), 0).rotated(rotation)
	
func _on_fireball_body_entered(body):		#wenn getroffen
	if(body.get_name() == "GegnerblaseBody2D"):
		body.get_parent().queue_free()
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



