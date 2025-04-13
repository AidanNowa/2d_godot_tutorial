extends CanvasLayer
#notify 'Main' node that the button has been pressed
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	#wait for messagetimer to end
	await $MessageTimer.timeout
	
	$Message.text ="Dodge the Creeps!"
	$Message.show()
	#make a one-shot timer and wait for it to end (SceneTree's create_timer() function is also an option
	await get_tree().create_timer(1.0).timeout
	#display start button to allow for replaying
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	$Message.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
