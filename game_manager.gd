extends Node

var units_file = "res://units.json"
var units_string = FileAccess.get_file_as_string(units_file)
var data = JSON.parse_string(units_string)

@onready var cases_sheet = preload("res://Cases - Role(2).csv").records


var selected_unit:Unit : 
	set(value):
		selected_unit = value
	get:
		return selected_unit

var selected_location:String


var cases: = {}
var locations = {}
var vehicles = {
	"police": [],
	"ems": [],
	"fire": [],
	"animal control": []
}

var completed_cases:int = 0
var score:int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	for c in cases_sheet:
		var new_case = Case.new()
		new_case.number = c[0]
		new_case.unit = c[1]
		new_case.location = c[2]
		new_case.description = c[3]
		cases[str(new_case.number)] = new_case
	print(cases)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	units_file = "res://units.json"
	units_string = FileAccess.get_file_as_string(units_file)
	data = JSON.parse_string(units_string)
	

func get_units():
	return data["units"]

func get_locations() -> Dictionary:
	return locations
