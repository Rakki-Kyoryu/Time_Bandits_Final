extends CharacterBody2D

class_name Player

const speed = 200

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
@export var max_health = 500
@onready var current_health = 500
var player_alive = true
var health_changed = false
@onready var animations = $AnimationPlayer
var last_pressed = "Down"
var lastAnimDirection: String = "Down"
var isAttacking: bool = false
@export var inventory: Inventory

var health_fix_1 = true

func _ready():
	pass

func _physics_process(delta):
	Global.player_health = current_health
	enemy_attacks()
	handle_input()
	move_and_slide()
	update_animations()
	current_camera()
	
	if Global.current_scene == "jade" && health_fix_1 == true:
		current_health = 500
		health_fix_1 = false
	
	if current_health <= 0:
		player_alive = false
		current_health = 0
		self.queue_free()

func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * speed
	
	if Input.is_action_just_pressed("attack"):
		attack()
		
func attack():
	print(Global.current_scene)
	animations.play("attack" + lastAnimDirection)
	isAttacking = true
	await animations.animation_finished
	isAttacking = false

func update_animations():
	if isAttacking: return
	
	if velocity.length() == 0:
		animations.play("idle" + last_pressed)
	else:
		var direction = "Down"
		last_pressed = "Down"
		if velocity.x < 0: 
			direction = "Left"
			last_pressed = "Left"
		elif velocity.x > 0: 
			direction = "Right"
			last_pressed = "Right"
		elif velocity.y < 0: 
			direction = "Up"
			last_pressed = "Up"
		
		animations.play("walk" + direction)
		lastAnimDirection = direction
	

	

func player_check():
	pass
		
func enemy_attacks():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		current_health = current_health - 20
		Global.player_health = current_health
		health_changed = true
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(current_health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func current_camera():
	if Global.current_scene == "field":
		$field_camera.enabled = true
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "lab":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = true
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "hub":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = true
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "cliff_side":
		$field_camera.enabled = false
		$cliffside_camera.enabled = true
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "plato":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = true
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "plato_boss":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = true
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "jade":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = true
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "statue_boss":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = true
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "gallery":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = true
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "material":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = true
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "nuke_boss":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = true
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "village":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = true
		$warehouse_camera.enabled = false
		$china_camera.enabled = false
	elif Global.current_scene == "warehouse":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = true
		$china_camera.enabled = false
	elif Global.current_scene == "china":
		$field_camera.enabled = false
		$cliffside_camera.enabled = false
		$plato_camera.enabled = false
		$plato_boss_camera.enabled = false
		$jade_camera.enabled = false
		$statue_boss_camera.enabled = false
		$lab_camera.enabled = false
		$hub.enabled = false
		$gallery_camera.enabled = false
		$material_camera.enabled = false
		$nuke_camera.enabled = false
		$village_camera.enabled = false
		$warehouse_camera.enabled = false
		$china_camera.enabled = true
		
func _on_player_hitbox_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
	
		

func _on_sword_hit_area_entered(area):
	if area.is_in_group("hurtbox"):
		print("hit")
		Global.player_current_attack = true


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func _on_hurtbox_area_entered(area):
	if area == $hitbox: return
	current_health = current_health - 20
	Global.player_health = current_health
	health_changed = true
	print(current_health)
	if current_health <=0:
		$AnimationPlayer.play("death")
		await $AnimationPlayer.animation_finished
		queue_free()
