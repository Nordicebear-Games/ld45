extends Node2D

export (Array, PackedScene) var spawned_tiles

#Customizable level data
export (int) var grid_width = 8
export (int) var grid_height = 10
export (int) var x_start = 50
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

onready var def_tile_con = $DefaultTileContainer
onready var tile_con = $TileContainer

# Actual level tiles
var level_grid
#Keep up with the object tiles
var player
var bomb
#Loading the tiles that will be used
var tiles = [
	preload("res://Scenes/DefaultTile.tscn"),
	preload("res://Scenes/PlayerTile.tscn")
]

func _ready():
	initGrid()

	# This function will do more when there are more tile types
	draw_level()
	
	#initialize player
	randomize()
	initPlayer(randi()%8, grid_height - 1)

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
				def_tile_con.add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])

func initPlayer(posX, posY):
	# Initialize the player
	player = tiles[1].instance()
	
	# Add the tile object to the game
	add_child(player)
	
	# Set position and player variables
	var player_position = grid_to_pixel(posX, posY)
	player.position = Vector2(player_position[0], player_position[1])
	player.grid_x = posX
	player.grid_y =  posY

func _on_SpawnObjectTimer_timeout():
	chooseTileAndInit()

func chooseTileAndInit():
		var ins_tile = spawned_tiles[randi() % spawned_tiles.size()].instance() #choose a object and instance it
		tile_con.add_child(ins_tile)
		#initialize the choosen object
		randomize()
		initTile(ins_tile, randi()%8, 0)

func initTile(whichTile, tilePosX, tilePosY):
	# Set position and tile object variables
	var tile_position = grid_to_pixel(tilePosX, tilePosY)
	whichTile.position = Vector2(tile_position[0], tile_position[1])
	whichTile.grid_x = tilePosX
	whichTile.grid_y =  tilePosY
