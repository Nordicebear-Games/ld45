extends CanvasLayer

export (Array, Color) var colors

onready var background = $Background
onready var anim = $main_menu_anim

func _ready():
	anim.play("menu collection")
	change_background_color()

func _on_color_change_timer_timeout():
	change_background_color()

func change_background_color():
	randomize()
	var pick_color = colors[randi() % colors.size()]
	#set background color
#	VisualServer.set_default_clear_color(pick_color)
	background.modulate = pick_color;

func _on_Start_btn_pressed():
	SFX.button_sound.play()
	anim.play("menu_diffusion")

func _on_main_menu_anim_animation_finished(anim_name):
	if anim_name == "menu collection":
		anim.play("start_button")
	if anim_name == "menu_diffusion":
		Global.change_scene("Game")
