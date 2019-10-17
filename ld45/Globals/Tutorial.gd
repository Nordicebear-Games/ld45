extends CanvasLayer

onready var tutorial_box = $TutorialBox
onready var dialog_box = $TutorialBox/DialogBox
onready var paused_box = $PausedBox

# Variables
var tut_dialog = [
	"Welcome to til0x.",
	"Move your aim with left and right arrow keys and grab the tile which coming towards you.",
	"Tip: Choose a high numbered tile.",
	"You have your own tile now.", 
	"The number of the center means your 'move count'.", 
	"After every move, 'move count'll reduce.",
	"if 'move count' is '0' you can't move.",
	"Now try to grab other tiles and see what happens.",
	"You grabbed 'piggy bank tile', press 'P' to use it. Tip: Use it wisely.",
	"Piggy bank used and 'move count' increased now.",
	"You grabbed a 'life tile' and this gave you an 'extra' life.",
	"You grabbed same colored point tile. Your 'move count' increased!",
	"You grabbed different colored point tile. Your 'move count' reduced!",
	"Color changed.",
	"Bomb exploded. Tip: Stay away from bombs.",
	"You can use piggy bank. Press 'P' to use.",
	"Extra score and move point gained but game speed increased too.",
	"You can use speed up. Press 'S' to use.",
	"Game speed reduced.",
	"Game speed is already slow."]
var page = 0

# Functions
func _ready():
	tutorial_part("init")

func tutorial(con):
	if con == "show":
		tutorial_box.visible = true

func game(con):
	if Global.load_tut():
		if con == "continue":
			get_tree().paused = false
			paused_box.visible = false
		if con == "stop":
			get_tree().paused = true
			paused_box.visible = true

func show_dialog_page(dialog_name, page_no):
	dialog_box.set_bbcode(dialog_name[page_no])
	if dialog_box.get_visible_characters() > dialog_box.get_total_character_count():
		page = page_no
		dialog_box.set_bbcode(dialog_name[page])
		dialog_box.set_visible_characters(0)
	else:
		dialog_box.set_visible_characters(dialog_box.get_total_character_count())

func _on_Timer_timeout():
	dialog_box.set_visible_characters(dialog_box.get_visible_characters()+1)

func tutorial_part(part):
	if part == "init":
		Global.load_tut()
		dialog_box.set_visible_characters(0)
		show_dialog_page(tut_dialog, 0)

	if part == "start":
		tutorial("show")

	if part == "tutorial_1":  
		yield(get_tree().create_timer(4), "timeout")
		game("stop")
		show_dialog_page(tut_dialog, 1)
		yield(get_tree().create_timer(6), "timeout")
		show_dialog_page(tut_dialog, 2)
		game("continue")

	if part == "tutorial_2":
		game("stop")
		show_dialog_page(tut_dialog, 3)
		yield(get_tree().create_timer(3), "timeout")
		show_dialog_page(tut_dialog, 4)
		yield(get_tree().create_timer(5), "timeout")
		show_dialog_page(tut_dialog, 5)
		yield(get_tree().create_timer(4), "timeout")
		show_dialog_page(tut_dialog, 6)
		yield(get_tree().create_timer(4), "timeout")
		show_dialog_page(tut_dialog, 7)
		yield(get_tree().create_timer(4), "timeout")
		game("continue")
		Global.save_tut(false)

	if part == "aim_to_player":
		show_dialog_page(tut_dialog, 3)

	if part == "piggy_bank_grabbed":
		show_dialog_page(tut_dialog, 8)

	if part == "piggy_bank_used":
		show_dialog_page(tut_dialog, 9)

	if part == "life_grabbed":
		show_dialog_page(tut_dialog, 10)

	if part == "same_colored_point_tile":
		show_dialog_page(tut_dialog, 11)

	if part == "wrong_colored_point_tile":
		show_dialog_page(tut_dialog, 12)

	if part == "color_changed":
		show_dialog_page(tut_dialog, 13)
	
	if part == "bomb_exploded":
		show_dialog_page(tut_dialog, 14)

	if part == "piggy_bank_notifier":
		show_dialog_page(tut_dialog, 15)

	if part == "speed_up_used":
		show_dialog_page(tut_dialog, 16)

	if part == "speed_up_notifier":
		show_dialog_page(tut_dialog, 17)

	if part == "game_speed_reduced":
		show_dialog_page(tut_dialog, 18)

	if part == "game_speed_already_slow":
		show_dialog_page(tut_dialog, 19)










