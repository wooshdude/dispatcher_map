extends Control

@onready var tab_container = $".."



func _on_button_pressed():
	if not GameManager.selected_unit: return
	if not GameManager.selected_unit.on_duty:
		tab_container.current_tab = 1
