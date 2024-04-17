class_name HornItem
extends AnimatedSprite2D

@onready var shatter: AnimatedSprite2D = $Shatter

var flip := false:
	set(boolean):
		flip_h = boolean
		shatter.flip_h = boolean

# Node Overrides
# ==============================================================================

func _ready() -> void:
	# initially hide the horn/halo
	frame = 0
	shatter.hide()

# Public Methods
# ==============================================================================

func shatter_if_out() -> void:
	if frame != 0:
		shatter.show()
		shatter.play()
		frame = 0

# Signals
# ==============================================================================

func _on_shatter_animation_finished():
	# cleanup the pieces once the animation is finished
	shatter.hide()
