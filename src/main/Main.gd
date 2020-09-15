extends Node
export (PackedScene) var Mob
export (PackedScene) var Diamond

var score
var maxMob = 7
var start_diamond = 15
var black_hole_position
var all_mobs = []


func _ready():
	pass 
	
func _physics_process(delta):
	for mob in all_mobs:
		if mob == null:
			all_mobs.erase(mob)
		else: 
			mob.actualice_position($Player.position)
	


func _on_MobTimer_timeout():
	if all_mobs.size() < maxMob:
		# Create a Mob instance and add it to the scene.		
		var mob = Mob.instance()
		add_child(mob)
		all_mobs.append(mob)
		# Set the random mob's direction
		var direction = black_hole_position[randi() % black_hole_position.size()]
		# Set the mob's position to a random location.
		mob.position = direction


func new_game():
	score = 0
	$HUD.update_score(score)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	takeHolePosition()
	init_diamond()
	$HUD.show_message("Get Ready")
	

func takeHolePosition():
	black_hole_position = [	$black_hole.position, 
							$black_hole2.position, 
							$black_hole3.position, 
							$black_hole4.position, 
							$black_hole5.position, 
							$black_hole6.position]


func init_diamond():
	for i in range(start_diamond):
		var diamond = Diamond.instance()
		add_child(diamond) 
		diamond.position.x = rand_range(0,1024)
		diamond.position.y = rand_range(0,600)


func game_over():
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("points", "queue_free")

func _on_StartTimer_timeout():
	$MobTimer.start()


func counter():
	score += 1
	$HUD.update_score(score)
