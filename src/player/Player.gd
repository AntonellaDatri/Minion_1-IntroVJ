extends Area2D
signal hit
signal point


export var speed = 200  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var pointer_treshold = 30
var puntero

func _physics_process(delta):
	if speed == 200:
		puntero = get_local_mouse_position()
	if puntero.length() > pointer_treshold:
		var direccion = puntero.normalized()
		position += direccion * speed * delta
		if Input.is_action_just_pressed("ui_space"):
			dash(direccion,delta)
			puntero = get_local_mouse_position()
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _ready():
	screen_size = get_viewport_rect().size
	hide()


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func dash(dir,delta):
	speed = speed * 3
	$Timer.start()


func _on_Timer_timeout():
	speed = 200


func _on_Player_body_entered(body):
	if (body.is_in_group("mobs")):
		hide()  # Player disappears after being hit.
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
	if (body.is_in_group("points")):
		emit_signal("point")
		body.queue_free()
		
