extends Node3D

@export var ray_length: float = 1000.0
@export var camera: Camera3D

# Для отслеживания текущей Area3D под курсором
var current_hovered_area: Area3D = null

func _ready() -> void:
	if not camera:
		camera = get_viewport().get_camera_3d()

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var hit_area = _get_area_under_mouse()
			if hit_area:
				_on_area_clicked(hit_area)

func _physics_process(_delta: float) -> void:
	
	var hit_area = _get_area_under_mouse()
	if hit_area != current_hovered_area:
		if current_hovered_area:
			current_hovered_area._mouse_dont_hovered() #выход из area не тупи дура
		current_hovered_area = hit_area
		if current_hovered_area:
			current_hovered_area._mouse_hovered() #вход в area не тупи дура

func _get_area_under_mouse() -> Area3D:
	var mouse_pos = get_viewport().get_mouse_position()
	
	var origin = camera.project_ray_origin(mouse_pos)
	var end = origin + camera.project_ray_normal(mouse_pos) * ray_length
	
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true   
	query.collide_with_bodies = false 
	
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(query)
	
	if result:
		if result.collider is Area3D:
			return result.collider
	return null

func _on_area_clicked(area: Area3D) -> void:
	area._mouse_clicked()
