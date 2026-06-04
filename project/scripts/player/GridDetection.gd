extends Node

#Находит клетку, на которую наведена мышь
#Альтернативно, находит клетку по клавиатуре
#
#Сначала определяется находится ли мышь в какой-либо сетке
#Если да, то вычисляются координаты клетки на этой сетке
#
#По клавиатуре просто считывается ввод букв и цифр
	#Столбец и ряд выбираются отдельно, то есть они не сбрасываются при изменении другого
	#Они сбрасываются лишь при завершении хода или перевыборе
	#Синхронизировано с мышкой



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Mouse(event)
	#elif event is InputEventKey:
		#Keyboard(event)


func Mouse(e : InputEventMouseButton) -> void:
	if !e.is_action_released("click_left"):
		return
	var grid_pos : Vector2 = Global.grids[Global.target_side].global_position
	var cell_size : float = Global.grids[Global.target_side].grid.children_size
	var mouse_pos : Vector2 = e.global_position
	
	var pos : Vector2 = (mouse_pos - grid_pos)/cell_size + Vector2(0, -0.5)
	var coord_x : int = floori(pos.x)
	var coord_y : int = floori(pos.y)
	var coord : Vector2i = Vector2i(coord_x, coord_y)
	if (coord.x < 0 or coord.y < 0) or (coord.x > 9 or coord.y > 9):
		return
	
	Global.AddCoords(coord)



func Keyboard(e : InputEventKey) -> void:
	var cols : Array = range(KEY_A, KEY_K)
	var rows : Array = range(KEY_0, KEY_9 + 1)
	var keycode : int = e.keycode
	var num : int
	if e.is_released():
		if keycode in cols:
			print(OS.get_keycode_string(keycode))
			num = keycode - KEY_A
		if keycode in rows:
			print(OS.get_keycode_string(keycode))
			if keycode == KEY_0:
				num = 9
			else:
				num = keycode - KEY_1
		print(num)
