extends PanelContainer

# TODO name ===================>值 号<========================>
#region 信号
signal game_over
#endregion

# TODO name ===================>变 量<========================>
#region 变量
@onready var score_label: Label = %ScoreLabel
var score : int = 0
var current_pos : Vector2
#endregion

# TODO name ================================ 虚方法<===========================
#region 常用的虚方法
func _ready() -> void:  
	current_pos = global_position
	global_position.y = -700
	var tween : Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:y", current_pos.y, 1.0)
	await tween.finished
	score_label.text = "游戏分数:%s" % score

#endregion    

# TODO name ==========================> 信号链接方法=====================
#region 信号链接方法
func _on_restart_button_pressed() -> void:
	var tween : Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:y", -700, 1.0)
	await tween.finished
	game_over.emit()
	queue_free()


#endregion
