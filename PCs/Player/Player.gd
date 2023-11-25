extends CharacterBody2D

class_name Player

@export var speed = 200

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
@onready var ray_cast = $RayCast2D
var new_direction = Vector2(0,1)
var animation


func _ready():
	pass

func _physics_process(delta):
	Global.player_health = current_health
	var direction: Vector2
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
		
	var movement = speed * direction * delta
	
	if isAttacking == false:
		move_and_collide(movement)
		player_animations(direction)
		
	if !Input.is_anything_pressed():
		if isAttacking == false:
			animation = "idle" + returned_direction(new_direction)
	
	if direction != Vector2.ZERO:
		ray_cast.target_position = direction.normalized() * 50
	
	enemy_attacks()

	current_camera()
	
	if current_health <= 0:
		player_alive = false
		current_health = 0
		self.queue_free()

func handle_input():
	#var move_direction = Input.get_vector("left", "right", "up", "down")
	pass
	
func returned_direction(direction : Vector2):
		var normalized_direction  = direction.normalized()
		var default_return = "Right"
		if normalized_direction.y > 0:
			return "Down"
		elif normalized_direction.y < 0:
			return "Up"
		elif normalized_direction.x > 0:
			return "Right"
		elif normalized_direction.x < 0:
			return "Left"
		return default_return

func player_animations(direction : Vector2):
	#if isAttacking: return
	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk" + returned_direction(new_direction)
		animations.play(animation)
	else:
		animation  = "idle" + returned_direction(new_direction)
		animations.play(animation)
	
	
func _input(event):
	#input event for our attacking, i.e. our shooting
	if event.is_action_pressed("attack"):
		#attacking/shooting anim
		isAttacking = true
		var animation  = "attack" + returned_direction(new_direction)
		animations.play(animation)
	elif event.is_action_pressed("interact"):
			var target = ray_cast.get_collider()
			if target != null:
				if target.is_in_group("NPC"):
					return

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
	elif Global.current_scene == "cliff_side":
		$field_camera.enabled = false
		$cliffside_camera.enabled = true

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




func _on_animation_player_animation_finished(anim_name):
	isAttacking = false
