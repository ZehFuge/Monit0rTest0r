extends Node2D

var AudioPanLeft : int = -50
var AudioPanRight : int = 1350
var AudioY : int = 180

var ExplanationActive = false
onready var Explanation = load("res://MonitorTestErklärung.tscn")

var BrightnessBoundary = 0.6 # if below, text will be displayed as white

var ShuffleMode = 0 # 0 = shuffle off
var DefaultShuffleArray = [Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255)]
var ColorShuffleArray = [] # saves color presets
var ShuffleIterator = 0 # used to shuffle through ColorShuffleArray
var ShuffleTimer = "done" # done & running

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"MonitorTestErklärung".visible = true # always show tutorial at first

func _physics_process(delta):
	input_checker()
	if ShuffleMode > 0:
		shuffle_handler()

# handle input
func input_checker():
	# Color Picker block
	if Input.is_action_just_pressed("close_picker") and $ColorPicker.visible:
		$ColorPicker.visible = false
	if Input.is_action_just_pressed("open_picker") and not $ColorPicker.visible:
		$ColorPicker.visible = true
		
	# Audio block
	if Input.is_action_just_pressed("audio_test_left"):
		$AudioStreamPlayer2D.global_position = Vector2(AudioPanLeft, AudioY)
		$AudioStreamPlayer2D.play()
	if Input.is_action_just_pressed("audio_test_right"):
		$AudioStreamPlayer2D.global_position = Vector2(AudioPanRight, AudioY)
		$AudioStreamPlayer2D.play()
		
	# Tutorial handler
	if Input.is_action_just_pressed("info"):
		if $"MonitorTestErklärung".visible:
			$"MonitorTestErklärung".visible = false
		else:
			$"MonitorTestErklärung".visible = true
	
	# Color shuffle stuff block
	# Handling in the process func
	if Input.is_action_just_pressed("shuffle_off"):
		ShuffleMode = 0
	if Input.is_action_just_pressed("shuffle1"):
		ShuffleMode = 1
		ShuffleIterator = 0
	if Input.is_action_just_pressed("shuffle2"):
		ShuffleMode = 2
		ShuffleIterator = 0
		
	# Exit programm
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
func _on_ColorPicker_color_changed(color):
	if ShuffleMode == 0:
		$ColorRect.color = color
	edit_label_color(color)

func edit_label_color(color):
	if color[0] <= BrightnessBoundary:
		if color[1] <= BrightnessBoundary:
			if color[2] <= BrightnessBoundary:
				$"MonitorTestErklärung/Label".modulate = "#ffffff"
	else:
		$"MonitorTestErklärung/Label".modulate = "#000000"


func _on_ColorPicker_preset_added(color):
	ColorShuffleArray.append(color)


func _on_ColorPicker_preset_removed(color):
	ColorShuffleArray.erase(color)
	
func shuffle_handler():
	if ShuffleMode == 1:
		if $ShuffleTimer.time_left == 0:
			$ColorRect.color = DefaultShuffleArray[ShuffleIterator]
			edit_label_color(DefaultShuffleArray[ShuffleIterator])
			ShuffleTimer = "running"
			$ShuffleTimer.start()
			ShuffleIterator += 1
			
			if ShuffleIterator >= DefaultShuffleArray.size():
				ShuffleIterator = 0
					
	if ShuffleMode == 2:
			if $ShuffleTimer.time_left == 0 and ColorShuffleArray.size() > 0:
				$ColorRect.color = ColorShuffleArray[ShuffleIterator]
				edit_label_color(ColorShuffleArray[ShuffleIterator])
				$ShuffleTimer.start()
				ShuffleIterator += 1
			
				if ShuffleIterator >= ColorShuffleArray.size():
					ShuffleIterator = 0
					

func _on_ShuffleTimer_timeout():
	ShuffleTimer = "done"
