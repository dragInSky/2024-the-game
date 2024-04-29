extends PopupPanel


var is_win = false
var is_rdy = false

func activate(_score : int):
	var limit_score = Singleton.get_limit()
	
	if _score <= limit_score:
		is_win = true
		$Label.text = "You win!\nScore <= " + str(limit_score) + ": " + str(_score)
	else:
		$Label.text = "You died!\nScore > " + str(limit_score) + ": " + str(_score)
	popup_centered()
	
	$Timer.start()

func _process(_delta):
	if is_rdy == true:
		if Input.is_anything_pressed():
			if is_win == true:
				Singleton.change_limit()
			get_tree().reload_current_scene()


func _on_timer_timeout():
	is_rdy = true
