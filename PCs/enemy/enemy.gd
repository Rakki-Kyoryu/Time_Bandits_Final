extends CharacterBody2D

class_name Enemy

var speed = 75
var player_chase = false
var player = null

var health = 50
var player_in_attack_zone = false
var can_take_damage = true

var isDead: bool = false

func _physics_process(delta):
	if isDead: return
	update_health()
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

func _on_hurtbox_area_entered(area):
	if area == $hitbox: return
	health = health - 20
	if health <=0:
		isDead = true
		$AnimatedSprite2D.play("death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
