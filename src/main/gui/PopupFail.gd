extends PopupPanel


func activate(_score : int):
	$MarginContainer/Label.text = "score: " + str(_score)
	popup_centered()
