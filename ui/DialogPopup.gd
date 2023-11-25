extends Popup

var npc_name : set = npc_name_set
var message: set = message_set
var response: set = response_set
@onready var animations = $"../AnimationPlayer"

var npc

func _ready():
	set_process_input(false)

func npc_name_set(new_value):
	npc_name = new_value
	$Dialog/NPC.text = new_value

	#sets the message with the value received from NPC
func message_set(new_value):
	message = new_value
	$Dialog/Message.text = new_value

	#sets the response with the value received from NPC
func response_set(new_value):
	response = new_value
	$Dialog/Response.text = new_value

func open():
	get_tree().paused = true
	self.visible = true
	animations.play("typewriter")

	#closes the dialog  
func close():
	get_tree().paused = false
	self.visible = false
