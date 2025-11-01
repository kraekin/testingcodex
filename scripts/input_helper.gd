class_name InputHelper

static func _ensure_action(action_name: String, events: Array[InputEvent]) -> void:
    if InputMap.has_action(action_name):
        return
    InputMap.add_action(action_name)
    for event in events:
        InputMap.action_add_event(action_name, event)

static func ensure_actions() -> void:
    var actions: Dictionary = {
        "move_up": [
            _make_key_event(Key.KEY_W),
            _make_key_event(Key.KEY_UP)
        ],
        "move_down": [
            _make_key_event(Key.KEY_S),
            _make_key_event(Key.KEY_DOWN)
        ],
        "move_left": [
            _make_key_event(Key.KEY_A),
            _make_key_event(Key.KEY_LEFT)
        ],
        "move_right": [
            _make_key_event(Key.KEY_D),
            _make_key_event(Key.KEY_RIGHT)
        ],
        "shoot": [
            _make_mouse_event(MouseButton.MOUSE_BUTTON_LEFT),
            _make_key_event(Key.KEY_SPACE)
        ]
    }

    for action_name in actions.keys():
        _ensure_action(action_name, actions[action_name])

static func _make_key_event(keycode: int) -> InputEventKey:
    var event := InputEventKey.new()
    event.keycode = keycode
    event.physical_keycode = keycode
    return event

static func _make_mouse_event(button_index: int) -> InputEventMouseButton:
    var event := InputEventMouseButton.new()
    event.button_index = button_index
    return event
