extends "res://Scripts/Tile.gd"

signal game_over
signal piggy_bank_notifier(condition)

export (Array, Color) var colors

onready var sprite = $Sprite
onready var move_point_lbl = $move_point_lbl
onready var notifier_anim = $notifier_sprite/AnimationPlayer

var dir = Vector2(0, 0)
var move_point_value = 0

func _ready():
	set_physics_process(true)
	notifier_anim.play("notifier")

#warning-ignore:unused_argument
func _physics_process(delta):
	move()

func _user_input():
		#use piggy bank
	if Input.is_action_just_pressed("use_stocked_points") && Global.stocked_points > 0:
		SFX.stock_point_used_sound.play()
		move_point_value += Global.stocked_points
		move_point_lbl.text = str(move_point_value)
		Global.stocked_points = 0
		emit_signal("piggy_bank_notifier", "off")

		#show tutorial
		Tutorial.tutorial_part("piggy_bank_used")

	# Calculate the direction the player is trying to go
	dir = Vector2(0, 0)
	if (Input.is_action_just_pressed("ui_up") && grid_y > 0):
		dir = Vector2(0, -1)
	elif (Input.is_action_just_pressed("ui_down") && grid_y < grid_height - 1):
		dir = Vector2(0, 1)
	elif (Input.is_action_just_pressed("ui_right") && grid_x < grid_width - 1):
		dir = Vector2(1, 0)
	elif (Input.is_action_just_pressed("ui_left") && grid_x > 0):
		dir = Vector2(-1, 0)

func move():
	_user_input()

	# Move the player to the new position
	if (dir != Vector2(0, 0) && move_point_value != 0):
		var target = Vector2(grid_x + dir[0], grid_y + dir[1])
		self.position = grid_to_pixel(target[0], target[1])
		grid_x = target[0]
		grid_y = target[1]
		#reduce move point after every move
		move_point_value -= 1
		if move_point_value <= 0:
			move_point_value = 0
			_check_out_piggy_bank()
		move_point_lbl.text = str(move_point_value)
#		increase score after every move
		Global.score += 1
		SFX.player_move_sound.play()

	# Set direction back to nothing
	dir = Vector2(0, 0)

func _check_out_piggy_bank():
	if Global.stocked_points > 0:
		# piggy bank notifier (on)
		emit_signal("piggy_bank_notifier", "on")
		#show tutorial
		Tutorial.tutorial_part("piggy_bank_notifier")

func _on_PlayerTile_area_entered(area):
	if area.is_in_group("point_tile"):
		#color control
		if sprite.modulate == area.choosen_color:
			SFX.gain_point_sound.play()
			move_point_value += area.move_point_value
			#increase score after every succesfull point tile grab
			Global.score += area.move_point_value
			#off piggy bank notifier if it's on (no more need)
			emit_signal("piggy_bank_notifier", "off")
			
			#show tutorial
			Tutorial.tutorial_part("same_colored_point_tile")
		else:
			SFX.lose_point_sound.play()
			move_point_value -= area.move_point_value
			if move_point_value < 0:
				move_point_value = 0
			
			#show tutorial
			Tutorial.tutorial_part("wrong_colored_point_tile")
		#change color
		sprite.modulate = area.choosen_color
		VisualServer.set_default_clear_color(sprite.modulate)
		# assign move point value
		move_point_lbl.text = str(move_point_value)
	
	if area.is_in_group("life_tile"):
		SFX.life_sound.play()
		Global.life += 1
		area.destroy()
		
		#show tutorial (5)
		Tutorial.tutorial_part("life_grabbed")

	if area.is_in_group("bomb_tile"):
		if Global.life > 0:
			SFX.bomb_sound.play()
			Global.life -= 1
			area.destroy()
		elif Global.life == 0:
			SFX.bomb_sound.play()
			area.destroy()
			self.destroy()
			emit_signal("game_over")
		
		#show tutorial
		Tutorial.tutorial_part("bomb_exploded")
	
	if area.is_in_group("stock_point_tile"):
		SFX.stock_point_sound.play()
		Global.stocked_points += randi()%5 + 1
		area.destroy()
		
		#show tutorial (3)
		Tutorial.tutorial_part("piggy_bank_grabbed")

func assign_features(choosen_tile):
	sprite.modulate = choosen_tile.choosen_color
	VisualServer.set_default_clear_color(sprite.modulate)
	move_point_value = choosen_tile.move_point_value
	move_point_lbl.text = str(choosen_tile.move_point_value)

func _on_change_color_timer_timeout():
	var pick_color = colors[randi() % colors.size()]
	sprite.modulate = pick_color
	VisualServer.set_default_clear_color(sprite.modulate)
	#show tutorial
	Tutorial.tutorial_part("color_changed")
