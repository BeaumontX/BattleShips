extends Resource
class_name Global_Connector


@export var side : Global.player_sides

func Connect_Grid(node : Node) -> void:
	Global.Connect(node, Global.connected_types.grid, side)

func Connect_Tilemaplayer(node : Node) -> void:
	Global.Connect(node, Global.connected_types.tilemaplayer, side)
