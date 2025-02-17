extends Camera2D

@export var camera_speed: float = 200.0
@export var zoom_speed: float = 0.1  # Adjust this for zoom sensitivity
@export var min_zoom: float = 0.1  # Minimum zoom level
@export var max_zoom: float = 3.0  # Maximum zoom level

func _process(delta):
	# Handle movement with arrow keys
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	position += input_vector.normalized() * camera_speed * delta

# Detect mouse scroll wheel to zoom
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		# Zoom in
		zoom = clamp(zoom - Vector2(zoom_speed, zoom_speed), Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		# Zoom out
		zoom = clamp(zoom + Vector2(zoom_speed, zoom_speed), Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

	# Handle keyboard zoom (Q and E keys)
	if Input.is_action_pressed("zoom_in"):  # Q key, assuming ui_select is mapped to Q
		zoom = clamp(zoom - Vector2(zoom_speed, zoom_speed), Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))

	if Input.is_action_pressed("zoom_out"):  # E key, assuming ui_cancel is mapped to E
		zoom = clamp(zoom + Vector2(zoom_speed, zoom_speed), Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
