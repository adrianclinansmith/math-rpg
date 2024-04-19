class_name HornItem
extends Node2D

@export var grow_frames: SpriteFrames
@export var shatter_frames: SpriteFrames

@onready var grow_sprite: AnimatedSprite2D = $Grow
@onready var shatter_sprite: AnimatedSprite2D = $Shatter

var flip: bool:
	set(b):
		grow_sprite.flip_h = b
		shatter_sprite.flip_h = b

var is_grown := false

func _ready() -> void:
	grow_sprite.sprite_frames = grow_frames
	grow_sprite.hide()
	shatter_sprite.sprite_frames = shatter_frames
	shatter_sprite.hide()

func shatter_if_grown() -> void:
	if is_grown:
		grow_sprite.hide()
		shatter_sprite.show()
		shatter_sprite.play("default")
		is_grown = false
	
	
func grow_item() -> void:
	grow_sprite.show()
	grow_sprite.play("default")
	is_grown = true

func _on_shatter_animation_finished():
	shatter_sprite.hide()
