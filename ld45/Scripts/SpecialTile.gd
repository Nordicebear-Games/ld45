extends "res://Scripts/SpawnedTile.gd"

func _on_LifeTile_area_entered(area):
	if area.is_in_group("bomb_tile"):
		self.destroy()
