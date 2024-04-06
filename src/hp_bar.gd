class_name HpBar
extends ProgressBar

@onready var fraction_label: Label = $FractionLabel

func set_hp(current_hp: int, max_hp: int) -> void:
	value = current_hp
	max_value = max_hp
	fraction_label.text = "%d / %d" % [current_hp, max_hp]
