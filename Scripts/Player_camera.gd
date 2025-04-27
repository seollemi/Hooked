class_name PlayerCamera extends Camera2D

var tilemap: TileMapLayer

func _ready() -> void:
	await get_tree().process_frame
	
	var tilemaps:=get_tree().get_nodes_in_group("tilemaps")
	for map in tilemaps:
		if map.name == "baseground":
			tilemap = map
	setup_camera_limits()



func setup_camera_limits():
	if not tilemap:
		return
	
	var used_rect : Rect2i = tilemap.get_used_rect()
	var tilemap_size := tilemap.tile_set.get_tile_size()

	limit_left = used_rect.position.x * tilemap_size.x
	limit_top = used_rect.position.y * tilemap_size.y
	limit_right = (used_rect.position.x + used_rect.size.x) * tilemap_size.x
	limit_bottom = (used_rect.position.y + used_rect.size.y) * tilemap_size.y
