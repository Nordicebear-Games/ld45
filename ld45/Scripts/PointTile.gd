extends "res://Scripts/SpawnedTile.gd"

export (Array, Color) var colors

onready var sprite = $Sprite

func _ready():
	chooseColor()

func chooseColor():
	var choosen_color = colors[randi() % colors.size()]
	sprite.modulate = choosen_color