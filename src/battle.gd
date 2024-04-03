extends Node2D

@onready var enemy: Enemy = $Enemy

var attack := 0

# Node Overrides
# =========================================================

func _ready() -> void:
	enemy.randomly_change_horns()
	enemy.change_logic_operator()
	
func _process(delta: float) -> void:
	# increase attack power
	for digit in 10:
		if Input.is_action_just_pressed(str("ui_", digit)):
			attack = attack * 10 + digit
			$AttackButton.text = str(attack)
	# decrease attack power
	if Input.is_action_just_pressed("ui_text_backspace"):
		attack /= 10
		$AttackButton.text = str(attack)
	# launch attack 
	if Input.is_action_just_pressed("ui_text_completion_accept"):
		_on_attack_button_pressed()
	# change enemy's logical operator
	if Input.is_action_just_pressed("ui_select"):
		enemy.change_logic_operator()
	
# Signal Handlers
# =========================================================

func _on_attack_button_pressed() -> void:
	enemy.receive_attack(attack)
	attack = 0
	$AttackButton.text = str(attack)
	
# Private Helper Functions 
# =========================================================

