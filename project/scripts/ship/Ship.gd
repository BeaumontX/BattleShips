extends Resource
class_name Ship



enum lengths {
	None,
	Single,
	Double,
	Triple,
	Quadriple
}
var length : lengths = lengths.None


var cells : Array[Vector2i]
