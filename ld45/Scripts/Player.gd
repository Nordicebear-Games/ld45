extends "res://Scripts/Tile.gd"

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	move()

func move():
	# Calculate the direction the player is trying to go
	var dir = Vector2(0, 0)
	
	if (Input.is_action_just_pressed("ui_right") && grid_x < grid_width - 1):
		dir = Vector2(1, 0)
	if (Input.is_action_just_pressed("ui_left") && grid_x > 0):
		dir = Vector2(-1, 0)

	# Move the player to the new position
	if (dir != Vector2(0, 0)):
		var target = Vector2(grid_x + dir[0], grid_y + dir[1])
		position = grid_to_pixel(target[0], target[1])
		grid_x = target[0]
		grid_y = target[1]
	
	# Set direction back to nothing
	dir = Vector2(0, 0)