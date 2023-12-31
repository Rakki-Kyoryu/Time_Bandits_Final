extends Node2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = $Sprite2D

const lines: Array[String] = [
	"Hey there!",
	"Up here is the boss rush path",
	"Please note this is very difficult and is questionably possible",
	"(Section Designer: Nathaniel)",
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
