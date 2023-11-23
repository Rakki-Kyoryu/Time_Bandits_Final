extends CharacterBody2D

class_name Lizard

var speed = 75
var player_chase = false
var player = null

var health = 50
var player_in_attack_zone = false
var can_take_damage = true


func _physics_process(delta):
	
	update_health()
	deal_with_damage()
	if player_chase:
		position += (player.position - position)/speed
		
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else: 
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	
func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	print("entered")
	if body.has_method("player_check"):
		player_in_attack_zone = true


func _on_enemy_hitbox_body_exited(body):
	print("exited")
	if body.has_method("player_check"):
		player_in_attack_zone = false
		
func deal_with_damage():
	if player_in_attack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print(health)
			if health <=0:
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func update_health():
	var healthbar = $healthbar
	
	if health >= 50:
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
