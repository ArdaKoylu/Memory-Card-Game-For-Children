extends TextureButton
class_name Card

var suit: int
var value: int
var face: Texture2D
var back: Texture2D
var replacement: Texture2D
var game: Node = null  

func set_card_data(s: int, v: int):
	suit = s
	value = v
	face = load("res://assets/Assets 140x190 px/animal-%d-%d.png" % [suit, value])
	back = GameManager.CardBack
	replacement = GameManager.MatchedCardReplacementTexture
	texture_normal = back

func set_game(g: Node) -> void:
	game = g

func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_filter = Control.MOUSE_FILTER_STOP

func _on_pressed() -> void:
	if game:
		GameManager.register_click()
	GameManager.chooseCard(self)

func swap_texture():
	if texture_normal == back:
		texture_normal = face
	else:
		texture_normal = back

func flip():
	$FlipSound.play(0.0)
	$AnimationPlayer.play("flip_card")
