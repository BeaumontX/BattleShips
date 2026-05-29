extends Resource
class_name Ship



enum types {
	Battleship,
	Carrier,
	Destroyer,
	Submarine
}
var type : types = types.Submarine


var cells : Dictionary[Vector2i, bool]
