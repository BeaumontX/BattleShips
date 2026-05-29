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


func CheckCell(cell : Vector2i) -> state:
	return grid[cell] as state


func _ErrorMessage(cell : Vector2i, desired_state : state) -> void:
	push_warning(get_stack()[1], ": Cell ", cell, " is not ", state.find_key(desired_state))
