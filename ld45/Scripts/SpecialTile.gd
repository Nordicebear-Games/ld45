extends "res://Scripts/SpawnedTile.gd"

func _on_BombTile_area_entered(area):
	if area.is_in_group("bomb_tile"):
		self.destroy()

func _on_LifeTile_area_entered(area):
	if (area.is_in_group("bomb_tile") ||
		area.is_in_group("life_tile") ||
		area.is_in_group("turtle_tile")):
		self.destroy()

func _on_StockPointTile_area_entered(area):
	if (area.is_in_group("bomb_tile") || 
		area.is_in_group("stock_point_tile") ||
		area.is_in_group("life_tile")):
		self.destroy()

func _on_TurtleTile_area_entered(area):
	if (area.is_in_group("bomb_tile") || 
		area.is_in_group("turtle_tile") ||
		area.is_in_group("stock_point_tile")):
		self.destroy()
