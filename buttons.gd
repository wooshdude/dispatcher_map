extends Node2D
@onready var dispatch_menu = $DispatchMenu
@onready var http_request = $HTTPRequest
@onready var timer = $Timer
var server = 'http://192.168.0.103:8000/get-units'
var data

@onready var base_panel = $Panel
@onready var police_info = $GridContainer/VBoxContainer/GridContainer
@onready var fire_dept_info = $GridContainer/VBoxContainer2/GridContainer

var selected_location = [0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	dispatch_menu.hide()
	http_request.request(server)
	var json = JSON.new()
	http_request.request(server, ["Content-Type: application/json"], HTTPClient.METHOD_POST, json.stringify({"hello": "world"}))
	$DispatchMenu/MenuButton.get_popup().connect("id_pressed", location_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if data and police_info.get_child_count() < 4:
		for i in range(len(get_parent().vehicles)):
			var new_police_info = base_panel.duplicate()
			new_police_info.number = 100
			new_police_info.location = str(int(get_parent().vehicles[i].global_position.x))+","+str(int(get_parent().vehicles[i].global_position.y))
			police_info.add_child(new_police_info)


func dispatch(vehicle, case, location):
	print(data["units"])
	for i in data["units"]:
		for j in data["units"][i]:
			print(j)
			#print(location)
			if j["number"] == vehicle:
				print('yeah')


func _on_button_pressed():
	selected_location = location_selected(1)
	dispatch_menu.visible = not dispatch_menu.visible
	$DispatchMenu/MenuButton.text = 'Address'
	$DispatchMenu/MenuButton.get_popup().clear()
	for i in get_parent().locations:
		$DispatchMenu/MenuButton.get_popup().add_radio_check_item(str(i))

func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	data = json.parse_string(body.get_string_from_utf8())
	#print(data)
	#dispatch(1,0,[28,80])
	return json.parse_string(body.get_string_from_utf8())


func _on_timer_timeout():
	http_request.request(server)
	timer.start()


func location_selected(id):
	selected_location = $DispatchMenu/MenuButton.get_popup().get_item_text(id)
	$DispatchMenu/MenuButton.text = selected_location


func _on_send_button_pressed():
	http_request.request(server, ["Content-Type: application/json"], HTTPClient.METHOD_POST, JSON.stringify({"hello": "world"}))
	dispatch($DispatchMenu/LineEdit3.value, $DispatchMenu/LineEdit2.value, selected_location)
