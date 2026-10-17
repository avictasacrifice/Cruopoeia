class_name Card3D
extends Node3D

var data: CardData

@onready var cost_label: Label3D = $Visual/CostLabel
@onready var name_label: Label3D = $Visual/NameLabel
@onready var desc_label: Label3D = $Visual/DescLabel
@onready var mesh: MeshInstance3D = $Visual/card0/Plane


func setup(card_data: CardData) -> void:
	data = card_data
	cost_label.visible = data.has_cost
	cost_label.text = str(data.cost)
	name_label.text = data.card_name
	desc_label.text = data.description
	if data.art:
		var mat := StandardMaterial3D.new()
		mat.albedo_texture = data.art
		mesh.material_override = mat
