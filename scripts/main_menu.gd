extends Control

func _ready():
	$"CenterContainer/VBoxContainer/Easy Level".connect("pressed", self._on_easy_pressed)
	$"CenterContainer/VBoxContainer/Medium Level".connect("pressed", self._on_medium_pressed)
	$"CenterContainer/VBoxContainer/Hard Level".connect("pressed", self._on_hard_pressed)
	$CenterContainer/VBoxContainer/Quit.connect("pressed", self._on_quit_pressed)

func _on_easy_pressed():
	GameManager.register_click() 
	GameManager.reset_game_state()
	# BURASI DEĞİŞTİ: .gd yerine .tscn ve scripts yerine scenes klasörü
	get_tree().change_scene_to_file("res://scenes/levelEasy.tscn")

func _on_medium_pressed():
	GameManager.register_click()
	GameManager.reset_game_state()
	# BURASI DEĞİŞTİ
	get_tree().change_scene_to_file("res://scenes/levelMedium.tscn")

func _on_hard_pressed():
	GameManager.register_click() 
	GameManager.reset_game_state()
	# BURASI DEĞİŞTİ
	get_tree().change_scene_to_file("res://scenes/levelHard.tscn")

func _on_quit_pressed():
	GameManager.register_click()
	get_tree().quit()
