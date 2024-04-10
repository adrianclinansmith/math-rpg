class_name Enemy
extends Node2D

enum LogicalOp {AND, OR, XOR}

const ATTACK := 30
const __MAX_HP := 200

var hp_bar: HpBar = null

var __rng := RandomNumberGenerator.new()
var __left_horn_value: int
var __right_horn_value: int
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
	__change_horns("Left", __rng.randi_range(1, 15))
	__change_horns("Right", __rng.randi_range(1, 15))
	print()
	
func receive_attack(attack: int) -> bool:
	if attack == 0:
		print("You do nothing!\n")
		return false
	var hit_left := attack % __left_horn_value == 0
	var hit_right := attack % __right_horn_value == 0
	if hit_left:
		print("left: %d|%d" % [__left_horn_value, attack])
	if hit_right:
		print("right: %d|%d" % [__right_horn_value, attack])
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

# Private Methods
# ==============================================================================

func __change_horns(side_of_head: String, value: int) -> void:
	print("%s value = %d" % [side_of_head, value])
	# Store the numeric value of the horns 
	if side_of_head == "Left":
		__left_horn_value = value
	else:
		__right_horn_value = value
	# initially hide all horns and halos
	for i in range(1, get_child_count()):
		if get_child(i).name.contains(side_of_head):
			get_child(i).hide()
	# show the halos to represent 4, 8, or 12
	var back_halo1: Sprite2D = get_node("Halo1%sBack" % side_of_head)
	var front_halo1: Sprite2D = get_node("Halo1%sFront" % side_of_head)
	var back_halo2: Sprite2D = get_node("Halo2%sBack" % side_of_head)
	var front_halo2: Sprite2D = get_node("Halo2%sFront" % side_of_head)
	if value >= 8:
		back_halo2.show()
		front_halo2.show()
		value -= 8
	if value >= 4:
		back_halo1.show()
		front_halo1.show()
	# show the horns to represent the remaining 1, 2, or 3
	var back_horn: Sprite2D = get_node("Horn%sBack" % side_of_head)
	var middle_horn: Sprite2D = get_node("Horn%sMiddle" % side_of_head)
	var front_horn = get_node("Horn%sFront" % side_of_head)
	if side_of_head == "Left":
		front_horn = get_node("Horn%sFrontAnimated" % side_of_head)
	if value % 4 == 1:
		middle_horn.show()
	elif value % 4 == 2:
		back_horn.show()
		middle_horn.show()
	elif value % 4 == 3:
		back_horn.show()
		middle_horn.show()
		front_horn.show()
		if side_of_head == "Left":
			print("should play")
			front_horn.play("default")

