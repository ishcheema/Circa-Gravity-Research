
extends Node3D

var player: CharacterBody3D
var camera: Camera3D
var gravity_strength := 9.8
var gravity_label: Label
var speed := 6.0
var mouse_sensitivity := 0.003
var pitch := -0.2

func _ready() -> void:
	_make_world()
	_make_ui()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _make_world() -> void:
	var light := DirectionalLight3D.new()
	light.rotation_degrees = Vector3(-55, -30, 0)
	add_child(light)

	# Floor
	var floor_body := StaticBody3D.new()
	add_child(floor_body)

	var floor_mesh := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(35, 1, 35)
	floor_mesh.mesh = box
	floor_mesh.position.y = -0.5
	floor_body.add_child(floor_mesh)

	var floor_collision := CollisionShape3D.new()
	var floor_shape := BoxShape3D.new()
	floor_shape.size = Vector3(35, 1, 35)
	floor_collision.shape = floor_shape
	floor_collision.position.y = -0.5
	floor_body.add_child(floor_collision)

	# Player
	player = CharacterBody3D.new()
	player.position = Vector3(0, 2, 0)
	add_child(player)

	var player_mesh := MeshInstance3D.new()
	var capsule := CapsuleMesh.new()
	capsule.radius = 0.4
	capsule.height = 1.8
	player_mesh.mesh = capsule
	player.add_child(player_mesh)

	var collider := CollisionShape3D.new()
	var shape := CapsuleShape3D.new()
	shape.radius = 0.4
	shape.height = 1.8
	collider.shape = shape
	player.add_child(collider)

	# Camera
	camera = Camera3D.new()
	camera.current = true
	camera.position = Vector3(0, 2.5, 6)
	player.add_child(camera)

	# Blocks with collision
	for i in range(6):
		var block_body := StaticBody3D.new()
		block_body.position = Vector3(-10 + i * 4, 0.5 + i * 0.15, -8)
		add_child(block_body)

		var landmark := MeshInstance3D.new()
		var landmark_mesh := BoxMesh.new()
		landmark_mesh.size = Vector3(1.5, 1.0 + i * 0.3, 1.5)
		landmark.mesh = landmark_mesh
		block_body.add_child(landmark)

		var block_collision := CollisionShape3D.new()
		var block_shape := BoxShape3D.new()
		block_shape.size = landmark_mesh.size
		block_collision.shape = block_shape
		block_body.add_child(block_collision)

func _make_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	var panel := VBoxContainer.new()
	panel.position = Vector2(20, 20)
	layer.add_child(panel)

	var title := Label.new()
	title.text = "CIRCA | Gravity Research Demo"
	panel.add_child(title)

	gravity_label = Label.new()
	panel.add_child(gravity_label)

	var choices := OptionButton.new()
	choices.add_item("Low gravity (3.0)")
	choices.add_item("Normal gravity (9.8)")
	choices.add_item("High gravity (20.0)")
	choices.add_item("Extreme gravity (35.0)")
	choices.select(1)
	choices.item_selected.connect(_change_gravity)
	panel.add_child(choices)

	var reset := Button.new()
	reset.text = "Reset Player"
	reset.pressed.connect(_reset_player)
	panel.add_child(reset)

	var help := Label.new()
	help.text = "WASD: move | Space: jump | Mouse: look | Esc: release mouse"
	panel.add_child(help)

	_update_label()

func _change_gravity(index: int) -> void:
	var values := [3.0, 9.8, 20.0, 35.0]
	gravity_strength = values[index]
	_update_label()

func _update_label() -> void:
	gravity_label.text = "Gravity: %.1f m/s²" % gravity_strength

func _reset_player() -> void:
	player.global_position = Vector3(0, 2, 0)
	player.velocity = Vector3.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		player.rotate_y(-event.relative.x * mouse_sensitivity)
		pitch = clamp(pitch - event.relative.y * mouse_sensitivity, -1.1, 0.7)
		camera.rotation.x = pitch

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= gravity_strength * delta

	if Input.is_key_pressed(KEY_SPACE) and player.is_on_floor():
		player.velocity.y = 7.5

	var movement := Vector2.ZERO
	if Input.is_key_pressed(KEY_W):
		movement.y -= 1
	if Input.is_key_pressed(KEY_S):
		movement.y += 1
	if Input.is_key_pressed(KEY_A):
		movement.x -= 1
	if Input.is_key_pressed(KEY_D):
		movement.x += 1

	movement = movement.normalized()

	var direction := player.global_transform.basis * Vector3(movement.x, 0, movement.y)

	var current_speed := 10.0 if Input.is_key_pressed(KEY_SHIFT) else speed
	player.velocity.x = direction.x * current_speed
	player.velocity.z = direction.z * current_speed

	player.move_and_slide()
