@tool
extends Control
class_name Grid_Panel


@onready var grid : GridContainer = %GridContainer
@onready var vertical : Line2D = %Line2D_Vertical
@onready var horizontal : Line2D = %Line2D_Horizontal

var children_size : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateChildrenSize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func UpdateChildrenSize() -> void:
	children_size = min(size.x, size.y)/10
	var new_size : Vector2 = Vector2(children_size, children_size)
	for child in %GridContainer.get_children() as Array[Control]:
		child.custom_minimum_size = new_size


func _on_resized() -> void:
	UpdateChildrenSize()

func ClearLines() -> void:
	horizontal.clear_points()
	vertical.clear_points()

func SetHorizontal(id : int) -> void:
	var level : float = grid.global_position.y + id * children_size + children_size/2
	
	
	var _start : float = grid.global_position.x
	var _end : float = grid.global_position.x + children_size * 10
	
	var point1 : Vector2 = horizontal.to_local(Vector2(_start, level))
	var point2 : Vector2 = horizontal.to_local(Vector2(_end, level))
	
	horizontal.clear_points()
	horizontal.add_point(point1)
	horizontal.add_point(point2)

func SetVertical(id : int) -> void:
	var level : float = grid.global_position.x + id * children_size + children_size/2
	
	var _start : float = grid.global_position.y
	var _end : float = grid.global_position.y + children_size * 10
	
	var point1 : Vector2 = vertical.to_local(Vector2(level, _start))
	var point2 : Vector2 = vertical.to_local(Vector2(level, _end))
	
	vertical.clear_points()
	vertical.add_point(point1)
	vertical.add_point(point2)



enum themes {
	default,
	fog
}

func SetTheme(new_theme : themes, connector : Global_Connector) -> void:
	if new_theme == themes.default:
		for child : Grid_Cell in grid.get_children():
			child.SetStyle(Grid_Cell.styles.default)
	elif new_theme == themes.fog:
		var i : int = 0
		var player : Player = Global.players[Global.target_side]
		var vision : VisionGrid = player.vision
		var data : ShipDataGrid = player.field
		for child : Grid_Cell in grid.get_children():
			var coord : Vector2i = IntToCoords(i)
			if vision.grid[coord] == VisionGrid.state.UNKNOWN:
				child.SetStyle(Grid_Cell.styles.fog)
			else:
				match data.grid[coord]:
					ShipDataGrid.state.NONE:
						child.SetStyle(Grid_Cell.styles.default)
					ShipDataGrid.state.SHIP_HIT:
						child.SetStyle(Grid_Cell.styles.fog_hit)
						print("style hit")
					ShipDataGrid.state.SHIP_DEAD:
						child.SetStyle(Grid_Cell.styles.fog_dead)
			
			i += 1

var highlighted_cell : int = 0
func HightlightCell(coords : Vector2i) -> void:
	UnHightlightPrevCell()
	
	
	var id : int = (coords.y) * 10 + (coords.x)
	var child : Grid_Cell = grid.get_child(id)
	child.Highlight()
	highlighted_cell = id

func UnHightlightPrevCell() -> void:
	var child : Grid_Cell = grid.get_child(highlighted_cell)
	child.UnHighlight()
	highlighted_cell = 0

func IntToCoords(i : int) -> Vector2i:
	var x : int = i % 10
	var y : int = i / 10
	return Vector2i(x, y)
