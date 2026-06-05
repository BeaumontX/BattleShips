extends Resource
class_name Rules




@export var ShipAmount : Dictionary[Ship.lengths, int] = {
	Ship.lengths.Single: 4,
	Ship.lengths.Double: 3,
	Ship.lengths.Triple: 2,
	Ship.lengths.Quadriple: 1,
}

func GetAmountByLength(length : int) -> int:
	if ShipAmount.has(length):
		return ShipAmount[length]
	else:
		return 0
