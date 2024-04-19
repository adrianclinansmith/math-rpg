class_name Enemy
extends Node2D

enum LogicalOp {AND, OR, XOR}

const ATTACK := 3
const __MAX_HP := 200

@onready var horn_set_left: HornSet = $HornSetLeft
@onready var horn_set_right: HornSet = $HornSetRight

var hp_bar: HpBar = null

var __rng := RandomNumberGenerator.new()
var __logical_connection := LogicalOp.OR
var __hp := __MAX_HP:
	set(new_hp):
		__hp = clamp(new_hp, 0, __MAX_HP)
		hp_bar.set_hp(__hp)

# Public Methods
# ==============================================================================

func change_logic_operator() -> void:
	__logical_connection = (__logical_connection + 1) % LogicalOp.size()
	$LogicalAND.hide()
	$LogicalOR.hide()
	$LogicalXOR.hide()
	match __logical_connection:
		LogicalOp.AND: $LogicalAND.show()
		LogicalOp.OR:  $LogicalOR.show()
		LogicalOp.XOR: $LogicalXOR.show()
		
func randomly_change_horns() -> void:
	horn_set_left.shatter_and_regrow(__rng.randi_range(1, 15))
	horn_set_right.shatter_and_regrow(__rng.randi_range(1, 15))
	print()
	
func receive_attack(attack: int) -> bool:
	if attack == 0:
		print("You do nothing!\n")
		return false
	var hit_left := attack % horn_set_left.value == 0
	var hit_right := attack % horn_set_right.value == 0
	if hit_left:
		print("left: %d|%d" % [horn_set_left.value, attack])
	if hit_right:
		print("right: %d|%d" % [horn_set_right.value, attack])
	var got_hit: bool
	match __logical_connection:
		LogicalOp.AND: got_hit = hit_left and hit_right
		LogicalOp.OR:  got_hit = hit_left or hit_right
		LogicalOp.XOR: got_hit = hit_left != hit_right
	if got_hit:
		__hp -= attack
		print("Your attack hits!")
		randomly_change_horns()
	else:
		print("You MISS!\n")
	return __hp <= 0

func set_hp_bar(_hp_bar: HpBar) -> void:
	hp_bar = _hp_bar
	hp_bar.setup(__MAX_HP, __hp)
	
func reset() -> void:
	__hp = __MAX_HP
	randomly_change_horns()
