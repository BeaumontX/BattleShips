extends Resource
class_name Player


func _init(set_side : Global.player_sides) -> void:
	side = set_side

var name : String = ""
var side : Global.player_sides

var vision : VisionGrid = VisionGrid.new()
var field : ShipDataGrid = ShipDataGrid.new()

func CreateShip(p1 : Vector2i, p2 : Vector2i) -> bool:
	var field_success : bool = field.CreateShip(p1, p2)
	
	return field_success

func IsBoardReady() -> bool:
	return field.IsBoardReady()

func RevealCell(coord : Vector2i) -> void:
	vision.RevealCell(coord)

func AttackShip(coord : Vector2i) -> void:
	field.AttackShip(coord)

func CheckDefeat() -> bool:
	return field.CheckDefeat()
