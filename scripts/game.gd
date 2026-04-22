extends Control
class_name Game

var CardScene = preload("res://scenes/card.tscn")
@onready var grid = $Grid

var level_time := 180
var total_pairs := 24
var total_suits := 2
var cards = []
var min_click
var music_on := true
var original_music_volume_db: float

var cards_per_row

func _ready():
	print("READY: ", self.name)
	
	if has_node("BackgroundMusic"):
		var music = $BackgroundMusic
		music.volume_db = -5
		original_music_volume_db = music.volume_db 
		music.play()
		$ToggleMusicButton.text = "🔊 Music On" 
	
	setup()

func setup():
	cards_per_row = 6 
	setup_cards()

func setup_cards():
	cards.clear()
	grid.columns = cards_per_row
	for suit in range(1, total_suits + 1):
		for value in range(1, total_pairs + 1):
			var card = CardScene.instantiate()
			card.set_card_data(suit, value)
			card.set_game(self)
			cards.append(card)
	cards.shuffle()
	for card in cards:
		grid.add_child(card)

func get_total_pairs() -> int:
	return total_pairs


func _on_toggle_music_button_pressed() -> void:
	if has_node("BackgroundMusic"):
		var music = $BackgroundMusic
		
		music_on = !music_on 
		
		if music_on:
			music.volume_db = original_music_volume_db 
			$ToggleMusicButton.text = "🔊 Music On"
			if not music.playing: 
				music.play()
		else:
			music.volume_db = -80.0 
			$ToggleMusicButton.text = "🔇 Music Off"
