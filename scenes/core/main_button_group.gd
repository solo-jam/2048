class_name main_button_group extends VBoxContainer

@onready var slot_grid_container: SlotGridContianer = $"../VBoxContainer/PanelContainer/MarginContainer/SlotGridContainer"

# TODO 主按钮组 ==========================> 信号链接方法=====================
#region 信号链接方法
func _on_restart_button_pressed() -> void:
	slot_grid_container.restart_game()
#endregion
