extends Control
class_name Element

var ELEMENT_COLORS := {
	2    : Color.from_hsv(0.55, 0.00, 1.00),
	4    : Color.from_hsv(0.55, 0.10, 1.00),
	8    : Color.from_hsv(0.55, 0.20, 1.00),
	16   : Color.from_hsv(0.55, 0.30, 1.00),
	32   : Color.from_hsv(0.55, 0.40, 1.00),
	64   : Color.from_hsv(0.55, 0.50, 1.00),
	128  : Color.from_hsv(0.55, 0.60, 1.00),
	256  : Color.from_hsv(0.55, 0.70, 1.00),
	512  : Color.from_hsv(0.55, 0.80, 1.00),
	1024 : Color.from_hsv(0.55, 0.90, 1.00),
	2048 : Color.from_hsv(0.55, 1.00, 1.00),
}

var position_in_board := Vector2i(0, 0)

var value : int = 2

var element_size : Vector2i = Vector2i(64, 64):
	set(_new_element_size):
		element_size = _new_element_size
		%ValueBackground.size = element_size
		%ValueBackground.position.x = - element_size.x / 2
		%ValueBackground.position.y = - element_size.y / 2
		%ValueBackground.pivot_offset = element_size / 2
		%GridBackground.size = %ValueBackground.size
		%GridBackground.position = %ValueBackground.position
		%GridBackground.pivot_offset = %ValueBackground.pivot_offset

var is_blank := false:
	set(_new_is_blank):
		is_blank = _new_is_blank
		%GridBackground.visible = is_blank

var element_position := Vector2i()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	%Value.text = str(value)

func change_value(_new_value : float, _force_change := false):
	value = _new_value
	update_color()

func update_color():
	%ValueBackground.modulate = ELEMENT_COLORS.get(value)

func generate(_new_value : float):
	value = _new_value
	update_color()
