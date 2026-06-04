extends Control
class_name Grid_Cell


@onready var panel: Panel = %Panel
@onready var hightlight: Panel = %Hightlight


enum styles {
	default,
	fog,
	fog_hit,
	fog_dead
}
const style : Dictionary[styles, StyleBoxFlat] = {
	styles.default: preload("uid://d2cg66p0v7heb"),
	styles.fog: preload("uid://duv4bxw1bpytb"),
	styles.fog_hit: preload("uid://drfb06f8kbibt"),
	styles.fog_dead: preload("uid://cys8h3360ulxx"),
}


func SetStyle(new_style : styles) -> void:
	panel.add_theme_stylebox_override("panel", style[new_style])


func Highlight() -> void:
	hightlight.show()

func UnHighlight() -> void:
	hightlight.hide()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
