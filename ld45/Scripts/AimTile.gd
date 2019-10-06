extends "res://Scripts/Tile.gd"

signal make_it_player_tile(aim_tile, area, posX, posY)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	move()

func move():
	# Calculate the direction the player is trying to go
	var dir = Vector2(0, 0)
	if (Input.is_action_just_pressed("ui_up") && grid_y > 0):
		dir = Vector2(0, -1)
	elif (Input.is_action_just_pressed("ui_down") && grid_y < grid_height - 1):
		dir = Vector2(0, 1)
	elif (Input.is_action_just_pressed("ui_right") && grid_x < grid_width - 1):
		dir = Vector2(1, 0)
	elif (Input.is_action_just_pressed("ui_left") && grid_x > 0):
		dir = Vector2(-1, 0)

	# Move the player to the new position
	if (dir != Vector2(0, 0)):
		var target = Vector2(grid_x + dir[0], grid_y + dir[1])
		self.position = grid_to_pixel(target[0], target[1])
		grid_x = target[0]
		grid_y = target[1]
#		print(str(grid_x) + " " + str(grid_y))
	# Set direction back to nothing
	dir = Vector2(0, 0)

func _on_AimTile_area_entered(area):
	if area.is_in_group("point_tile"):
		emit_signal("make_it_player_tile", self, area, self.grid_x, self.grid_y)
		self.destroy()
