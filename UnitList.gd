extends Control

@export_enum("Police", "EMS", "Fire", "Animal Control") var unit_type: String = "Police"

@onready var label = $Label
@onready var unit_list: VBoxContainer = $VBoxContainer
@onready var vehicles = $"../../../Map/Vehicles"
@onready var vehicle = preload("res://vehicle.tscn")

var buttons:Array[Button] = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if unit_list.get_child_count() < GameManager.get_units()[unit_type.to_lower()]:
		for i in range(GameManager.get_units()[unit_type.to_lower()] - unit_list.get_child_count()):
			var new_button: UnitButton = UnitButton.new()
			var new_unit: Unit = Unit.new()
			new_unit.type = unit_type
			new_unit.id = unit_list.get_child_count()
			new_button.unit = new_unit
			unit_list.add_child(new_button)
			
			var new_vehicle = vehicle.instantiate()
			new_vehicle.unit = new_unit
			vehicles.add_child(new_vehicle)
