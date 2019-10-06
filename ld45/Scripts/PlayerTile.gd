extends "res://Scripts/Tile.gd"

export (Array, Color) var colors

onready var sprite = $Sprite
onready var move_point_lbl = $move_point_lbl

var move_point_value = 0

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
	if (dir != Vector2(0, 0) && move_point_value != 0):
		var target = Vector2(grid_x + dir[0], grid_y + dir[1])
		self.position = grid_to_pixel(target[0], target[1])
		grid_x = target[0]
		grid_y = target[1]
		#reduce move point after every move
		move_point_value -= 1
		if move_point_value < 0:
			move_point_value = 0
		move_point_lbl.text = str(move_point_value)
#		print(str(grid_x) + " " + str(grid_y))
	# Set direction back to nothing
	dir = Vector2(0, 0)

func _on_PlayerTile_area_entered(area):
#	print("player tile area")
	if area.is_in_group("point_tile"):
		#color control
		if sprite.modulate == area.choosen_color:
			move_point_value += area.move_point_value
		else:
			move_point_value -= area.move_point_value
			if move_point_value < 0:
				move_point_value = 0
		#change color
		sprite.modulate = area.choosen_color
		# assign move point value
		move_point_lbl.text = str(move_point_value)
		#destroy point tile
#		area.destroy()
	if area.is_in_group("bomb_tile"):
		self.destroy()

func assign_features(choosen_tile):
	sprite.modulate = choosen_tile.choosen_color
	move_point_value = choosen_tile.move_point_value
	move_point_lbl.text = str(choosen_tile.move_point_value)

func _on_change_color_timer_timeout():
	var pick_color = colors[randi() % colors.size()]
	sprite.modulate = pick_color
