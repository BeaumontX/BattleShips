extends Grid
class_name VisionGrid



enum state {
	UNKNOWN,
	KNOWN
}

func RevealCell(cell : Vector2i) -> void:
	grid[cell] = state.KNOWN
