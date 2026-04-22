extends Node

var min_click 
var level_time
var click_count = 0
var total_click_count
var game_started = false
var card1
var card2
var score = 0
var final_score
var found_pair_count = 0
var total_pairs = 0
var matchTimer := Timer.new()
var flipTimer := Timer.new()
var game_timer := Timer.new()
var final_score_applied := false

var CardBack = preload("res://assets/Assets 140x190 px/newbackground.png")
var MatchedCardReplacementTexture = preload("res://assets/replacement.png")

func _ready() -> void:
	reset_game_state()
	setup_timers()


	await get_tree().process_frame

	var game_scene = get_tree().current_scene
	if game_scene is Game:
		level_time = game_scene.level_time
		min_click = game_scene.min_click
		total_pairs = game_scene.total_pairs

		game_timer.wait_time = level_time
		game_timer.one_shot = true
		add_child(game_timer)
	else:
		push_error("Game scene is not of type 'Game'.")

 
func setup_timers() -> void:
	flipTimer.timeout.connect(turn_over_cards)
	flipTimer.one_shot = true
	add_child(flipTimer)

	matchTimer.timeout.connect(match_cards)
	matchTimer.one_shot = true
	add_child(matchTimer)


func register_click():
	click_count += 1
	var hud = get_node("/root/Game/HUD")
	if hud:
		hud.update_clicks(click_count)
		if not game_started:
			game_started = true
			hud.start_timer(level_time)


func chooseCard(c: Card) -> void:
	if card1 == null:
		card1 = c
		card1.flip()
		card1.disabled = true
	elif card2 == null:
		card2 = c
		card2.flip()
		card2.disabled = true
		check_cards()

func check_cards() -> void:
	if card1.value == card2.value:
		matchTimer.start(1)
	else:
		flipTimer.start(1)

func turn_over_cards() -> void:
	card1.flip()
	card2.flip()
	card1.disabled = false
	card2.disabled = false
	card1 = null
	card2 = null

func match_cards() -> void:
	if has_node("/root/Game/MatchSound"):
		get_node("/root/Game/MatchSound").play()

	card1.texture_normal = MatchedCardReplacementTexture
	card2.texture_normal = MatchedCardReplacementTexture

	card1 = null
	card2 = null

	found_pair_count += 1
	update_score()
	print("Found a pair!")
	
	var hud = get_node("/root/Game/HUD")
	var game_scene = get_tree().current_scene
	if game_scene is Game:
		if level_is_finished():
			print("Found all pairs!")
			hud.show_level_complete_popup(score)



func level_is_finished() -> bool:
	var game_scene = get_tree().current_scene
	if game_scene is Game:
		return found_pair_count == game_scene.total_pairs
	return false
	click_count = 0
	Hud.time_left = level_time
	




func get_click_multiplier() -> float:
	var game_scene = get_tree().current_scene
	min_click = game_scene.min_click
	if click_count <= min_click * 2:
		return 2.5
	elif click_count <= min_click * 3:
		return 2.0
	elif click_count <= min_click * 4:
		return 1.75
	elif click_count <= min_click * 5:
		return 1.5
	elif click_count <= min_click * 6:
		return 1.25
	elif click_count <= min_click * 7:
		return 1.1  
	return 1

func get_time_multiplier() -> float:
	var game_scene = get_tree().current_scene
	var hud = get_node("/root/Game/HUD")
	level_time = game_scene.level_time
	
		
	if hud.get_time_left() <= (level_time * 0.25):
		return 1.25
	elif hud.get_time_left() <= (level_time * 0.5):
		return 1.5
	elif hud.get_time_left() <= (level_time * 0.75):
		return 1.75
	elif hud.get_time_left() < (level_time):
		return 2
	return 0


func update_score() -> void:
	score += 200

	var hud = get_node("/root/Game/HUD")
	if hud:
		hud.update_score(score)

	if level_is_finished() and not final_score_applied:
		final_score_applied = true
		var time_remaining = 0
		if hud:
			time_remaining = hud.get_time_left()
		score *= get_click_multiplier() * get_time_multiplier()
		final_score = score
		if hud:
			get_node("/root/Game/GameOverSound").play()
			hud.show_level_complete_popup(final_score)

func reset_game_state():
	click_count = 0
	score = 0
	final_score = 0
	game_started = false
	card1 = null
	card2 = null
	found_pair_count = 0
	final_score_applied = false

	if has_node("/root/Game/HUD"):
		var hud = get_node("/root/Game/HUD")
