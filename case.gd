extends Resource
class_name Case

@export var number:int = 0
@export_enum("Police", "Fire", "EMS") var unit: String = "Police"
@export var location: String
@export_multiline var description: String

var completed: bool
