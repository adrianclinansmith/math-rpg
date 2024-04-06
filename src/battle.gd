extends Node2D

const MAX_HEALTH = 200

@onready var enemy: Enemy = $Enemy
@onready var player_hp_bar: HpBar = $PlayerHealthBar

var attack := 0
var health := MAX_HEALTH: 
	set(new_health):
		health = clamp(new_health, 0, MAX_HEALTH)
		player_hp_bar.set_hp(health, MAX_HEALTH)
	
# Node Overrides
# =========================================================

func _ready() -> void:
	player_hp_bar.set_hp(health, MAX_HEALTH)
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
	receive_attack(enemy.ATTACK)
	enemy.receive_attack(attack)
	attack = 0
	$AttackButton.text = str(attack)
	
# Private Helper Functions 
# =========================================================

func receive_attack(attack: int) -> void:
	print("The enemy attacks!")
	health -= attack
	print("Your health: %d/%d" % [health, MAX_HEALTH])
	if health <= 0:
		print("You've been defeated!\n")
