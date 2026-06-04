@tool

extends Control
class_name GUI_Grid


@onready var ratio : AspectRatioContainer = %AspectRatioContainer
@onready var grid : Grid_Panel = %GridPanel
@onready var ships : GUI_Ships = %GUI_Ships

@export var connector : Global_Connector = Global_Connector.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connector.Connect_Grid(self)
	connector.Connect_Tilemaplayer(ships)
	Global._ManageGrids()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resized() -> void:
	if !is_node_ready():
		pass
	grid.UpdateChildrenSize()
	var value : int = int(grid.children_size) * 10
	ships.SetSize(value, ratio.position)

func SetHorizontal(id : int) -> void:
	grid.SetHorizontal(id)

func SetVertical(id : int) -> void:
	grid.SetVertical(id)

func SetTheme(new_theme : Grid_Panel.themes) -> void:
	grid.SetTheme(new_theme, connector)
	#if new_theme == Grid_Panel.themes.default:
		#ships.show()
	#elif new_theme == Grid_Panel.themes.fog:
		#ships.hide()

func HightlightCell(coords : Vector2i) -> void:
	grid.HightlightCell(coords)

func UnHightlightPrevCell() -> void:
	grid.UnHightlightPrevCell()

func DrawBoard(data : ShipDataGrid) -> void:
	ships.DrawBoard(data)
