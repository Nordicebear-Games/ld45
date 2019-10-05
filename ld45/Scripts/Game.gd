extends Node2D

# Customizable level data
export (int) var grid_width = 8
export (int) var grid_height = 10
export (int) var x_start = 50
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

# Actual level tiles
var level_grid

# Keep up with the object tiles
var player
var bomb

# Loading the tiles that will be used
var tiles = [
	preload("res://Scenes/DefaultTile.tscn"),
	preload("res://Scenes/Player.tscn"),
	preload("res://Scenes/Bomb.tscn")
]

func _ready():
	initGrid()

	# This function will do more when there are more tile types
	draw_level()
	
	initObject(player, 1, 4, grid_height - 1)
	initObject(bomb, 2, 4, 1)

func initGrid():
	# Initialize the grid to all default tiles
	level_grid = []
	for i in range(grid_width):
		level_grid.append([])
		for j in range(grid_height):
			level_grid[i].append(0)

func grid_to_pixel(x, y):
	# Convert grid coordinates to pixel values
	return Vector2(x * x_off + x_start, y * y_off + y_start)

func draw_level():
	# Draw each tile in the level grid
	for i in range(grid_width):
		for j in range(grid_height):
			if (level_grid[i][j] == 0):
				var tile = tiles[0].instance()
				add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])

func initObject(whichTile, tileNo, tilePosX, tilePosY):
	# Initialize the tile object
	whichTile = tiles[tileNo].instance()
	
	# Add the tile object to the game
	add_child(whichTile)
	
	# Set position and tile object variables
	var tile_position = grid_to_pixel(tilePosX, tilePosY)
	whichTile.position = Vector2(tile_position[0], tile_position[1])
	whichTile.grid_x = tilePosX
	whichTile.grid_y =  tilePosY