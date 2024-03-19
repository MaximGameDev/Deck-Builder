extends CardStates

func enter() -> void:
	card_combat_ui.update_state_text("Clicked")
	card_combat_ui.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardStates.State.DRAGGING)
