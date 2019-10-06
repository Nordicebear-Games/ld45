extends Node2D

export (PackedScene) var default_tile
export (PackedScene) var aim_tile
export (PackedScene) var player_tile
export (PackedScene) var point_tile
export (PackedScene) var bomb_tile
export (Array, PackedScene) var special_tiles

#Customizable level data
export (int) var max_point_tile_in_a_row = 5
export (int) var grid_width = 8
export (int) var grid_height = 10
export (int) var x_start = 50
export (int) var y_start = 15
export (int) var x_off = 32
export (int) var y_off = 32

onready var def_tile_con = $DefaultTileContainer
onready var tile_con = $TileContainer

var level_grid
var ins_aim
var ins_tile

func _ready():
	initGrid()

	# This function will do more when there are more tile types
	draw_level()
	
	#initialize aim
	randomize()
	init_aim_tile(randi()%grid_width, grid_height / 2)

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
	if which_tile == "aim_tile":
		ins_aim.connect("make_it_player_tile", self, "from_aim_to_player")

func init_aim_tile(posX, posY):
	# Initialize the aim
	ins_aim = aim_tile.instance()
	
	# Add the tile object to the game
	add_child(ins_aim)
	
	#signal connect
	_signal_connect("aim_tile")
	
	# Set position and aim variables
	var aim_position = grid_to_pixel(posX, posY)
	ins_aim.position = Vector2(aim_position[0], aim_position[1])
	ins_aim.grid_x = posX
	ins_aim.grid_y =  posY

func _on_SpawnTileTimer_timeout():
	randomize()
	var rand_spawn_rate = randi()%max_point_tile_in_a_row
	print(rand_spawn_rate)
	for i in rand_spawn_rate:
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
	initTile(ins_tile, randi()%grid_width, 0)

func initTile(whichTile, tilePosX, tilePosY):
	# Set position and tile object variables
	var tile_position = grid_to_pixel(tilePosX, tilePosY)
	whichTile.position = Vector2(tile_position[0], tile_position[1])
	whichTile.grid_x = tilePosX
	whichTile.grid_y =  tilePosY

func pick_rand_number():
	randomize()
	return randi()%100 + 1

func from_aim_to_player(aim_tile, choosen_tile, posX, posY):
	#instance player tile
	var ins_player_tile = player_tile.instance()
#	call_deferred("add_child", ins_player_tile)
	add_child(ins_player_tile)
	#assign position
	initTile(ins_player_tile, posX, posY)
	#assign features
	ins_player_tile.assign_features(choosen_tile)
	#destroy unused tiles
	choosen_tile.destroy()

func from_point_to_bomb(point_tile, posX, posY): #change point tile as bomb tile when move point is 0
	#instance bomb tile
	var ins_bomb_tile = bomb_tile.instance()
	tile_con.add_child(ins_bomb_tile)
	#assign position
	initTile(ins_bomb_tile, posX, posY)
	#destroy old point tile
	point_tile.destroy()