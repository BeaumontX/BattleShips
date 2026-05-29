extends Resource
class_name Player



var name : String = ""

var vision : VisionGrid = VisionGrid.new()
var field : ShipDataGrid = ShipDataGrid.new()

var ships : Array[Ship]
