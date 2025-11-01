extends Node2D

@export var player_scene: PackedScene
@export var zombie_scene: PackedScene
@export var bullet_scene: PackedScene
@export var initial_zombie_positions: Array[Vector2] = [Vector2(220, -80), Vector2(-260, 120), Vector2(120, 200)]
@export var arena_half_extents: Vector2 = Vector2(400, 280)

const WallSegment := preload("res://scripts/wall_segment.gd")

var player: CharacterBody2D
var zombies: Array = []

func _ready() -> void:
    InputHelper.ensure_actions()
    _spawn_player()
    _spawn_initial_zombies()
    _create_bounds()

func _spawn_player() -> void:
    if player_scene == null:
        push_warning("Player scene is not assigned.")
        return
    player = player_scene.instantiate()
    add_child(player)
    if bullet_scene != null:
        player.bullet_scene = bullet_scene

func _spawn_initial_zombies() -> void:
    if zombie_scene == null:
        push_warning("Zombie scene is not assigned.")
        return
    for position in initial_zombie_positions:
        _spawn_zombie(position)

func _spawn_zombie(position: Vector2) -> void:
    var zombie: CharacterBody2D = zombie_scene.instantiate()
    zombie.global_position = position
    if player != null and zombie.has_method("set_target"):
        zombie.call("set_target", player)
    add_child(zombie)
    zombies.append(zombie)

func _create_bounds() -> void:
    var extents := arena_half_extents
    var thickness := 32.0
    var walls := [
        {"position": Vector2(0, -extents.y - thickness * 0.5), "size": Vector2(extents.x * 2 + thickness * 2, thickness)},
        {"position": Vector2(0, extents.y + thickness * 0.5), "size": Vector2(extents.x * 2 + thickness * 2, thickness)},
        {"position": Vector2(-extents.x - thickness * 0.5, 0), "size": Vector2(thickness, extents.y * 2)},
        {"position": Vector2(extents.x + thickness * 0.5, 0), "size": Vector2(thickness, extents.y * 2)}
    ]

    for wall_config in walls:
        var wall := WallSegment.new()
        wall.global_position = wall_config["position"]
        wall.size = wall_config["size"]
        add_child(wall)

    var blockers := [
        {"position": Vector2(-120, -40), "size": Vector2(140, 40)},
        {"position": Vector2(180, 60), "size": Vector2(120, 40)},
        {"position": Vector2(20, 160), "size": Vector2(200, 40)}
    ]

    for blocker in blockers:
        var wall := WallSegment.new()
        wall.global_position = blocker["position"]
        wall.size = blocker["size"]
        wall.color = Color(0.35, 0.35, 0.4)
        add_child(wall)
