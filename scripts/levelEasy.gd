extends Game

func setup():
	GameManager.reset_game_state()
	total_pairs = 8
	total_suits = 2
	level_time = 180
	min_click = total_pairs*2
	cards_per_row = 8
	get_node("/root/GameManager").level_time = level_time
	setup_cards()
	$Menu.connect("pressed", self._on_menu_pressed)

func _on_menu_pressed():
	GameManager.register_click() 
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
