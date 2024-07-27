extends Node

@export var quiz: QuizTheme
@export var color_right: Color
@export var color_wrong: Color

var buttons: Array[Button]
var index: int
var correct: int

@onready var question_label = $Control/QuestionHolder/QuestionLabel
@onready var question_image = $Control/QuestionHolder/Panel/QuestionImage

func _ready():	
	for button in $Control/ButtonHolder.get_children():
		buttons.append(button)
		
	quiz_load()

func quiz_load():
	question_label.text = quiz.theme[index].question_info
	question_image.texture = quiz.theme[index].question_image

	for i in buttons.size():
		buttons[i].text = quiz.theme[index].question_amount[i]
