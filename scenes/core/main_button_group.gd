class_name main_button_group extends VBoxContainer

@onready var mute_button: IconButton = %MuteButton
@onready var slot_grid_container: SlotGridContianer = %SlotGridContainer
var is_mute : bool = false

# TODO 主按钮组 ==========================> 信号链接方法=====================
#region 信号链接方法

func _on_close_button_pressed() -> void:
	get_tree().quit()

func _on_restart_button_pressed() -> void:
	slot_grid_container.restart_game()

func _on_undo_button_pressed() -> void:
	slot_grid_container.undo_slots_move()

func _on_mute_button_pressed() -> void:
	is_mute = !is_mute
	AudioServer.set_bus_mute(0, is_mute)
	mute_button.text = "音量\n关" if is_mute else "音量\n开"
#endregion
