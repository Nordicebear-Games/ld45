extends Node2D

export (PackedScene) var default_tile
export (PackedScene) var aim_tile
export (PackedScene) var player_tile
export (PackedScene) var point_tile
export (PackedScene) var bomb_tile
export (Array, PackedScene) var special_tiles

#Customizable level data
export (int) var grid_width = 8
export (int) var grid_height = 10
export (int) var x_start = 50
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

onready var def_tile_con = $DefaultTileContainer
onready var tile_con = $TileContainer

var level_grid
var player
var bomb
var ins_tile

func _ready():
	initGrid()

	# This function will do more when there are more tile types
	draw_level()
	
	#initialize player
	randomize()
	initPlayer(randi()%8, grid_height / 2)

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
				var tile = default_tile.instance()
				def_tile_con.add_child(tile)
				var pos = grid_to_pixel(i, j)
				tile.position = Vector2(pos[0], pos[1])

func _signal_connect(which_tile):
	if which_tile == "point_tile":
		ins_tile.connect("make_it_bomb_tile", self, "from_point_to_bomb")

func initPlayer(posX, posY):
	# Initialize the player
	player = player_tile.instance()
	
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
	var rand_number = pick_rand_number()
	if rand_number < 10: #instance life or bomb tile
		ins_tile = special_tiles[randi() % special_tiles.size()].instance()
	else:
		ins_tile = point_tile.instance()
		_signal_connect("point_tile")

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

func pick_rand_number():
	randomize()
	return randi()%100 + 1

func from_point_to_bomb(old_tile, posX, posY): #change point tile as bomb tile when move point is 0
	#instance bomb tile
	var ins_bomb_tile = bomb_tile.instance()
	tile_con.add_child(ins_bomb_tile)
	initTile(ins_bomb_tile, posX, posY)
	#destroy old tile
	old_tile.destroy()