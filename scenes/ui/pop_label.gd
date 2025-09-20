class_name PopLabel extends Label

# TODO nme ================================ 虚方法<===========================
#region 常用的虚方法 
func _ready() -> void:
	var tween : Tween = create_tween().set_parallel().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position:y", global_position.y -500 , 1.0)
	tween.tween_property(self, "modulate:a", 0, 1.0)
	await tween.finished
	queue_free()
#endregion    
