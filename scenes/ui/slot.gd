class_name Slot extends PanelContainer

# TODO 格子 ===================>常 量<========================>
#region 常量
const COLOR_1 : Color = Color("#FBC8CC")
const COLOR_2 : Color = Color("#FBA6AD")
const COLOR_3 : Color = Color("#F47982")
const COLOR_4 : Color = Color("#A36C78")
const COLOR_5 : Color = Color("#FAB27C")
const COLOR_6 : Color = Color("#FDCCA8")
const COLOR_7 : Color = Color("#C3619F")
const COLOR_8 : Color = Color("#E89BCD")
const COLOR_9 : Color = Color("#62885C")
const COLOR_10 : Color = Color("#1F6F13")
const COLOR_11 : Color = Color("#92DDD5")
const COLOR_12 : Color = Color("#0E544C")
const COLOR_13 : Color = Color("#83161E")
const COLOR_14 : Color = Color("#1F6F13")
#endregion

# TODO 格子 ===================>变 量<========================>
#region 变量
@onready var label: Label = $Label
var score : int = 0 :
	set(v):
		score = v
		label.text = "%s" % score
		label.visible = score != 0 
		var tween : Tween = create_tween()
		match score:
			0 : tween.tween_property(self, "modulate", COLOR_1,0.5)
			2 : tween.tween_property(self, "modulate", COLOR_2,0.5)
			4 : tween.tween_property(self, "modulate", COLOR_3,0.5)
			8 : tween.tween_property(self, "modulate", COLOR_4,0.5)
			16 : tween.tween_property(self, "modulate", COLOR_5,0.5)
			32 : tween.tween_property(self, "modulate", COLOR_6,0.5)
			64 : tween.tween_property(self, "modulate", COLOR_7,0.5)
			128 : tween.tween_property(self, "modulate", COLOR_8,0.5)
			256 : tween.tween_property(self, "modulate", COLOR_9,0.5)
			512 : tween.tween_property(self, "modulate", COLOR_10,0.5)
			1024 : tween.tween_property(self, "modulate", COLOR_11,0.5)
			2048 : tween.tween_property(self, "modulate", COLOR_12,0.5)
			4096 : tween.tween_property(self, "modulate", COLOR_13,0.5)
			8192 : tween.tween_property(self, "modulate", COLOR_14,0.5)
#endregion
