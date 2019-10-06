extends CanvasLayer

onready var score_lbl = $Game_HUD/score_lbl

func _process(delta):
	score_lbl.text = "Score: " + str(Global.score)