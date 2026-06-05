extends Node

enum player_sides {
	left,
	right
}
var players : Dictionary[player_sides, Player] = {
	player_sides.left: Player.new(player_sides.left),
	player_sides.right: Player.new(player_sides.right)
}

enum connected_types {
	none,
	grid,
	tilemaplayer
}
var grids : Dictionary[player_sides, GUI_Grid]
var tilemaps : Dictionary[player_sides, GUI_Ships]

var rules : Rules = Rules.new()

var game_phase : game_phases = game_phases.prepare
enum game_phases {
	prepare,
	game,
	end
}
func NextPhase() -> void:
	game_phase = min(game_phase + 1, game_phases.size() - 1)

var turn_side : player_sides = player_sides.left
var turn_id : int = 0
var target_side : player_sides = player_sides.right :
	get():
		if game_phase == game_phases.prepare:
			return turn_side
		else:
			return opposite_side(turn_side)



var current_coords : Array[Vector2i]
func AddCoords(coord : Vector2i) -> void:
	match game_phase:
		game_phases.prepare:
			Logic_PhasePrepare(coord)
		game_phases.game:
			Logic_PhaseGame(coord)

func Logic_PhasePrepare(coord : Vector2i) -> void:
	if current_coords.is_empty():
		_PhasePrepare_SetTarget(coord)
	else:
		_PhasePrepare_SecondTarget(coord)

func _PhasePrepare_SetTarget(coord : Vector2i) -> void:
	current_coords.append(coord)
	grids[target_side].HightlightCell(coord)

func _PhasePrepare_SecondTarget(coord : Vector2i) -> void:
	if current_coords[0].x == coord.x or current_coords[0].y == coord.y:
		_SetSecondCoord(coord)
		
		var success : bool = players[target_side].CreateShip(current_coords[0], current_coords[1])
		if success:
			print("ship created")
			_ClearTarget()
			grids[target_side].DrawBoard(players[target_side].field)
		else:
			print("ship was not created")
			_ClearTarget()
		
		var is_ready : bool = players[target_side].IsBoardReady()
		if is_ready:
			EndTurn()
		
	else:
		_ClearTarget()

func _ClearTarget() -> void:
	current_coords.clear()
	grids[target_side].UnHightlightPrevCell()

func _SetSecondCoord(coord : Vector2i) -> void:
	if current_coords.size() == 2:
		current_coords[1] = coord
	else:
		current_coords.append(coord)




func Logic_PhaseGame(coord : Vector2i) -> void:
	if current_coords.is_empty() or current_coords[0] != coord:
		_PhaseGame_SetTarget(coord)
	elif current_coords[0] == coord:
		_PhaseGame_ConfirmTarget(coord)


func _PhaseGame_SetTarget(coord : Vector2i) -> void:
	current_coords.clear()
	current_coords.resize(1)
	current_coords[0] = coord
	SetHorizontalLine(coord.y)
	SetVerticalLine(coord.x)
	grids[target_side].HightlightCell(coord)

func _PhaseGame_ConfirmTarget(coord : Vector2i) -> void:
	grids[target_side].UnHightlightPrevCell()
	
	players[target_side].RevealCell(coord)
	players[target_side].AttackShip(coord)
	grids[target_side].ships.SwitchTile(coord)
	
	EndTurn()





func opposite_side(side : player_sides) -> player_sides:
	if side == player_sides.left:
		return player_sides.right
	else:
		return player_sides.left


func ProcessCoordinations() -> void:
	pass

func EndTurn() -> void:
	match game_phase:
		game_phases.prepare:
			TurnEnd_PhasePrepare()
		game_phases.game:
			TurnEnd_PhaseGame()
	
	
	_ClearCordsAndLines()
	_UpdateTurnInfo()
	_ManageGrids()
	if game_phase != game_phases.end:
		_Transition_Screen() 
	
	print("phase: ", game_phases.find_key(game_phase))
	print("next turn")
	print("player side: ", player_sides.find_key(turn_side))
	print("target side: ", player_sides.find_key(target_side))
	

var transition_screen : TransitionScreen :
	set(new_tr):
		transition_screen = new_tr
		_Transition_Screen()

func _Transition_Screen() -> void:
	transition_screen.SetInfo(game_phase, turn_side)

func _ClearCordsAndLines() -> void:
	current_coords.clear()
	grids[target_side].grid.ClearLines()

func _UpdateTurnInfo() -> void:
	turn_id += 1
	turn_side = opposite_side(turn_side)
	
	if turn_id == 2:
		NextPhase()


func TurnEnd_PhasePrepare() -> void:
	pass

var loser : player_sides
func TurnEnd_PhaseGame() -> void:
	var defeat : bool = players[target_side].CheckDefeat()
	if defeat:
		loser = target_side
		EndGame()

func EndGame() -> void:
	print("END!!!")
	NextPhase()
	transition_screen.EndScreen(game_phase, opposite_side(loser))




func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func Connect(node : Node, type : connected_types, side : player_sides) -> void:
	match type:
		connected_types.grid:
			grids[side] = node
		connected_types.tilemaplayer:
			tilemaps[side] = node

func SetHorizontalLine(coord : int) -> void:
	grids[target_side].SetHorizontal(coord)

func SetVerticalLine(coord : int) -> void:
	grids[target_side].SetVertical(coord)

func _ManageGrids() -> void:
	if grids.size() < 2:
		return
	grids[turn_side].SetTheme(Grid_Panel.themes.default)
	grids[opposite_side(turn_side)].SetTheme(Grid_Panel.themes.fog)
