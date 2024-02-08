extends CardStates

var played: bool

func enter() -> void:
	card_combat_ui.color.color = Color.DARK_BLUE
	card_combat_ui.state.text = "RELEASED"

	played = false
	
	if not card_combat_ui.targets.is_empty():
		played = true
		print("play card for target(s)", card_combat_ui.targets)


func on_input(_event: InputEvent) -> void:
	if played:
		return

	transition_requested.emit(self, CardStates.State.BASE)
