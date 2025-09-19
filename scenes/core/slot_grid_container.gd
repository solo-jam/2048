class_name SlotGridContianer extends GridContainer

# TODO 网络格子容器 ===================>值 号<========================>
#region 信号

#endregion

# TODO 网络格子容器 ===================>常 量<========================>
#region 常量

#endregion

# TODO 网络格子容器 ===================>变 量<========================>
#region 变量
@onready var score_label: Label = $"../../../Score_Label"

var slots : Array =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var rows : Array[Array] =[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
var cols : Array[Array] =[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
var remaining_slots : Array = range(16) 
#endregion

# TODO nme ================================ 虚方法<===========================
#region 常用的虚方法
 
func _ready() -> void:
	for i  in 2 : create_slot_score(2)
	update_game_score()

#endregion    

# TODO 网络格子容器 ==========================> 信号链接方法=====================
#region 信号链接方法

#endregion

# TODO 网络格子容器 ==========================> 工具方法=====================
#region 工具方法
# Func 重新开始游戏
func restart_game() -> void:
	slots =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	remaining_slots = range(16) 
	for i  in 2 : create_slot_score(2)
	update_game_score()
# Func 更新游戏分数
func update_game_score() -> void:
	var game_score : int = 0
	for i in slots : game_score += i
	score_label.text = "游戏分数：%s" % game_score
# Func 根据slots更新rows
func update_rows() -> void:
	for i in slots.size(): rows[i / 4][i % 4] = slots[i]
# Func 根据slots更新cols
func update_cols() -> void:
	for i in slots.size(): cols[i % 4][i / 4] = slots[i]
# Func 更新slots值更新展示值
func update_slots_score() -> void:
	for i in get_child_count():
		var slot : Slot = get_child(i)
		slot.score = slots[i]
	
	update_cols()
	update_rows()

# Func 给格子加分数
func create_slot_score(_score : int = -1) -> void:
	var score : int = _score
	if score == -1 : score = 2 if randi() % 100 <= 89 else 4
	if remaining_slots.size() > 0 : 
		var randi_slot_index : int = remaining_slots.pop_at(randi() % remaining_slots.size())
		slots[randi_slot_index] = score 
		
		update_slots_score()
#endregion
