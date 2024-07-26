extends CharacterBody2D

@export var speed: float = 3

@onready var sprite: Sprite2D = $Sprite2D 
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_running: bool = false 
var is_attacking: bool  = false
var attack_cooldown: float = 0.0

func _process(delta: float) -> void:
	#Atualizar temporizador do attack
	if is_attacking:
		attack_cooldown -= delta  #0.6 - 0.016
		if attack_cooldown <= 0.0:
			is_attacking = false
			is_running  = false
			animation_player.play("idle")
	#pass
	

#func _process(delta: float) ->void:
	#if Input.is_action_just_pressed("move_up"):
		#if is_running:
			#animation_player.play ("idle")
			#is_running = false
		#else:
			#animation_player.play("run")
			#is_running = true
			
func _physics_process(delta: float) -> void:
	#Obter o input vector:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up","move_down")
	
	#Modificar a velocidade
	var target_velocity = input_vector * speed *100.0
	if is_attacking:
		target_velocity *=0.25
	velocity = lerp(velocity, target_velocity, 0.05)
	move_and_slide()
	
	# Atualizar o is_running
	var was_running= is_running
	is_running=input_vector.is_zero_approx()

	#Tocar animação
	if was_running != is_running:
		if is_running:
			animation_player.play("run")
		else:
			animation_player.play ("idle")
			
	#Girar sprite
	if input_vector.x>0:
		sprite.flip_h = false
		pass
		#desmarcar flip_h do Sprite2D
			
	elif input_vector.x<0:
		sprite.flip_h = true
		#marcar flip_h do sprite2D
			
	#Ataque
	if Input.is_action_just_pressed("attack"):
		attack()
			
func attack() -> void:
	if is_attacking:
		return
	#attack_side_1
	#Tocar animação
	animation_player.play("attack_side 1")
		
	# Configurar temporizador
	attack_cooldown = 0.6

	#Marcar ataque
	is_attacking  = true
