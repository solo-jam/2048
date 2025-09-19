class_name SlotGridContianer extends GridContainer

# TODO 网络格子容器 ===================>值 号<========================>
#region 信号

#endregion

# TODO 网络格子容器 ===================>常 量<========================>
#region 常量

#endregion

# TODO 网络格子容器 ===================>变 量<========================>
#region 变量
var slots : Array =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var rows : Array[Array] =[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
var cols : Array[Array] =[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
var remaining_slots : Array = range(16) 
#endregion

# TODO nme ================================ 虚方法<===========================
#region 常用的虚方法
 
func _ready() -> void:
	for i  in 2 : create_slot_score(2)

#endregion    

# TODO 网络格子容器 ==========================> 信号链接方法=====================
#region 信号链接方法

#endregion

# TODO 网络格子容器 ==========================> 工具方法=====================
#region 工具方法
# Func 根据slots更新rows
func update_rows() -> void:
	for i in slots.size(): rows[i / 4][i % 4] = slots[i]
# Func 根据slots更新cols
func update_cols() -> void:
	for i in slots.size(): cols[i % 4][i / 4] = slots[i]
# Func 给格子加分数
func create_slot_score(_score : int = -1) -> void:
	var score : int = _score
	if score == -1 : score = 2 if randi() % 100 <= 89 else 4
	if remaining_slots.size() > 0 : 
		var randi_slot_index : int = remaining_slots.pop_at(randi() % remaining_slots.size())
		slots[randi_slot_index] = score 
		
		# 测试使用
		update_cols()
		update_rows()
#endregion
