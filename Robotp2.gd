extends CharacterBody2D

class_name Robotp2

@onready var animation_sprite = $AnimatedSprite2D
var speed = 75
var player_chase = false
var player = null

var health = 500
var player_in_attack_zone = false
var can_take_damage = true
var is_attacking = false
var isDead: bool = false
var bow_cooldown = true
var cease = false
var arrow = preload("res://arrow.tscn")
var count = 0
var stall = false
var special_count = 0
func _physics_process(delta):
	if isDead: return
	update_health()
	if player_chase && cease == false:
		position += (player.position - position)/speed
		
		$Marker2D.look_at(player.position)
		if bow_cooldown == true:
			
			var arrow_instance = arrow.instantiate()
			arrow_instance.rotation = $Marker2D.rotation
			arrow_instance.global_position = $Marker2D.global_position
			bow_cooldown = false
			add_child(arrow_instance)
			
			if health >= 250:
				await get_tree().create_timer(1.25).timeout
				bow_cooldown = true
			elif health < 250:
				await get_tree().create_timer(0.75).timeout
				bow_cooldown = true
			
		
		
		if health == 400 || health == 300 || health == 200 || health == 100:
			special_count = 1
		if count < 1 && special_count == 1:
			speed = 20
			stall = true
			$AnimatedSprite2D.play("armor")
			await get_tree().create_timer(10.0).timeout
			stall = false
			count = count +1
			speed = 75
		elif count > 0:
			cease = true
			await get_tree().create_timer(1.0).timeout
			cease = false
			count = 0
			special_count = 0
		$AnimatedSprite2D.play("walk")
		
	else:
		$AnimatedSprite2D.play("idle")
	
func enemy():
	pass

func update_health():
	var healthbar = $healthbar
	
	if health >= 500:
		healthbar.visible = false
	else:
		healthbar.visible = true
	$healthbar.value = health

func _on_detection_area_body_entered(body):
	if body.has_method("player_check"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func _on_hurtbox_area_entered(area):
	if area == $hitbox: return
	if stall == false:
		health = health - 25
		if health <=0:
			isDead = true
			Global.is_boss_defeated_china = true
			$AnimatedSprite2D.play("death")
			await $AnimatedSprite2D.animation_finished
			queue_free()

