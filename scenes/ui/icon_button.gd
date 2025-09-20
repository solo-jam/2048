@tool
class_name IconButton extends PanelContainer

# TODO name ===================>值 号<========================>
#region 信号
signal pressed
#endregion

# TODO name ===================>常 量<========================>
#region 常量

#endregion

# TODO name ===================>变 量<========================>
#region 变量
@onready var margin_container: MarginContainer = $MarginContainer
@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label

@export var icon : Texture:
	set(v):
		icon = v
		if icon != null:
			texture_rect = %TextureRect
			texture_rect.texture = icon

@export_multiline var text : String:
	set(v):
		text = v
		if text != "":
			label =  %Label
			label.text = text
	
#endregion

# TODO name ================================ 虚方法<===========================
#region 常用的虚方法
 
func _ready() -> void:  
	pivot_offset = size / 2
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			pressed.emit()
#endregion    

# TODO name ==========================> 信号链接方法=====================
#region 信号链接方法
func _on_mouse_entered() -> void:
	z_index = 99
	var tween : Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(margin_container, "rotation_degrees", 90, 0.3)
	tween.tween_property(margin_container, "position:x", -16, 0.3)
	tween.tween_property(self, "scale", Vector2.ONE * 1.25, 0.3)
	tween.tween_property(self, "position:x", -16, 0.3)
	tween.tween_property(label, "modulate:a", 1, 0.3)


func _on_mouse_exited() -> void:
	z_index = 0
	var tween : Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(margin_container, "rotation_degrees", 0, 0.3)
	tween.tween_property(margin_container, "position:x", 0, 0.3)
	tween.tween_property(self, "scale", Vector2.ONE, 0.3)
	tween.tween_property(self, "position:x", 0, 0.3)
	tween.tween_property(label, "modulate:a", 0, 0.3)

#endregion

# TODO name ==========================> 工具方法=====================
#region 工具方法

#endregion
