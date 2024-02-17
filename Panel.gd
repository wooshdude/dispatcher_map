extends Panel

var number: int
var location = [0, 0]

func _ready():
	$Label.text = "Vehicle " + str(number)
	$Label2.text = str(location)
