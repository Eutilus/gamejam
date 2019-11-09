extends TileMap

var current_map_size = Vector2(200,200)
var percentage_floors = 45.0

var neighbor_dir = [Vector2(1,0), Vector2(1,1), Vector2(0,1),
					Vector2(-1,0), Vector2(-1,-1), Vector2(0,-1),
					Vector2(1,-1), Vector2(-1,1)]


func _ready():
	randomize()
	make_map()
	smooth_map()
	smooth_map()


#func _process(delta):
	

func make_map():
	for x in range(1,current_map_size.x-1):
		for y in range(1, current_map_size.y-1):
			var num = rand_range(0.0,100.0)
			if num < percentage_floors:
				set_cell(x,y, randi()%19+18)
			else:
				set_cell(x,y, randi()%19)
	for x in [0, current_map_size.x - 1]:
		for y in current_map_size.y:
			set_cell(x,y, randi()%19)
	
	for x in current_map_size.x:
		for y in [0, current_map_size.y - 1]:
			set_cell(x, y, randi()%19)

func smooth_map():
	for x in range (1, current_map_size.x - 1):
		for y in range (1, current_map_size.y - 1):
			var number_of_neighbor_walls = 0
			for direction in neighbor_dir:
				var current_tile = Vector2(x,y) + direction
				if get_cell(current_tile.x, current_tile.y) < 18:
					number_of_neighbor_walls += 1 
			if number_of_neighbor_walls > 4:
				set_cell(x,y, randi()%19)
			elif number_of_neighbor_walls < 4:
				set_cell(x,y, randi()%19+18)