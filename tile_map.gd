extends TileMap

# Time interval between replications (in seconds)
@export var replication_interval: float = 1.0

# Tile parameters
@export var tile_id: int = 0  # Replace with your specific tile ID
@export var layer: int = 0  # Layer index, typically 0 if you have a single layer

# List to keep track of current tile positions
var tile_positions: Array[Vector2i] = []

func _ready():
	# Initialize with a single tile at the center
	var center_cell = Vector2i(0, 0)
	set_cell(layer, center_cell, tile_id)
	tile_positions.append(center_cell)
	
	# Start the replication process
	start_replication()

func start_replication():
	# Set up a timer to call the replication function periodically
	var timer = Timer.new()
	timer.wait_time = replication_interval
	timer.connect("timeout", Callable(self, "replicate_tile"))
	add_child(timer)
	timer.start()

func replicate_tile():
	# Choose a random existing tile position
	var random_index = randi() % tile_positions.size()
	var base_position = tile_positions[random_index]
	
	# Determine a random adjacent position
	var directions = [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]
	var random_direction = directions[randi() % directions.size()]
	var new_position = base_position + random_direction
	
	# Check if the new position is already occupied
	if get_cell_source_id(layer, new_position) == -1:
		# Place the new tile
		set_cell(layer, new_position, tile_id)
		tile_positions.append(new_position)
