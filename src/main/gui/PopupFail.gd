extends PopupPanel


var is_win = false

func activate(_score : int):
	var limit_score = Singleton.get_limit()
	
	if _score <= limit_score:
		is_win = true
		$Label.text = "You win!\nScore less then " + str(limit_score) + ": " + str(_score)
	else:
		$Label.text = "You died!\nScore greater then " + str(limit_score) + ": " + str(_score)
	popup_centered()

func _input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		if key_event.pressed:
			if is_win == true:
				Singleton.change_limit()
			get_tree().reload_current_scene()
		
	elif event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.pressed:
			if is_win == true:
				Singleton.change_limit()
			get_tree().reload_current_scene()

