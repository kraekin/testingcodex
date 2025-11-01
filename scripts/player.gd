extends CharacterBody2D

signal health_changed(current: int, maximum: int)
signal player_died

@export var move_speed: float = 220.0
@export var acceleration: float = 8.0
@export var friction: float = 10.0
@export var bullet_scene: PackedScene
@export var fire_rate: float = 4.0
@export var projectile_speed: float = 420.0
@export var body_radius: float = 12.0
@export var body_color: Color = Color(0.1, 0.6, 1.0)
@export var max_health: int = 6

var _velocity_target: Vector2 = Vector2.ZERO
var _time_since_shot: float = 0.0
var _health: int

func _ready() -> void:
    collision_layer = 2
    collision_mask = 1 | 4
    _health = max_health
    emit_signal("health_changed", _health, max_health)
    queue_redraw()

func _draw() -> void:
    draw_circle(Vector2.ZERO, body_radius, body_color)
    var muzzle_dir := Vector2.RIGHT.rotated(rotation)
    draw_line(Vector2.ZERO, muzzle_dir * (body_radius + 6.0), Color.WHITE, 2.0)

func _physics_process(delta: float) -> void:
    InputHelper.ensure_actions()
    _update_direction(delta)
    _handle_rotation()
    _attempt_fire(delta)
    move_and_slide()

func _update_direction(delta: float) -> void:
    var input_vector := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    input_vector = input_vector.normalized()
    _velocity_target = input_vector * move_speed

    velocity = velocity.move_toward(_velocity_target, acceleration * move_speed * delta)

    if input_vector.is_zero_approx():
        velocity = velocity.move_toward(Vector2.ZERO, friction * move_speed * delta)

func _handle_rotation() -> void:
    var to_mouse := (get_global_mouse_position() - global_position)
    if to_mouse.length_squared() > 0.0001:
        rotation = to_mouse.angle()

func _attempt_fire(delta: float) -> void:
    _time_since_shot += delta
    var cooldown := 1.0 / fire_rate
    if Input.is_action_pressed("shoot") and _time_since_shot >= cooldown:
        _fire_bullet()
        _time_since_shot = 0.0

func _fire_bullet() -> void:
    if bullet_scene == null:
        return
    var bullet: Node2D = bullet_scene.instantiate()
    var muzzle_offset := Vector2(body_radius + 8.0, 0.0).rotated(rotation)
    bullet.global_position = global_position + muzzle_offset
    if bullet.has_method("configure"):
        bullet.call("configure", rotation, projectile_speed)
    get_tree().current_scene.add_child(bullet)

func take_damage(amount: int) -> void:
    _health = max(_health - amount, 0)
    emit_signal("health_changed", _health, max_health)
    if _health <= 0:
        emit_signal("player_died")
