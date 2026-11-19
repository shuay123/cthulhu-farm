extends Node

signal sanity_changed(new_value)
signal state_transition(from_state, to_state)

enum SanityState { NORMAL, WHISPER, CHAOS }
var current_state = SanityState.NORMAL
var current_sanity: float = 100.0

func modify_sanity(delta: float):
    current_sanity = clamp(current_sanity + delta, 0.0, 100.0)
    emit_signal("sanity_changed", current_sanity)
    _check_state_transition()

func _check_state_transition():
    if current_sanity > 60.0 and current_state != SanityState.NORMAL:
        current_state = SanityState.NORMAL
        emit_signal("state_transition", current_state)
    elif current_sanity <= 60.0 and current_sanity > 20.0 and current_state != SanityState.WHISPER:
        current_state = SanityState.WHISPER
        emit_signal("state_transition", current_state)
    elif current_sanity <= 20.0 and current_state != SanityState.CHAOS:
        current_state = SanityState.CHAOS
        emit_signal("state_transition", current_state)
