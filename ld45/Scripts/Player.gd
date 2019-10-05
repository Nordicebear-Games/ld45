extends Node2D

export (String) var tile_type

export (int) var grid_width = 8
export (int) var grid_height = 10
export (int) var x_start = 50
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

var grid_x
var grid_y

# Called when the tile enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	# Check for input every frame
	move()

func grid_to_pixel(x, y):
	# Convert grid coordinates to pixel values
	return Vector2(x * x_off + x_start, y * y_off + y_start)

func move():
	# Calculate the direction the player is trying to go
	var dir = Vector2(0, 0)
	
	if (Input.is_action_just_pressed("ui_right") && grid_x < grid_width - 1):
		dir = Vector2(1, 0)
	if (Input.is_action_just_pressed("ui_left") && grid_x > 0):
		dir = Vector2(-1, 0)
#	elif (Input.is_action_just_pressed("ui_up")):
#		dir = Vector2(0, -1)
#	elif (Input.is_action_just_pressed("ui_down")):
#		dir = Vector2(0, 1)
	
	# Move the player to the new position
	if (dir != Vector2(0, 0)):
		var target = Vector2(grid_x + dir[0], grid_y + dir[1])
		position = grid_to_pixel(target[0], target[1])
		grid_x = target[0]
		grid_y = target[1]
	
	# Set direction back to nothing
	dir = Vector2(0, 0)