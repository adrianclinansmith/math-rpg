class_name HornSet
extends Node2D

@export var flip_h := false

#@onready var halo_x_back: HornItem = $HaloXBack
#@onready var halo_flat_back: HornItem = $HaloFlatBack
@onready var horn_back: HornItem = $HornBack
@onready var horn_middle: HornItem = $HornMiddle
@onready var horn_front: HornItem = $HornFront
#@onready var halo_x_front: HornItem = $HaloXFront
#@onready var halo_flat_front: HornItem = $HaloFlatFront

var value := 0

# Node Overrides
# ==============================================================================

func _ready():
	for horn_item: HornItem in get_children():
		horn_item.flip = flip_h

# Public Methods
# ==============================================================================

func shatter_and_regrow(value: int) -> void:
	print("%s = %d" % [name, value])
	# Store the numeric value of the horns 
	self.value = value
	# initially hide all horns and halos
	for horn_item: HornItem in get_children():
			horn_item.shatter_if_grown()
	# show the halos to represent 4, 8, or 12
	#if value >= 8:
		#halo_x_back.grow_item()
		#halo_x_front.grow_item()
		#value -= 8
	#if value >= 4:
		#halo_flat_back.grow_item()
		#halo_flat_front.grow_item()
	# show the horns to represent the remaining 1, 2, or 3
	if value % 4 == 1:
		horn_middle.grow_item()
	elif value % 4 == 2:
		horn_back.grow_item()
		horn_middle.grow_item()
	elif value % 4 == 3:
		horn_back.grow_item()
		horn_middle.grow_item()
		horn_front.grow_item()
