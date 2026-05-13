extends Node2D

var dict : Dictionary[Vector2i, int]

@export var testgrid : Grid = Grid.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	testgrid.grid[Vector2i(1,1)] = 2;
	print("grid: ", testgrid.grid[Vector2i(1,1)])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
