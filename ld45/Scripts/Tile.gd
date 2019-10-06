extends Node2D

#export (String) var tile_type

export (int) var grid_width = 8
export (int) var grid_height = 10
export (int) var x_start = 20
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

var grid_x
var grid_y

func grid_to_pixel(x, y):
	# Convert grid coordinates to pixel values
	return Vector2(x * x_off + x_start, y * y_off + y_start)

func destroy():
	call_deferred("free")