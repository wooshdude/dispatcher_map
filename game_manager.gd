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
		

var cases: Array[Case] = []
var locations = {}
var vehicles = {
	"police": [],
	"ems": [],
	"fire": [],
	"animal control": []
}


# Called when the node enters the scene tree for the first time.
func _ready():
	for c in cases_sheet:
		var new_case = Case.new()
		new_case.number = c[0]
		new_case.unit = c[1]
		new_case.location = c[2]
		new_case.description = c[3]
		cases.append(new_case)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	units_file = "res://units.json"
	units_string = FileAccess.get_file_as_string(units_file)
	data = JSON.parse_string(units_string)
	

func get_units():
	return data["units"]

func get_locations() -> Dictionary:
	return locations
