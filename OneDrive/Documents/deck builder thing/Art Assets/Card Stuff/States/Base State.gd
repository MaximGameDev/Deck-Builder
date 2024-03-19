extends CardStates

#Child nodes load first, to prevent glitches, tell this node to wait to take action until its parent node has loaded
func enter() -> void:
	if not card_combat_ui.is_node_ready():
		await card_combat_ui.ready

	card_combat_ui.reparent_requested.emit(card_combat_ui)
	card_combat_ui.update_state_text("Base")
	card_combat_ui.pivot_offset = Vector2.ZERO


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftMouse"):
		card_combat_ui.pivot_offset = card_combat_ui.get_global_mouse_position() - card_combat_ui.global_position
		transition_requested.emit(self, CardStates.State.CLICKED)
