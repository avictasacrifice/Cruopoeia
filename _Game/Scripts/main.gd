extends Node3D

@export var test_card: CardData

@export var hand : Node3D


func _ready() -> void:
	for i in 5:
		hand.add_card(test_card)
