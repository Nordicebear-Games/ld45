extends "res://Scripts/Tile.gd"

func _on_move_timer_timeout():
	move()

func move():
	# Calculate the direction the bomb is trying to go
	var dir = Vector2(0, 0)
	
	dir = Vector2(0, 1)
	
	# Move the bomb to the new position
	if (dir != Vector2(0, 0)):
		var target = Vector2(grid_x + dir[0], grid_y + dir[1])
		position = grid_to_pixel(target[0], target[1])
		grid_x = target[0]
		grid_y = target[1]

