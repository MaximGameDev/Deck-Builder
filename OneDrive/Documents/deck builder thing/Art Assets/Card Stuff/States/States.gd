class_name CardStates
extends Node

#Stores the five states that cards are able to be in
enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASE}

#Allow for node state to transition from the CardStates script to one of the 5 states
signal transition_requested(from: CardStates, to: State)

#State variable can be exported to assign states to cards
@export var state: State

#Allows for altering of cards through this script
var card_combat_ui: CombatCardUI

func enterstate() -> void:
	pass
	
func exitstate() -> void:
	pass
	
func on_input(_event: InputEvent) -> void:
	pass
	
func _on_gui_input(_event: InputEvent) -> void:
	pass
	
func _on_mouse_entered() -> void:
	pass
	
func _on_mouse_exited() -> void:
	pass
