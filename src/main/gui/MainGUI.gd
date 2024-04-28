extends Control

var score := 0

var limit_score = Singleton.get_limit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$VBoxContainer/ScoreLabel.text = "score: " + str(score) + "\nLimit score: " + str(limit_score)
	
	var move_direction := Vector2i()
	if Input.is_action_just_pressed("move_up"):
		move_direction = Vector2i(0, -1)
	if Input.is_action_just_pressed("move_down"):
		move_direction = Vector2i(0, 1)
	if Input.is_action_just_pressed("move_left"):
		move_direction = Vector2i(-1, 0)
	if Input.is_action_just_pressed("move_right"):
		move_direction = Vector2i(1, 0)
	if move_direction != Vector2i():
		await $VBoxContainer/Board.handle_move(move_direction)
		if $VBoxContainer/Board.check_game_over():
			$PopupFail.activate(score)
		else:
			$VBoxContainer/Board.random_new_element()


func _on_board_combine_event_happend(final_value : int):
	score += final_value


func _on_reload_pressed():
	get_tree().reload_current_scene()


func _on_x_3_pressed():
	Singleton.field_size = 3
	get_tree().reload_current_scene()


func _on_x_2_pressed():
	Singleton.field_size = 2
	get_tree().reload_current_scene()


func _on_x_4_pressed():
	Singleton.field_size = 4
	get_tree().reload_current_scene()
