extends CardStates

const DRAG_MINIMUM_THRESHOLD := 0.05

var minumum_drag_time_elapsed := false

#Search for the Combat_UI node via finding the UI layer group
#If the node exists, change the card node's parent from Hand to Combat_UI
func enter() -> void:
	var ui := get_tree().get_first_node_in_group("UI")
	if ui:
		card_combat_ui.reparent(ui)

	card_combat_ui.update_state_text("Dragging")
	
	minumum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minumum_drag_time_elapsed = true)
#Detect if the mouse is moving around, move card around following mouse
#Revert card back to the base state in Hand if RMB is clicked
#If LMB is released or clicked again while in the proper area, play the card and delete it
func on_input(event:InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("RightMouse")
	var confirm = event.is_action_released("LeftMouse") or event.is_action_pressed("LeftMouse")
	
	if mouse_motion:
		card_combat_ui.global_position = card_combat_ui.get_global_mouse_position() - card_combat_ui.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardStates.State.BASE)
		
	elif minumum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardStates.State.RELEASE)

