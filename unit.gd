extends Resource
class_name Unit

@export_enum("Police", "EMS", "Fire", "Animal Control") var type: String
@export var id: int = 0
@export var on_duty: bool :
	set(value):
		if value == true:
			emit_signal("duty_start")
		on_duty = value

@export var case:String = ''

signal duty_start()
signal drive_to_location(location)


func deploy(location):
	print('starting new route to %s' % location)
	emit_signal("drive_to_location", location)


func calculate_score(location, time_taken):
	print(case)
	var current_case = GameManager.cases[case]
	GameManager.completed_cases += 1

	# correct location = 100
	if location == current_case.location:
		GameManager.score += 100
		
		# bonus points location
		if location == "bonus location":
			GameManager.score += 100
		
	# correct case = 10
	GameManager.score += 10
	
	# time 5 minutes - time taken min 0 max 5
	var minutes_taken = time_taken/1000
	var final_time = clamp(10 - minutes_taken,0,10)
	GameManager.score += final_time
	
