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
	elif event is InputEventKey:
		Keyboard(event)


func Mouse(e : InputEventMouseButton) -> void:
	pass
	var grid_pos : Vector2
	var cell_size : float
	var mouse_pos : Vector2 = e.global_position
	
	var coord : Vector2 = (mouse_pos - grid_pos)/cell_size

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


signal SetHorizontalCord(cord : int)
signal SetVerticalCord(cord : int)
