class_name HpBar
extends ProgressBar

@onready var fraction_label: Label = $FractionLabel

func setup(max_hp: int, current_hp: int) -> void:
	max_value = max_hp
	set_hp(current_hp)

func set_hp(current_hp: int) -> void:
	value = current_hp
	fraction_label.text = "%d / %d" % [value, max_value]
