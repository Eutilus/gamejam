extends Area2D

const SPEED = 300
var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):

	translate(velocity)
	$AnimatedSprite.play("shoot")
	velocity = Vector2((SPEED * delta), 0).rotated(rotation)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
