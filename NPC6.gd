extends Node2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = $Sprite2D

const lines: Array[String] = [
	"Hey there!",
	"The top and bottom both lead to gameplay selection options",
	"The right leads to a gallery to see some art",
	"The bottom and top are NOT returnable without exiting the game",
	"The gallery allows you to come and go as you please",
	"Also time traveling is difficult,", 
	"so make sure to throw timelines in dissaray by defeating anyone you come across",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished


