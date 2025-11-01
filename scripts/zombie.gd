extends CharacterBody2D

@export var move_speed: float = 140.0
@export var body_radius: float = 12.0
@export var body_color: Color = Color(0.6, 0.95, 0.5)
@export var max_health: int = 3
@export var attack_range: float = 24.0
@export var damage: int = 1
@export var attack_cooldown: float = 1.0

var target: Node2D
var health: int
var _time_since_attack: float = 0.0

func _ready() -> void:
    collision_layer = 4
    collision_mask = 1 | 2 | 8
    health = max_health
    update()

func _draw() -> void:
    draw_circle(Vector2.ZERO, body_radius, body_color)

func _physics_process(delta: float) -> void:
    _time_since_attack += delta
    if target == null:
        velocity = Vector2.ZERO
    else:
        var to_target := (target.global_position - global_position)
        if to_target.length_squared() > 0.0001:
            velocity = to_target.normalized() * move_speed
        else:
            velocity = Vector2.ZERO
        if to_target.length() <= attack_range and _time_since_attack >= attack_cooldown:
            if target.has_method("take_damage"):
                target.call("take_damage", damage)
            _time_since_attack = 0.0
    move_and_slide()

func take_damage(amount: int) -> void:
    health -= amount
    if health <= 0:
        queue_free()

func set_target(target_node: Node2D) -> void:
    target = target_node
