@tool

extends Control
class_name GUI_Grid


@onready var ratio : AspectRatioContainer = %AspectRatioContainer
@onready var grid : Control = %GridPanel
@onready var tilemap : TileMapLayer = %TileMapLayer

@export var player : Global.players


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_resized() -> void:
	if !is_node_ready():
		pass
	var value : float = min(ratio.size.x, ratio.size.y)
	tilemap.scale = Vector2(value, value) / Vector2(160, 160)
	tilemap.position = ratio.position
	grid.position = ratio.position
