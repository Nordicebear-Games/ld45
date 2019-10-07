extends CanvasLayer

export (Array, Color) var colors

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
	VisualServer.set_default_clear_color(pick_color)

func _on_Start_btn_pressed():
	SFX.button_sound.play()
	Global.change_scene("Game")
