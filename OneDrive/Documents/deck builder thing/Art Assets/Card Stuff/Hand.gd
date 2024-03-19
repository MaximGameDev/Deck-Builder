class_name Hand
extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		if child is CombatCardUI:
			var callable = Callable(self, "_on_card_combat_ui_reparent_requested")
			if not child.is_connected("reparent_requested", callable):
				child.connect("reparent_requested", callable)

func _on_card_combat_ui_reparent_requested(child: CombatCardUI):
	if child.get_parent() != self:
		child.get_parent().remove_child(child)
	if not child.is_a_child_of(self):
		self.add_child(child)
	child.visible = true

func pick_up_card(card: CombatCardUI) -> void:
	# Hide the card without removing it
	card.visible = false  
