extends Node2D

const MAX_HP = 199

@onready var enemy: Enemy = $Enemy
@onready var player_hp_bar: HpBar = $PlayerHealthBar
@onready var enemy_hp_bar: HpBar = $EnemyHealthBar

var attack := 0
var hp := MAX_HP:
	set(new_hp):
		hp = clamp(new_hp, 0, MAX_HP)
		player_hp_bar.set_hp(hp)
	
# Node Overrides
# =========================================================

func _ready() -> void:
	player_hp_bar.setup(MAX_HP, hp)
	enemy.set_hp_bar(enemy_hp_bar)
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
	hp -= attack
	if hp <= 0:
		print("You've been defeated!\n")
