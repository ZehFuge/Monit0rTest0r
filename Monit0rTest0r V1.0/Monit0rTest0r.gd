extends Node2D

var AudioPanLeft : int = -50
var AudioPanRight : int = 1350
var AudioY : int = 180

var ExplanationActive = false
onready var Explanation = load("res://MonitorTestErklärung.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"MonitorTestErklärung".visible = true

func _process(delta):
	input_checker()

# handle input
func input_checker():
	if Input.is_action_just_pressed("close_picker") and $ColorPicker.visible:
		$ColorPicker.visible = false
	if Input.is_action_just_pressed("open_picker") and not $ColorPicker.visible:
		$ColorPicker.visible = true
		
	if Input.is_action_just_pressed("audio_test_left"):
		$AudioStreamPlayer2D.global_position = Vector2(AudioPanLeft, AudioY)
		$AudioStreamPlayer2D.play()
	if Input.is_action_just_pressed("audio_test_right"):
		$AudioStreamPlayer2D.global_position = Vector2(AudioPanRight, AudioY)
		$AudioStreamPlayer2D.play()
		
	if Input.is_action_just_pressed("info"):
		if $"MonitorTestErklärung".visible:
			$"MonitorTestErklärung".visible = false
		else:
			$"MonitorTestErklärung".visible = true
		
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
func _on_ColorPicker_color_changed(color):
	$ColorRect.modulate = color
