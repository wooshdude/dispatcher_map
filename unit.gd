extends Resource
class_name Unit

@export_enum("Police", "EMS", "Fire", "Animal Control") var type: String
@export var id: int = 0
@export var on_duty: bool :
	set(value):
		if value == true:
			print('balls')
			emit_signal("duty_start")
		on_duty = value

signal duty_start()

signal drive_to_location(location)

func deploy(location):
	print('starting new route to %s' % location)
	emit_signal("drive_to_location", location)
