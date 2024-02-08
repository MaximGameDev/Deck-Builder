class_name  StateMachine
extends Node

@export var default_state: CardStates

var current_state: CardStates
var states := {}

#Search state library, check states of cards and transition their states accordingly
func init(card: CombatCardUI) -> void:
	for child in get_children():
		if child is CardStates:
			states[child.state] = child
			child.transition_requested.connect(transition_requested)
			child.card_combat_ui = card
	#If there is a default state, enter the state immediately when card is not currently in another state
	if default_state:
		default_state.enterstate()
		current_state =  default_state

#Check if there is a current state
#If there is, use that state function accordingly
func on_input(event: InputEvent) -> void:
	if default_state:
		default_state.on_input(event)


func _on_gui_input(event: InputEvent) -> void:
	if default_state:
		default_state._on_gui_input(event)

#Same as above but with mouse location instead of button inputs
func _on_mouse_entered() -> void:
	if default_state:
		default_state._on_mouse_entered()


func _on_mouse_exited() -> void:
	if default_state:
		default_state._on_mouse_exited()

#When a state transition is requested, check the current default state
#If default state is not a state currently stored in CardStates, something is very wrong, continue function this is not the case
#Create a new state and set it to the state being transitioned to from CardStates
#Then, leave the current default state
#Finally, set the new state as the default state
func transition_requested(from: CardStates, to: CardStates.State) -> void:
	if from != default_state:
		return
	var new_state: CardStates = states[to]
	if not new_state:
		return	
	if default_state:
		default_state.exitstate()
		new_state.enterstate()
		default_state = new_state
