extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int
var correct: int
var score: int

@onready var question_label = $Control/QuestionHolder/QuestionLabel
@onready var question_image = $Control/QuestionHolder/Panel/QuestionImage
@onready var score_text = $Control/GameOver/Score

func _ready():	
	for button in $Control/ButtonHolder.get_children():
		buttons.append(button)
		
	array_randomize(quiz.theme)
		
	quiz_load()

func quiz_load():		
	if(index >= quiz.theme.size()):
		print("No more questions")
		game_over()
		return
		
	array_randomize(quiz.theme[index].question_amount)
	
	question_label.text = quiz.theme[index].question_info
	question_image.texture = quiz.theme[index].question_image
	
	for i in buttons.size():
		buttons[i].text = quiz.theme[index].question_amount[i]
		buttons[i].pressed.connect(question_validation.bind(buttons[i]))
		

func question_validation(button):
	if(button.text == quiz.theme[index].question_correct):
		button.modulate = color_right
		$Control/CorrectAudio.play()
		score += 1
	else:
		button.modulate = color_wrong
		$Control/IncorrectAudio.play()
	next_button()
	
func next_button():
	for bt in buttons:
		bt.pressed.disconnect(question_validation)
		
	await get_tree().create_timer(1).timeout
	
	for bt in buttons:
		bt.modulate = Color.WHITE
	
	index += 1
	quiz_load()
	
func game_over():
	$Control/GameOver.show()
	score_text.text = str(score, "/", quiz.theme.size())

func _on_button_pressed():
	get_tree().reload_current_scene()
	
func array_randomize(array: Array):
	var array_temp
	array_temp = array
	array_temp.shuffle()
	return array_temp
	
