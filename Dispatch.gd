extends Control

@onready var cases = preload("res://Cases - Role(2).csv").records

func _ready():
	print(cases)
