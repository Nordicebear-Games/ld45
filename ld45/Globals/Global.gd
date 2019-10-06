extends Node

#Global Variables
var score = 0

#HIGHSCORE
const SAVE_HS_FILE_PATH = "user://highscore.save"

func save_highscore(score):
	if load_highscore() > score:
		return
	
	var save_file = File.new()
	save_file.open(SAVE_HS_FILE_PATH, File.WRITE)
	var hs_data = {
		highscore = score
	}
	save_file.store_line(to_json(hs_data))
	save_file.close()

func load_highscore():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_HS_FILE_PATH):
		return 0
		
	var highscore
	
	save_file.open(SAVE_HS_FILE_PATH, File.READ)
	var hs_data  = parse_json(save_file.get_line())
	return hs_data["highscore"]

func reset_highscore():
	var dir = Directory.new()
	dir.remove(SAVE_HS_FILE_PATH)