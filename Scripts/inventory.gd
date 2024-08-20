extends Control

@onready var _animator:AnimatedSprite2D = $AnimatedSprite2D

var close_time:float = 1000000
var open_time:float = 1000000

@onready var _scroll_container:ScrollContainer = $ScrollContainer
@onready var _open_audio = $OpenAudio
@onready var _close_audio = $CloseAudio


# Called when the node enters the scene tree for the first time.
func _ready():
	open()

func _process(delta):
	if close_time < 10000:
		close_time -= delta
	if close_time < 0:
		close_time = 1000000
		get_parent().remove_child(self)
		
		
	if open_time < 10000:
		open_time -= delta
	if open_time < 0:
		open_time = 1000000
		if close_time > 10000:
			_scroll_container.visible = true;

func open():
	_scroll_container.visible = false;
	_animator.play("open");
	open_time = 1
	_open_audio.play(0)

func close():
	_close_audio.play(0)
	_animator.play("close");
	close_time = .66
	_scroll_container.visible = false
