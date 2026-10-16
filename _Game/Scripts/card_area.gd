extends Area3D

@export var visual: Node3D   

const BASE_SCALE := Vector3(1.0, 1.0, 1.0)
const HOVER_OFFSET := Vector3(0.0, 0.1, 0.3)  
const HOVER_SCALE := Vector3(1.05, 1.05, 1.05) 
const CHOOSE_OFFSET := Vector3(0.0, 0.5, 0.3) 
const CHOOSE_SCALE := Vector3(1.1, 1.1, 1.1) 

var is_choose: bool = false

var _tween: Tween


func _mouse_hovered() -> void:
	if !is_choose:
		_lift(HOVER_OFFSET, HOVER_SCALE)


func _mouse_dont_hovered() -> void:
	if !is_choose:
		_lift(Vector3.ZERO, BASE_SCALE)

func _mouse_clicked():
	if !is_choose:
		_lift(CHOOSE_OFFSET, CHOOSE_SCALE)
		is_choose = true
	else: 
		is_choose = false
		_lift(Vector3.ZERO, BASE_SCALE)
	
	
func _lift(pos: Vector3, scale: Vector3) -> void:
	if _tween:
		_tween.kill()    
	_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	_tween.tween_property(visual, "position", pos, 0.12)
	_tween.parallel().tween_property(visual, "scale", scale, 0.12)
