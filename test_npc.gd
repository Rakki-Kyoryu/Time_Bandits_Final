extends CharacterBody2D
@onready var player_scene = preload("res://PCs/Player/Player.tscn").instance()

@onready var dialog_popup = player_scene.get_node("DialogPopup")
@onready var player = player_scene
@onready var animation_sprite = $AnimatedSprite2D

#quest and dialog states
enum QuestStatus { NOT_STARTED, STARTED, COMPLETED }
var quest_status = QuestStatus.NOT_STARTED
var dialog_state = 0
var quest_complete = false

@export var npc_name = ""

func _ready():
	animation_sprite.play("idle_down")
	print (Global.current_scene)

func dialog(response = ""):
	# Set our NPC's animation to "talk"
	animation_sprite.play("talk_down")
	print (dialog_popup)
	# Set dialog_popup npc to be referencing this npc
	dialog_popup.npc = self
	dialog_popup.npc_name = str(npc_name)
	
	# dialog tree
	match quest_status:
		QuestStatus.NOT_STARTED:
			match dialog_state:
				0:
					# Update dialog tree state
					dialog_state = 1
					# Show dialog popup
					dialog_popup.message = "Hey partner, have a minute to spare?"
					dialog_popup.response = "[A] Yes  [B] No"
					dialog_popup.open() #re-open to show next dialog
				1:
					match response:
						"A":
							# Update dialog tree state
							dialog_state = 2
							# Show dialog popup
							dialog_popup.message = "Good, because I need your help finding my coffin key."
							dialog_popup.response = "[A] Bye"
							dialog_popup.open() #re-open to show next dialog
						"B":
							# Update dialog tree state
							dialog_state = 3
							# Show dialog popup
							dialog_popup.message = "Well, I didn't like your face anyway."
							dialog_popup.response = "[A] Bye"
							dialog_popup.open() #re-open to show next dialog
				2:
					# Update dialog tree state
					dialog_state = 0
					quest_status = QuestStatus.STARTED
					# Close dialog popup
					dialog_popup.close()
					# Set NPC's animation back to "idle"
					animation_sprite.play("idle_down")
				3:
					# Update dialog tree state
					dialog_state = 0
					# Close dialog popup
					dialog_popup.close()
					# Set NPC's animation back to "idle"
					animation_sprite.play("idle_down")
		QuestStatus.STARTED:
			match dialog_state:
				0:
					# Update dialog tree state
					dialog_state = 1
					# Show dialog popup
					dialog_popup.message = "Found that key yet?"
					if quest_complete:
						dialog_popup.response = "[A] Yes  [B] No"
					else:
						dialog_popup.response = "[A] No"
					dialog_popup.open()
				1:
					if quest_complete and response == "A":
						# Update dialog tree state
						dialog_state = 2
						# Show dialog popup
						dialog_popup.message = "Great. Thanks for the help friend."
						dialog_popup.response = "[A] Bye"
						dialog_popup.open()
					else:
						# Update dialog tree state
						dialog_state = 3
						# Show dialog popup
						dialog_popup.message = "I need that key, and I need it NOW!"
						dialog_popup.response = "[A] Bye"
						dialog_popup.open()
				2:
					# Update dialog tree state
					dialog_state = 0
					quest_status = QuestStatus.COMPLETED
					# Close dialog popup
					dialog_popup.close()
					# Set NPC's animation back to "idle"
					animation_sprite.play("idle_down")
					# Add potion and XP to the player. 
					player.add_pickup(Global.Pickups.AMMO)
					player.update_xp(50)
				3:
					# Update dialog tree state
					dialog_state = 0
					# Close dialog popup
					dialog_popup.close()
					# Set NPC's animation back to "idle"
					animation_sprite.play("idle_down")
		QuestStatus.COMPLETED:
			match dialog_state:
				0:
					# Update dialog tree state
					dialog_state = 1
					# Show dialog popup
					dialog_popup.message = "What you still roaming around here for?"
					dialog_popup.response = "[A] Bye"
					dialog_popup.open()
				1:
					# Update dialog tree state
					dialog_state = 0
					# Close dialog popup
					dialog_popup.close()
					# Set NPC's animation back to "idle"
					animation_sprite.play("idle_down")
