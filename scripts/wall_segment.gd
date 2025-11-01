extends StaticBody2D

@export var size: Vector2 = Vector2(64, 32)
@export var color: Color = Color(0.25, 0.25, 0.3)

func _ready() -> void:
    collision_layer = 1
    collision_mask = 2 | 4 | 8
    _ensure_collider()
    queue_redraw()

func _ensure_collider() -> void:
    var collider := get_node_or_null("CollisionShape2D")
    if collider == null:
        collider = CollisionShape2D.new()
        add_child(collider)
    var rectangle := RectangleShape2D.new()
    rectangle.size = size
    collider.shape = rectangle

func _draw() -> void:
    draw_rect(Rect2(-size * 0.5, size), color)
