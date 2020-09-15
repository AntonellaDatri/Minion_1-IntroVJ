extends RigidBody2D
signal game_over 


export(float) var speed = 15
var screen_size  # Size of the game window.
var direccion
var target:Vector2
var velocity := Vector2.ZERO


func actualice_position(pos):
	target = (pos - position).normalized()
	$AnimatedSprite.look_at(pos)
	

func _physics_process(delta):
	velocity += target.normalized() * speed
	velocity *= friction
	position += velocity * delta
	print (position)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _ready():
	screen_size = get_viewport_rect().size
	$Timer.start()
	friction = 0.95


func _on_Timer_timeout():
	queue_free()
