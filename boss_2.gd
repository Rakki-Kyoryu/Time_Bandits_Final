extends CharacterBody2D

class_name Boss2

@onready var animation_sprite = $AnimatedSprite2D
var speed = 125
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
	print(player)
	if player_chase:
		position += (player.position - position)/speed
		
		
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
	
	if Global.boss_health_pool >= 500:
		healthbar.visible = false
	else:
		healthbar.visible = true
	$healthbar.value = Global.boss_health_pool

func _on_detection_area_body_entered(body):
	if body.has_method("player_check"):
		player = body
		player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func _on_hurtbox_area_entered(area):
	if area == $hitbox: return
	Global.boss_health_pool = Global.boss_health_pool - 10
	if Global.boss_health_pool <=0:
		isDead = true
		queue_free()

