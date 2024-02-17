extends Node2D

@onready var locations = $Locations.get_children()
@onready var vehicle = preload("res://vehicle.tscn")

var vehicles = []

signal deploy(num, new_position)

# Called when the node enters the scene tree for the first time.
func _ready():
	for location in locations:
		GameManager.locations[location.name] = location
	print(GameManager.get_locations())


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		#print('space bar')
		emit_signal("deploy", 1, locations.pick_random().global_position)
		pass


func _on_vehicles_child_entered_tree(node):
	node.global_position = locations.pick_random().global_position
