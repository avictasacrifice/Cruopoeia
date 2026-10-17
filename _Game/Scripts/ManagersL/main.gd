extends Node3D

@export var hand_cards: Array[CardData]
@export var hand: Hand3D


func _ready() -> void:
	for data in hand_cards:
		hand.add_card(data)
