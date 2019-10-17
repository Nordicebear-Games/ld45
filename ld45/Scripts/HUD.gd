extends CanvasLayer

signal restart_game(state)

onready var score_lbl = $Game_HUD/score_lbl
onready var speed_lbl = $Game_HUD/gamespeed_lbl
onready var life_lbl = $Game_HUD/life_sprite/life_lbl
onready var stock_point_lbl = $Game_HUD/stock_point_sprite/stock_point_lbl
onready var piggy_bank_notifier_sprite = $Game_HUD/stock_point_sprite/notifier_sprite
onready var piggy_bank_notifier_anim = $Game_HUD/stock_point_sprite/notifier_sprite/notifier_anim
onready var gameover_hud = $GameOver_HUD
onready var highscore_lbl = $GameOver_HUD/highscore_lbl
onready var game_panel_anim = $Game_HUD/game_panel_anim
onready var gameover_anim = $GameOver_HUD/gameover_anim
#onready var hud_anim = $hud_anim

var highscore = 0

func _ready():
	game_panel_anim.play("life_and_piggy")

#warning-ignore:unused_argument
func _process(delta):
	score_lbl.text = "Score: " + str(Global.score)
	speed_lbl.text = "Speed: " + str(Global.current_game_speed)
	life_lbl.text = str(Global.life)
	stock_point_lbl.text = str(Global.stocked_points)

func assing_highscore(value):
		Global.save_highscore(value)
		highscore = str(Global.load_highscore()) # update high score
		highscore_lbl.text = "Highscore: " + highscore # assign high score to text

func piggy_bank_notifier(con):
	if con == "on":
		piggy_bank_notifier_sprite.visible = true
		piggy_bank_notifier_anim.play("notifier")
	elif con == "off":
		piggy_bank_notifier_sprite.visible = false
		piggy_bank_notifier_anim.stop()

func game_over():
	Engine.time_scale = Global.default_game_speed
	SFX.game_over_sound.play()
	gameover_hud.visible = true
	assing_highscore(Global.score)
	gameover_anim.play("game_over_panel_collection")
	get_tree().paused = true #pause game

func _on_restart_btn_pressed():
	SFX.button_sound.play()
	gameover_anim.play("game_over_panel_diffusion")

func _on_gameover_anim_animation_finished(anim_name):
#	print(anim_name)
	if anim_name == "game_over_panel_collection":
		gameover_anim.play("restart_button")
	if anim_name == "game_over_panel_diffusion":
		gameover_hud.visible = false
		gameover_anim.stop()
		emit_signal("restart_game", "restart")
