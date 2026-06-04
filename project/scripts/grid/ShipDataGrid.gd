extends Grid
class_name ShipDataGrid

#
#Информация о наличии кораблей и их состоянии

enum state {
	NONE,
	SHIP_ALIVE,
	SHIP_HIT,
	SHIP_DEAD
}


func CreateShipCell(cell : Vector2i) -> void:
	grid[cell] = state.SHIP_ALIVE

func AttackShipCell(cell : Vector2i) -> void:
	if grid[cell] != state.SHIP_ALIVE:
		_ErrorMessage(cell, state.SHIP_ALIVE)
	grid[cell] = state.SHIP_HIT

func KillShipCell(cell : Vector2i) -> void:
	if grid[cell] != state.SHIP_HIT:
		_ErrorMessage(cell, state.SHIP_ALIVE)
	grid[cell] = state.SHIP_DEAD

func _ErrorMessage(cell : Vector2i, desired_state : state) -> void:
	push_warning(get_stack()[1], ": Cell ", cell, " is not ", state.find_key(desired_state))

func CheckCell(cell : Vector2i) -> state:
	return grid[cell] as state



func AttackShip(coord : Vector2i) -> void:
	var cell_state : state = CheckCell(coord)
	if cell_state == state.SHIP_ALIVE:
		AttackShipCell(coord)
	
	var ship : Ship
	for i in ships:
		if i.cells.has(coord):
			ship = i
			break
	
	if !IsShipAlive(ship):
		KillShip(ship)

func IsShipAlive(ship : Ship) -> bool:
	for i in ship.cells:
		if grid[i] == state.SHIP_ALIVE:
			return true
	return false

func KillShip(ship : Ship) -> void:
	for i in ship.cells:
		KillShipCell(i)

func IsCellClear(cell : Vector2i) -> bool:
	if CheckCell(cell) == state.NONE:
		return true
	else:
		return false

func AreAdjescentCellsClear(cell : Vector2i) -> bool:
	var field : Rect2i = Rect2i(Vector2i(0,0), Vector2i(9,9))
	var up : Vector2i = cell + Vector2i.UP
	var down : Vector2i = cell + Vector2i.DOWN
	var left : Vector2i = cell + Vector2i.LEFT
	var right : Vector2i = cell + Vector2i.RIGHT
	if field.has_point(up):
		if grid[up] != state.NONE:
			return false
	if field.has_point(down):
		if grid[down] != state.NONE:
			return false
	if field.has_point(left):
		if grid[left] != state.NONE:
			return false
	if field.has_point(right):
		if grid[right] != state.NONE:
			return false
	
	return true





func IsBoardReady() -> bool:
	var temp_lengths : Dictionary[Ship.lengths, int]
	for i in ships:
		var length : Ship.lengths = i.length
		if !temp_lengths.has(length):
			temp_lengths[length] = 1
		else:
			temp_lengths[length] += 1
	
	print("temp: ", temp_lengths)
	print("rules: ", Global.rules.ShipAmount)
	if temp_lengths == Global.rules.ShipAmount:
		return true
	return false



var ships : Array[Ship]

var temp_ship : Ship
func CreateShip(p1 : Vector2i, p2 : Vector2i) -> bool:
	if !IsAbleToCreate(p1, p2):
		temp_ship = null
		return false
	
	for cell in temp_ship.cells:
		CreateShipCell(cell)
	ships.append(temp_ship)
	
	return true


func IsAbleToCreate(p1 : Vector2i, p2 : Vector2i) -> bool:
	temp_ship = Ship.new()
	var info_ships : Vector3i = _CheckLength(p1, p2)
	if info_ships.y == 0:
		print("Ships of size ", info_ships.z, " are not allowed")
		return false
	if info_ships.x >= info_ships.y:
		print("You have reached limit on the ships of size ", info_ships.z)
		print(info_ships)
		return false
	temp_ship.length = info_ships.z as Ship.lengths
	
	var temp_cell : Vector2i
	if p1.x == p2.x:
		for i in range(min(p1.y, p2.y),max(p1.y, p2.y) + 1):
			temp_cell = Vector2i(p1.x, i)
			if !IsCellClear(temp_cell) or !AreAdjescentCellsClear(temp_cell):
				return false
			temp_ship.cells.append(temp_cell)
	else:
		for i in range(min(p1.x, p2.x), max(p1.x, p2.x) + 1):
			temp_cell = Vector2i(i, p1.y)
			if !IsCellClear(temp_cell) or !AreAdjescentCellsClear(temp_cell):
				return false
			temp_ship.cells.append(temp_cell)
	
	
	return true

## X - current number of ship with given length
## Y - maximum number of ship with given length
## Z - given length
func _CheckLength(p1 : Vector2i, p2 : Vector2i) -> Vector3i:
	var result : Vector3i = Vector3i(0, 0,0)
	
	var length : int = p1.distance_to(p2) + 1
	result.z = length
	
	result.y = Global.rules.GetAmountByLength(length)
	for ship in ships:
		if ship.length == length:
			result.x += 1
	
	return result

func CheckDefeat() -> bool:
	for i in ships:
		for cell in i.cells:
			if grid[cell] == state.SHIP_ALIVE:
				return false
	return true
