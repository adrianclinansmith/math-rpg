extends Node2D

var rng := RandomNumberGenerator.new()
var attack := 0
var left_horn_value := 0
var right_horn_value := 0

# Node Overrides
# =========================================================

func _ready() -> void:
	randomly_change_horns()
	
func _process(delta: float) -> void:
	# increase attack power
	for digit in 10:
		if Input.is_action_just_pressed(str("ui_", digit)):
			attack = attack * 10 + digit
			$AttackButton.text = str(attack)
			print(attack)
	# decrease attack power
	if Input.is_action_just_pressed("ui_text_backspace"):
		attack /= 10
		$AttackButton.text = str(attack)
		print(attack)
	# fire attack 
	if Input.is_action_just_pressed("ui_text_completion_accept"):
		_on_attack_button_pressed()
	
# Signal Handlers
# =========================================================

func _on_attack_button_pressed() -> void:
	var hit_left := attack % left_horn_value == 0 and attack != 0
	var hit_right := attack % right_horn_value == 0  and attack != 0
	if hit_left:
		print("HIT: %d divides %d" % [left_horn_value, attack])
	if hit_right:
		print("HIT: %d divides %d" % [right_horn_value, attack])
	if hit_left or hit_right:
		randomly_change_horns()
	elif attack == 0:
		print("You do nothing!")
	else:
		print("You MISS!")
	attack = 0
	$AttackButton.text = str(attack)
	
# Private Functions 
# =========================================================

func randomly_change_horns() -> void:
	show_horns("Left", rng.randi_range(1, 15))
	show_horns("Right", rng.randi_range(1, 15))
	
func show_horns(side_of_head: String, value: int) -> void:
	print("%s value = %d" % [side_of_head, value])
	# Store the numeric value of the horns 
	if side_of_head == "Left":
		left_horn_value = value
	else:
		right_horn_value = value
	# initially hide all horns and halos
	for i in range(1, $Enemy.get_child_count()):
		if $Enemy.get_child(i).name.contains(side_of_head):
			$Enemy.get_child(i).hide()
	# show the halos to represent 4, 8, or 12
	var back_halo1: Sprite2D = get_node("Enemy/Halo1%sBack" % side_of_head)
	var front_halo1: Sprite2D = get_node("Enemy/Halo1%sFront" % side_of_head)
	var back_halo2: Sprite2D = get_node("Enemy/Halo2%sBack" % side_of_head)
	var front_halo2: Sprite2D = get_node("Enemy/Halo2%sFront" % side_of_head)
	if value >= 8:
		back_halo2.show()
		front_halo2.show()
		value -= 8
	if value >= 4:
		back_halo1.show()
		front_halo1.show()
	# show the horns to represent the remaining 1, 2, or 3
	var back_horn: Sprite2D = get_node("Enemy/Horn%sBack" % side_of_head)
	var middle_horn: Sprite2D = get_node("Enemy/Horn%sMiddle" % side_of_head)
	var front_horn: Sprite2D = get_node("Enemy/Horn%sFront" % side_of_head)
	if value % 4 == 1:
		middle_horn.show()
	elif value % 4 == 2:
		back_horn.show()
		middle_horn.show()
	elif value % 4 == 3:
		back_horn.show()
		middle_horn.show()
		front_horn.show()
