extends Control

var score := 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$ScoreLabel.text = "score: " + str(score)
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
		await $Board.handle_move(move_direction)
		if $Board.check_game_over():
			$PopupFail.activate(score)
			get_tree().paused = true
		else:
			$Board.random_new_element()


func _on_board_combine_event_happend(final_value : int):
	score += final_value
