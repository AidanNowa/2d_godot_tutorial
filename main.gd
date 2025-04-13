extends Node

@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_mob_timer_timeout():
	#Create new instance of Mob
	var mob = mob_scene.instantiate()
	#Choose random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	#set the mob's position to the random location
	mob.position = mob_spawn_location.position
	#set mob's direction perpendicular to the path direction (facing inward by setting path in clockwise direction
	var direction = mob_spawn_location.rotation + PI / 2
	#add randomness sto the direction
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	#choose the mob velocity with some randomness
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	#spawn the mob by adding it to the main scene
	add_child(mob)

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
