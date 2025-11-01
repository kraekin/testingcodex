extends Area2D

@export var speed: float = 420.0
@export var lifetime: float = 1.5
@export var radius: float = 4.0
@export var color: Color = Color(1.0, 0.85, 0.2)

var _velocity: Vector2 = Vector2.ZERO
var _time_alive: float = 0.0

func _ready() -> void:
    collision_layer = 8
    collision_mask = 4
    monitoring = true
    monitorable = true
    if get_node_or_null("CollisionShape2D") == null:
        var collider := CollisionShape2D.new()
        var shape := CircleShape2D.new()
        shape.radius = radius
        collider.shape = shape
        add_child(collider)
    queue_redraw()
    body_entered.connect(_on_body_entered)

func configure(angle: float, custom_speed: float) -> void:
    rotation = angle
    speed = custom_speed
    _velocity = Vector2.RIGHT.rotated(rotation) * speed

func _process(delta: float) -> void:
    _time_alive += delta
    if _time_alive >= lifetime:
        queue_free()
        return
    position += _velocity * delta

func _draw() -> void:
    draw_circle(Vector2.ZERO, radius, color)

func _on_body_entered(body: Node) -> void:
    if body.has_method("take_damage"):
        body.call("take_damage", 1)
    queue_free()
