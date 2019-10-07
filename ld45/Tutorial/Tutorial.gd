extends Control

onready var dialog_box = $DialogBox

# Variables
var dialog = [
	"Welcome to til0x.",
	"Move your aim with left and right arrow keys and grab the tile which coming towards you.",
	"Tip: Choose a high numbered tile",
	"Now you have your own tile. The number of the center means your move count. if it's 0 you can't move.",
	"With your own tile  you can move now and down too but after every move, move count'll reduce.",
	"You have no life or extra points for now.",
	"You can gain them. If you grab a life tile or piggy bank tile. Try if you see one.",
	"You grabbed piggy bank tile, press 'S' to use it. Tip: Use this wisely.",
	"Piggy bank used and move count increased now.",
	"You grabbed a life tile and this gave you an extra life.",
	"You grabbed same colored point tile. Your move count increased!",
	"You grabbed wrong colored point tile. Your move count reduced!"]
var page = 0

# Functions
func _ready():
	dialog_box.set_visible_characters(0)
	show_tut_page(0)

func tutorial(con):
	if con == "show":
		self.visible = true

func game(con):
	if con == "continue":
		get_tree().paused = false
	if con == "stop":
		get_tree().paused = true

func show_tut_page(page_no):
	dialog_box.set_bbcode(dialog[page_no])
	if dialog_box.get_visible_characters() > dialog_box.get_total_character_count():
		page = page_no
		dialog_box.set_bbcode(dialog[page])
		dialog_box.set_visible_characters(0)
	else:
		dialog_box.set_visible_characters(dialog_box.get_total_character_count())

func _on_Timer_timeout():
	dialog_box.set_visible_characters(dialog_box.get_visible_characters()+1)

func tutorial_part(part):
	if part == "start":
		tutorial("show")
		game("stop")
		yield(get_tree().create_timer(3), "timeout")
		show_tut_page(1)
		yield(get_tree().create_timer(5), "timeout")
		show_tut_page(2)
		yield(get_tree().create_timer(3), "timeout")
		game("continue")

	if part == "aim_to_player":
		game("stop")
		show_tut_page(3)
		yield(get_tree().create_timer(8), "timeout")
		show_tut_page(4)
		yield(get_tree().create_timer(6), "timeout")
		show_tut_page(5)
		yield(get_tree().create_timer(5), "timeout")
		show_tut_page(6)
		yield(get_tree().create_timer(5), "timeout")
		game("continue")

	if part == "piggy_bank_grabbed":
		game("stop")
		show_tut_page(7)
		yield(get_tree().create_timer(8), "timeout")
		game("continue")

	if part == "piggy_bank_used":
		game("stop")
		show_tut_page(8)
		yield(get_tree().create_timer(5), "timeout")
		game("continue")

	if part == "life_grabbed":
		game("stop")
		show_tut_page(9)
		yield(get_tree().create_timer(5), "timeout")
		game("continue")

	if part == "same_colored_point_tile":
		show_tut_page(10)
#		yield(get_tree().create_timer(5), "timeout")

	if part == "wrong_colored_point_tile":
		show_tut_page(11)
#		yield(get_tree().create_timer(5), "timeout")












