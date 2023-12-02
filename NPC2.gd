extends Node2D

@onready var interaction_area: InteractionArea = $interaction_area
@onready var sprite = $Sprite2D

const lines: Array[String] = [
	"Hey there!",
	"Did you know that the hole in the apple didn't come from the outside in?",
	"It was eaten from the core and out to the skin, and that's why youll never find the worm in it",
	"But a few bad ones won't spoil the eyes if they fall far enough from the tree",
	"The rind is all you see, leave Eden with my...",
	"seeds in your stomach",
	"Outliers and Hypocrites, A fun fact about apples! - Will Wood"
]

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished

