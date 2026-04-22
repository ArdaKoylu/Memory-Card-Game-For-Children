extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var time_label = $TimeLabel
@onready var click_label = $ClickLabel
@onready var game_timer = $GameTimer 

var time_left: int = 180  
var total_pairs = 2

func update_score(score: int):
	if score_label:
		score_label.text = "Score: %d" % score

func update_time(time_left: int):
	if time_label:
		time_label.text = "Time: %d" % time_left

func update_clicks(clicks: int):
	if click_label:
		click_label.text = "Clicks: %d" % clicks

func _on_game_timer_timeout() -> void:
	time_left -= 1
	update_time(time_left)

	if time_left <= 0 or GameManager.level_is_finished():
		game_timer.stop()

func start_timer(seconds: int):
	time_left = seconds
	update_time(time_left)
	game_timer.start()

func stop_timer():
	game_timer.stop()



func get_time_left() -> int:
	return time_left

@onready var level_popup = $LevelCompletePopup
@onready var final_score_label = $LevelCompletePopup/FinalScore

func show_level_complete_popup(final_score: int):
	if level_popup and final_score_label:
		final_score_label.text = "Final Score: %d" % final_score
		level_popup.visible = true
