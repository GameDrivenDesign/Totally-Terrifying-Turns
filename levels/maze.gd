extends TileMap

var wall_id
var door_areas = []
var path_id

func add_light_occluder(wall_position):
	var neighbor_data = [Vector2(-1, 0), Vector2(0, -1), Vector2(1, 0), Vector2(0, 1)]
	var occluder_data = []
	for data in neighbor_data:
		var neighbor_id = get_cellv(wall_position + data)
		occluder_data.append(8 if neighbor_id == wall_id else 6)
			
	var origin = to_local(map_to_world(wall_position)) + Vector2(8, 8)
	#print("Origin for " + var2str(wall_position) + ": " + var2str(origin))
	var polygon_indices = PoolVector2Array([
		origin + Vector2(-occluder_data[0], -occluder_data[1]),
		origin + Vector2(occluder_data[2], -occluder_data[1]),
		origin + Vector2(occluder_data[2], occluder_data[3]),
		origin + Vector2(-occluder_data[0], occluder_data[3])])
	var polygon = OccluderPolygon2D.new()
	polygon.set_polygon(polygon_indices)
	var occluder = LightOccluder2D.new()
	occluder.set_occluder_polygon(polygon)
	add_child(occluder)
	
func add_door_area(position):#
	var origin = to_local(map_to_world(position)) + Vector2(8, 8)
	var area = preload("res://door_area.tscn").instance()
	area.global_position = origin
	area.connect("body_entered", self, "_on_door_area_entered")
	add_child(area)
	door_areas.append(area)

func add_nav_mesh(path_position):
	var neighbor_data = [Vector2(-1, 0), Vector2(0, -1), Vector2(1, 0), Vector2(0, 1)]
	var navmesh_data = []
	for data in neighbor_data:
		var neighbor_id = get_cellv(path_position + data)
		navmesh_data.append(8 if neighbor_id == path_id else 2)
	
	var origin = to_local(map_to_world(path_position)) + Vector2(8, 8)
	
	var polygon_vertices = PoolVector2Array([
		origin + Vector2(-navmesh_data[0], -navmesh_data[1]),
		origin + Vector2(navmesh_data[2], -navmesh_data[1]),
		origin + Vector2(navmesh_data[2], navmesh_data[3]),
		origin + Vector2(-navmesh_data[0], navmesh_data[3])])
		
	var polygon = NavigationPolygon.new()
	polygon.add_outline(polygon_vertices)
	polygon.make_polygons_from_outlines()
	var nav_poly = NavigationPolygonInstance.new()
	nav_poly.set_navigation_polygon(polygon)
	add_child(nav_poly)
	
func _ready():

	wall_id = get_tileset().find_tile_by_name("wall")
	path_id = get_tileset().find_tile_by_name("path")
	var wall_positions = get_used_cells_by_id(wall_id)
	var path_positions = get_used_cells_by_id(path_id)
	for wall_position in wall_positions:
		add_light_occluder(wall_position)
	
	var door_id = get_tileset().find_tile_by_name("door")
	var door_positions = get_used_cells_by_id(door_id)
	for door_position in door_positions:
		add_door_area(door_position)

	for path_position in path_positions:
		add_nav_mesh(path_position)

func _on_door_area_entered(body):
	if body.is_in_group("players"):
		if body.keys >= 1:
			for door_area in door_areas:
				if door_area.overlaps_body(body):
					var door_pos = world_to_map(door_area.global_position)
					set_cellv(
						door_pos,
						get_tileset().find_tile_by_name("door_open"),
						is_cell_x_flipped(door_pos.x, door_pos.y),
						is_cell_y_flipped(door_pos.x, door_pos.y),
						is_cell_transposed(door_pos.x, door_pos.y)
					)
					body.keys = body.keys - 1
