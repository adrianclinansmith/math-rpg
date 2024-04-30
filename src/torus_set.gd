class_name TorusSet
extends Node2D

@export var front: SpriteFrames
@export var back: SpriteFrames

func _ready() -> void:
	$FlatFront.sprite_frames = front
	$FlatBack.sprite_frames = back
