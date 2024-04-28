extends Control
class_name Board

signal combine_event_happend(final_value)

var scene_element : PackedScene = preload("res://src/main/element/Element.tscn")

var element_size : Vector2i = Vector2i(64, 64)

var elements := {}

var time_left

var columns = Singleton.field_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	init_board()
	elements[Vector2i(0, columns - 1)].is_blank = false
	elements[Vector2i(0, columns - 1)].change_value(2)

func _process(delta):
	$TimeLeft.text = str(int($Timer.time_left))

func check_game_over() -> bool:
	var is_game_over := true
	for e in elements.values():
		if e.is_blank:
			is_game_over = false
			break
	return is_game_over

func random_new_element():
	var valid_elements := []
	for e in elements.values():
		if e.is_blank:
			valid_elements.append(e)
	var random_element : Element = valid_elements[randi() % valid_elements.size()]
	random_element.is_blank = false
	random_element.generate(2 if randi() % 2 == 0 else 4)

func get_elements_can_move(_move_direction : Vector2i) -> Array:
	var result := []
	for e in elements.values():
		var element : Element = e
		var element_to : Element = elements.get(element.position_in_board + _move_direction)
		if is_instance_valid(element_to):
			if !element.is_blank and element_to.is_blank:
				result.append(element)
	return result

func handle_move(_move_direction : Vector2i):
	var origin_map := {}
	for e in elements.values():
		if e.is_blank:
			origin_map[e] = 0
		else:
			origin_map[e] = e.value
	
	var combine_events := []
	
	var pairs := {}
	for x in columns:
		for y in columns:
			var pos_in_board := Vector2i(x, y)
			var element : Element = elements.get(pos_in_board)
			if element.is_blank:
				continue
			pos_in_board += _move_direction
			var is_neighbour := true
			while elements.has(pos_in_board):
				var element_to : Element = elements.get(pos_in_board)
				if !element_to.is_blank:
					if element_to.value == element.value:
						if !pairs.keys().has(element_to) and !pairs.values().has(element_to):
							pairs[element] = element_to
							emit_signal("combine_event_happend", element.value * 2)
					else:
						break
				pos_in_board += _move_direction
	
	for e in pairs:
		var element : Element = e
		var element_to : Element = pairs[e]
		element_to.change_value(element.value * 2, true)
		element.is_blank = true
		element_to.is_blank = false
		combine_events.append(element_to)
		$MergeAudio.play()
	
	var move_map := {}
	while true:
		var elements_can_move : Array = get_elements_can_move(_move_direction)
		if elements_can_move.size() == 0:
			break
		for e in elements_can_move:
			var element : Element = e
			var element_to : Element = elements.get(element.position_in_board + _move_direction)
			if element_to.is_blank:
				element_to.is_blank = false
				element.is_blank = true
				element_to.change_value(element.value, true)
				$MoveAudio.play()
				if combine_events.has(element):
					combine_events.erase(element)
					combine_events.append(element_to)
	
	for e in combine_events:
		var value = e.value
		e.value = origin_map[e]
		e.change_value_and_visibility(value)


func init_board():
	for x in columns:
		for y in columns:
			var new_element : Element = scene_element.instantiate()
			add_child(new_element)
			new_element.is_blank = true
			new_element.element_size = element_size
			new_element.position_in_board = Vector2i(x, y)
			elements[Vector2i(x, y)] = new_element
	arrange_elements()

func arrange_elements():
	var global_rect : Rect2i = get_global_rect()
	var global_center_pos : Vector2i = global_rect.position + global_rect.size / 2
	
	var elements_rect_size := Vector2i(
		columns * element_size.x, 
		columns * element_size.y
	)
	var elements_global_rect := Rect2i(
		global_center_pos - elements_rect_size / 2, 
		elements_rect_size
	)
	for x in columns:
		for y in columns:
			var element : Element = elements.get(Vector2i(x, y))
			if !is_instance_valid(element):
				return
			element.position.x = (
				elements_global_rect.position.x + 
				element_size.x * x + 
				element_size.x / 2
			)
			element.position.y = (
				elements_global_rect.position.y + 
				element_size.y * y + 
				element_size.y / 2
			)
			element.element_position = element.position

func _on_resized():
	arrange_elements()

func _on_timer_timeout():
	for e in elements.values():
		e.make_invisible()
