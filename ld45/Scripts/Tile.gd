extends Node2D

#warning-ignore:unused_class_variable
export (int) var grid_width = 8
#warning-ignore:unused_class_variable
export (int) var grid_height = 10
#warning-ignore:unused_class_variable
export (int) var x_start = 20
#warning-ignore:unused_class_variable
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

onready var anim = $Sprite/AnimationPlayer

var grid_x
var grid_y

func _ready():
	if anim != null:
		anim.play("anim")

func grid_to_pixel(x, y):
	# Convert grid coordinates to pixel values
	return Vector2(x * x_off + x_start, y * y_off + y_start)

func destroy():
	call_deferred("free")