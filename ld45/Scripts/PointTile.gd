extends "res://Scripts/SpawnedTile.gd"

signal make_it_bomb_tile(old_tile, posX, posY)

export var max_point = 15
export (Array, Color) var colors

onready var sprite = $Sprite
onready var move_point_lbl = $move_point_lbl
onready var point_timer = $point_timer

var move_point_value
var choosen_color

func _ready():
	choose_color()
	move_point("pick")
	point_timer.wait_time = move_timer.wait_time

func choose_color():
	choosen_color = colors[randi() % colors.size()]
	sprite.modulate = choosen_color

func move_point(con):
	if con == "pick":
		randomize()
		move_point_value = randi()%max_point + 1
		move_point_lbl.text = str(move_point_value)
	if con == "reduce":
		if move_point_value > 0:
			move_point_value -= 1
			move_point_lbl.text = str(move_point_value)
			if move_point_value == 0:
				emit_signal("make_it_bomb_tile", self, self.grid_x, self.grid_y)

func _on_point_timer_timeout():
	move_point("reduce")

func _on_PointTile_area_entered(area):
	if area.is_in_group("bomb_tile"):
		self.destroy()
