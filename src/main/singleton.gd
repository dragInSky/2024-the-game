extends Node


var limit_score = [16, 64, 256]

var field_size = 2

func get_limit():
	return limit_score[field_size - 2]

func change_limit():
	var old = limit_score[field_size - 2]
	limit_score[field_size - 2] = int(old * 3 / 4)
