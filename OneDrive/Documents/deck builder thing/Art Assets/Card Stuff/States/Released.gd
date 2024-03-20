extends CardStates

var played: bool

func enter() -> void:
	card_combat_ui.update_state_text("Released")

	played = false
	
	if not card_combat_ui.targets.is_empty():
		played = true
		print("play card for target(s)", card_combat_ui.targets)


func on_input(_event: InputEvent) -> void:
	if played:
		return

	transition_requested.emit(self, CardStates.State.BASE)
