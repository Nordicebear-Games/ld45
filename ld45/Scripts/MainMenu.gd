extends CanvasLayer

export (Array, Color) var colors

onready var background = $Background
onready var anim = $AnimationPlayer

func _ready():
	anim.play("anim")
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

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.change_scene("Game")
