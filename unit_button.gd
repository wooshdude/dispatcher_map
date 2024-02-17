extends CheckBox
class_name UnitButton

var unit: Unit


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "#%s" % unit.id
	button_group = load("res://unit_button_group.tres")
	scale = Vector2(2,2)
	#unit.duty_start.connect(_on_duty_start)


func _toggled(button_pressed):
	if toggled:
		if not unit.on_duty:
			GameManager.selected_unit = unit
		else:
			GameManager.selected_unit = null


func _process(delta):
	if unit.on_duty:
		text = "#%s [On Duty]" % unit.id
		disabled = true
	else:
		text = "#%s" % unit.id
		disabled = false


func _on_duty_start():
	button_pressed = false
	print('starting duty timer')
	await get_tree().create_timer(10).timeout
	unit.on_duty = false
