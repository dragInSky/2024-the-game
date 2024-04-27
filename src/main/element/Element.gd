extends Control
class_name Element

var ELEMENT_COLORS := {
	2    : 1,
	4    : 2,
	8    : 3,
	16   : 4,
	32   : 5,
	64   : 6,
	128  : 7,
	256  : 8,
	512  : 9,
	1024 : 10,
	2048 : 11,
}

var position_in_board := Vector2i(0, 0)

var value : int = 2

var element_size : Vector2i = Vector2i(64, 64)

var is_blank := false:
	set(_new_is_blank):
		is_blank = _new_is_blank
		refresh()

var element_position := Vector2i()

func change_value(_new_value : float, _force_change := false):
	value = _new_value
	update_color()

func change_value_and_visibility(_new_value : float, _force_change := false):
	change_value(_new_value,_force_change)
	make_visible()

func update_color():
	if ELEMENT_COLORS.has(value):
		$numsSprite.set_frame(ELEMENT_COLORS.get(value))
		$bgsSprite.set_frame(ELEMENT_COLORS.get(value))
	else:
		refresh()

func refresh():
	$numsSprite.set_frame(0)
	$bgsSprite.set_frame(0)

func generate(_new_value : float):
	make_visible()
	value = _new_value
	update_color()

func make_invisible():
	$numsSprite.visible = false

func make_visible():
	$numsSprite.visible = true
