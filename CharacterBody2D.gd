extends CharacterBody2D

@export var base_speed: int
var speed = base_speed

@export var unit: Unit

@onready var nav = $NavigationAgent2D

var deploy_location:String = ''
var start_time:float


func _ready():
	$Label.text = str(unit.id)
	unit.drive_to_location.connect(deploy)


func _process(delta):
	
	var direction = Vector3()
	
	direction = nav.get_next_path_position() - self.global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, 7 * delta)
	move_and_slide()


func _on_navigation_agent_2d_navigation_finished():
	print('reached')
	speed = 0
	unit.on_duty = false
	unit.calculate_score(deploy_location, Time.get_ticks_msec() - start_time)


func get_random_location(locations):
	speed = base_speed
	nav.target_position = locations.pick_random().global_position


func deploy(new_position):
	speed = base_speed
	start_time = Time.get_ticks_msec()
	deploy_location = new_position
	print(GameManager.get_locations()[new_position])
	nav.target_position = GameManager.get_locations()[new_position].global_position

