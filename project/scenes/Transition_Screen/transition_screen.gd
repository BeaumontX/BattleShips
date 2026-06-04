extends Control
class_name TransitionScreen


@onready var label_phase: Label = %Phase
@onready var label_player_side: Label = %Player_Side
@onready var label_hint: Label = %Hint
@onready var timer: Timer = %Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(Hide)
	Global.transition_screen = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func EndScreen(phase : Global.game_phases, player : Global.player_sides) -> void:
	SetInfo(phase, player)
	timer.disconnect("timeout", Hide)

func SetInfo(phase : Global.game_phases, player : Global.player_sides) -> void:
	SetPhaseText(phase)
	SetPlayerText(player)
	SetHintText(phase)
	show()
	timer.start()

func SetPhaseText(phase : Global.game_phases) -> void:
	var text : String
	match phase:
		Global.game_phases.prepare:
			text = "Подготовка"
		Global.game_phases.game:
			text = "Игра"
		Global.game_phases.end:
			text = "Победил"
	label_phase.text = text

func SetPlayerText(player : Global.player_sides) -> void:
	var text : String
	match player:
		Global.player_sides.left:
			text = "Левый"
		Global.player_sides.right:
			text = "Правый"
	label_player_side.text = text

func SetHintText(phase : Global.game_phases) -> void:
	var text : String
	match phase:
		Global.game_phases.prepare:
			text = "Установите свои корабли"
		Global.game_phases.game:
			text = "Уничтожьте корабли противника"
		Global.game_phases.end:
			text = "Поздравляю"
	label_hint.text = text

func Hide() -> void:
	hide()
