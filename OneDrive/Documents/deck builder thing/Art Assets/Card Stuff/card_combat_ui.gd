class_name CombatCardUI
extends Control

#Used to change parent node when card is being dragged
#Otherwise it will be stuck in Hand area
signal reparent_requested(which_card_ui: CombatCardUI)
@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var drop_detect: Area2D = $"Drop Detect"
@onready var state_machine: StateMachine = $StateMachine as StateMachine
@onready var targets: Array[Node] = []

#Hooked up the state machine for the cards to the UI
func _ready() -> void:
	print("READY")
	state_machine.init(self)

# Method to change the card's color.
func change_card_color(new_color: Color) -> void:
	self.color.color = new_color

# Method to update the state text on the card
func update_state_text(new_text: String) -> void:
	state.text = new_text  # Assuming 'state' is the Label node where the text is displayed.

func _input(event: InputEvent) -> void:
	state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		change_card_color(Color(0, 0, 1, 1))  # Example: Change to blue on mouse click.
	state_machine._on_gui_input(event)

func _on_mouse_entered() -> void:
	change_card_color(Color(1, 0.5, 0, 1))  # Example: Change to orange on mouse enter.
	update_state_text("Hover")
	state_machine._on_mouse_entered()

func _on_mouse_exited() -> void:
	change_card_color(Color(0, 0, 0, 1))  # Example: Change back to white on mouse exit.
	update_state_text("Base")  # Or revert to another appropriate state text
	state_machine._on_mouse_exited()


func _on_drop_detect_area_entered(area):
	if not targets.has(area):
		targets.append(area)


func _on_drop_detect_area_exited(area):
	print("ODDAE")
	targets.erase(area)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.canceled:
			print("Left button was released at ", event.position)
			color.color = Color.WEB_MAROON



func _on_card_combat_ui_reparent_requested(_which_card_ui: CombatCardUI):
	pass # Replace with function body.
