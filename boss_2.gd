extends CharacterBody2D

class_name Boss2

@onready var animation_sprite = $AnimatedSprite2D
var speed = 75
var player_chase = false
var player = null

var health = 100
var player_in_attack_zone = false
var can_take_damage = true
var is_attacking = false
var isDead: bool = false
var bow_cooldown = true
var arrow = preload("res://arrow.tscn")

func _physics_process(delta):
	if isDead: return
	update_health()
	if player_chase:
		position += (player.position - position)/speed
		
		$Marker2D.look_at(player.position)
		
		if bow_cooldown == true:
			
			var arrow_instance = arrow.instantiate()
			arrow_instance.rotation = $Marker2D.rotation
			arrow_instance.global_position = $Marker2D.global_position
			bow_cooldown = false
			add_child(arrow_instance)
			#var animation = "attack"
			#animation_sprite.play(animation)
			#await animation_sprite.animation_finished
			
			
			await get_tree().create_timer(0.001).timeout
			bow_cooldown = true
		$AnimatedSprite2D.play("walk")
		if(position.x) != null:
			if (player.position.x) != null:
				if(player.position.x - position.x) < 0:
					$AnimatedSprite2D.flip_h = false
				else: 
					$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")
	
func enemy():
	pass

func update_health():
	var healthbar = $healthbar
	
	if health >= 100:
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

