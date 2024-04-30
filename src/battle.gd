extends Node2D

const MAX_HP = 199

@onready var enemy: Enemy = $Enemy
@onready var player_hp_bar: HpBar = $PlayerHealthBar
@onready var enemy_hp_bar: HpBar = $EnemyHealthBar
@onready var end_game_display: Panel = $EndGameDisplay

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
	end_game_display.hide()
	
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
	var player_is_defeated = receive_attack(enemy.ATTACK)
	if player_is_defeated:
		display_end_game(false)
	var enemy_is_defeated = enemy.receive_attack(attack)
	attack = 0
	$AttackButton.text = str(attack)
	if enemy_is_defeated:
		display_end_game(true)

func _on_end_game_ok_pressed():
	hp = MAX_HP
	enemy.reset()
	end_game_display.hide()
	
# Private Helper Functions 
# =========================================================

func receive_attack(attack: int) -> bool:
	print("The enemy attacks!")
	hp -= attack
	if hp <= 0:
		print("You've been defeated!\n")
	return hp <= 0

func display_end_game(player_won: bool) -> void:
	if player_won:
		end_game_display.get_node("Label").text = "You win!"
	else:
		end_game_display.get_node("Label").text = "You're dead"
	end_game_display.show()
