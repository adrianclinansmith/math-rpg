class_name HornSet
extends Node2D

@export var flip_h := false

@onready var halo_x_back: AnimatedSprite2D = $HaloXBack
@onready var halo_flat_back: AnimatedSprite2D = $HaloFlatBack
@onready var horn_back: AnimatedSprite2D = $HornBack
@onready var horn_middle: AnimatedSprite2D = $HornMiddle
@onready var horn_front: AnimatedSprite2D = $HornFront
@onready var halo_x_front: AnimatedSprite2D = $HaloXFront
@onready var halo_flat_front: AnimatedSprite2D = $HaloFlatFront

var value := 0

# Node Overrides
# ==============================================================================

func _ready():
	print("ready horn: %s" % halo_flat_back)
	if flip_h:
		halo_x_back.flip_h = true
		halo_flat_back.flip_h = true
		horn_back.flip_h = true
		horn_middle.flip_h = true
		horn_front.flip_h = true
		halo_x_front.flip_h = true
		halo_flat_front.flip_h = true

# Public Methods
# ==============================================================================
func change(value: int) -> void:
	# Store the numeric value of the horns 
	self.value = value
	# initially hide all horns and halos
	halo_x_back.frame = 0
	halo_flat_back.frame = 0
	horn_back.frame = 0
	horn_middle.frame = 0
	horn_front.frame = 0
	halo_x_front.frame = 0
	halo_flat_front.frame = 0
	# show the halos to represent 4, 8, or 12
	if value >= 8:
		halo_x_back.play("default")
		halo_x_front.play("default")
		value -= 8
	if value >= 4:
		halo_flat_back.play("default")
		halo_flat_front.play("default")
	# show the horns to represent the remaining 1, 2, or 3
	if value % 4 == 1:
		horn_middle.play("default")
	elif value % 4 == 2:
		horn_back.play("default")
		horn_middle.play("default")
	elif value % 4 == 3:
		horn_back.play("default")
		horn_middle.play("default")
		horn_front.play("default")
