extends Node2D

var rng = RandomNumberGenerator.new()

# Node Overrides
# =========================================================

func _ready():
	show_horns("Left", rng.randi_range(1, 15))
	show_horns("Right", rng.randi_range(1, 15))

# Signal Handlers
# =========================================================

func _on_button_pressed():
	print()
	show_horns("Left", rng.randi_range(1, 15))
	show_horns("Right", rng.randi_range(1, 15))
	
# Private Functions 
# =========================================================
	
func show_horns(side_of_head: String, value: int):
	print("%s value = %d" % [side_of_head, value])
	# initially hide all horns and halos
	for i in range(1, $Enemy.get_child_count()):
		if $Enemy.get_child(i).name.contains(side_of_head):
			$Enemy.get_child(i).hide()
	# show the halos to represent 4, 8, or 12
	var back_halo1 = get_node("Enemy/Halo1%sBack" % side_of_head)
	var front_halo1 = get_node("Enemy/Halo1%sFront" % side_of_head)
	var back_halo2 = get_node("Enemy/Halo2%sBack" % side_of_head)
	var front_halo2 = get_node("Enemy/Halo2%sFront" % side_of_head)
	if value >= 8:
		back_halo2.show()
		front_halo2.show()
		value -= 8
	if value >= 4:
		back_halo1.show()
		front_halo1.show()
	# show the horns to represent the remaining 1, 2, or 3
	var back_horn = get_node("Enemy/Horn%sBack" % side_of_head)
	var middle_horn = get_node("Enemy/Horn%sMiddle" % side_of_head)
	var front_horn = get_node("Enemy/Horn%sFront" % side_of_head)
	if value % 4 == 1:
		middle_horn.show()
	elif value % 4 == 2:
		back_horn.show()
		middle_horn.show()
	elif value % 4 == 3:
		back_horn.show()
		middle_horn.show()
		front_horn.show()

