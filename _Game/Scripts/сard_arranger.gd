class_name Hand3D
extends Node3D

@export var card_scene : PackedScene
const SPACING := 1.2       # расстояние между центрами карт (ширина карты 1.4, значит перекрытие)
const FAN_DEG := 5.0       # на сколько градусов наклонена каждая следующая карта
const ARC := 0.06          # насколько крайние карты опущены по дуге
const LAYER_STEP := 0.05   # сдвиг по глубине, чтобы карты не сливались

var cards: Array[Card3D] = []


func add_card(data: CardData) -> void:
	var card: Card3D = card_scene.instantiate()
	add_child(card)
	card.setup(data)
	cards.append(card)
	_layout()


func _layout() -> void:
	var n := cards.size()
	for i in n:
		var offset := i - (n - 1) / 2.0    # для 5 карт: -2, -1, 0, 1, 2
		cards[i].position = Vector3(
			offset * SPACING,
			-offset * offset * ARC,
			i * LAYER_STEP
		)
		cards[i].rotation_degrees = Vector3(0.0, 0.0, -offset * FAN_DEG)
