extends Control

@onready var label = $Label
@onready var option_button = $VBoxContainer/OptionButton
@onready var back_button = $BackButton
@onready var send_button = $SendButton
@onready var line_edit = $HBoxContainer/LineEdit
@onready var panel = $Panel

@onready var tab_container = $".."


func _ready():
	for key in GameManager.get_locations().keys():
		option_button.add_item(key)
	GameManager.selected_location = option_button.get_item_text(0)


func _on_visibility_changed():
	panel.hide()
	if visible:
		label.text = "%s #%s" % [GameManager.selected_unit.type, GameManager.selected_unit.id]


func _on_back_button_pressed():
	tab_container.current_tab = 0


func _on_send_button_pressed():
	panel.show()


func _on_option_button_item_selected(index):
	print(option_button.get_item_text(index))
	GameManager.selected_location = option_button.get_item_text(index)


func _on_confirm_pressed():
	if line_edit.text == '': return
	print(GameManager.cases.keys())
	if not line_edit.text in str(GameManager.cases.keys()): return
	GameManager.selected_unit.on_duty = true
	GameManager.selected_unit.deploy(GameManager.selected_location)
	GameManager.selected_unit.case = line_edit.text
	GameManager.selected_unit = null
	tab_container.current_tab = 2
	await get_tree().create_timer(3).timeout
	tab_container.current_tab = 0
