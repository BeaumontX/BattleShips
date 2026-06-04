@tool
extends Control
class_name GUI_Ships



@onready var tilemap : TileMapLayer = %TileMapLayer
var source_id : int = 2
var terrain_set : int = 0
var terrain_alive : int = 0
var terrain_dead : int = 1

@export var hide_ships : bool = false :
	set(newbool):
		if tilemap != null:
			hide_ships = newbool
			if newbool == true:
				tilemap.hide()
			else:
				tilemap.show()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func SetSize(value : int, pos : Vector2) -> void:
	tilemap.scale = Vector2(value, value) / Vector2(160, 160)
	tilemap.position = pos

func SwitchTile(coord : Vector2) -> void:
	var atlas_coord : Vector2 = tilemap.get_cell_atlas_coords(coord)
	var source : int = tilemap.get_cell_source_id(coord)
	if atlas_coord.y < 3:
		tilemap.set_cell(coord, source, atlas_coord + Vector2(0, 3), 0)
	else:
		tilemap.set_cell(coord, source, atlas_coord + Vector2(0, -3), 0)




func DrawBoard(data : ShipDataGrid) -> void:
	tilemap.clear()
	for i in data.grid:
		DrawTile(i, data.grid[i])
	ConnectTiles()
	SwitchTiles()

var _temp_to_connect : Array[Vector2i]
var _temp_to_switch : Array[Vector2i]
func DrawTile(coord : Vector2i, state : ShipDataGrid.state) -> void:
	match state:
		ShipDataGrid.state.NONE:
			pass
			#tilemap.erase_cell(coord)
		ShipDataGrid.state.SHIP_ALIVE:
			#tilemap.set_cell(coord, source_id, Vector2i(0,0))
			_temp_to_connect.append(coord)
			
		ShipDataGrid.state.SHIP_HIT or ShipDataGrid.state.SHIP_DEAD:
			#tilemap.set_cell(coord, source_id, Vector2i(0,0))
			_temp_to_connect.append(coord)
			_temp_to_switch.append(coord)

func ConnectTiles() -> void:
	tilemap.set_cells_terrain_connect(_temp_to_connect, terrain_set, terrain_alive, false)
	_temp_to_connect.clear()

func SwitchTiles() -> void:
	for i in _temp_to_switch:
		SwitchTile(i)
	_temp_to_switch.clear()
