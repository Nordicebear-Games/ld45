extends "res://Scripts/SpawnedTile.gd"

signal make_it_bomb_tile(old_tile, posX, posY)

export var max_point = 10
export (Array, Color) var colors

onready var sprite = $Sprite
onready var move_point_lbl = $move_point_lbl
onready var point_timer = $point_timer

var rand_move_point

func _ready():
	choose_color()
	move_point("pick")
	point_timer.wait_time = move_timer.wait_time

func choose_color():
	var choosen_color = colors[randi() % colors.size()]
	sprite.modulate = choosen_color

func move_point(con):
	if con == "pick":
		randomize()
		rand_move_point = randi()%max_point + 1
		move_point_lbl.text = str(rand_move_point)
	if con == "reduce":
		if rand_move_point > 0:
			rand_move_point -= 1
			move_point_lbl.text = str(rand_move_point)
			if rand_move_point == 0:
				emit_signal("make_it_bomb_tile", self, self.grid_x, self.grid_y)

func _on_point_timer_timeout():
	move_point("reduce")
