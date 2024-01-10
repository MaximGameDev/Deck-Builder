class_name Hand
extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		var card_combat_ui := child as CombatCardUI
		card_combat_ui.reparent_requested.connect(_on_card_combat_ui_reparent_requested)


func _on_card_combat_ui_reparent_requested(child: CombatCardUI) -> void:
	child.reparent(self)
