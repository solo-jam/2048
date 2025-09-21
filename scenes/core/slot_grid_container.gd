class_name SlotGridContianer extends GridContainer
const GAME_OVER = preload("res://scenes/ui/game_over.tscn")
const POP_LABEL = preload("res://scenes/ui/pop_label.tscn")
# TODO 网络格子容器 ===================>值 号<========================>
#region 信号

#endregion

# TODO 网络格子容器 ===================>常 量<========================>
#region 常量

#endregion

# TODO 网络格子容器 ===================>变 量<========================>
#region 变量
@onready var bgm: Node = %BGM
@onready var sfx: Node = %SFX
@onready var score_label: Label = %Score_Label
@onready var ui_ex: CanvasLayer = %UI_EX
@onready var bgm_audio_stream_player: AudioStreamPlayer2D = %BGMAudioStreamPlayer

@export var sfxs : Array[AudioStreamWAV]
@export var bgms : Array[AudioStreamWAV]

var slots : Array =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var rows : Array[Array] =[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
var cols : Array[Array] =[[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
var remaining_slots : Array = range(16) 
var last_slots : Array = []
#endregion

# TODO nme ================================ 虚方法<===========================
#region 常用的虚方法 
func _ready() -> void:
	for i  in 2 : create_slot_score(2)
	update_game_score()
	bgm_play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"): move_rows()
	if event.is_action_pressed("right"): move_rows(true)
	if event.is_action_pressed("up"): move_cols()
	if event.is_action_pressed("down"): move_cols(true)

#endregion    

# TODO 网络格子容器 ==========================> 信号链接方法=====================
#region 信号链接方法

#endregion

# TODO 网络格子容器 ==========================> 工具方法=====================
#region 工具方法
# Func 音乐播放
func bgm_play() -> void:
	bgm_audio_stream_player.stream = bgms[randi() % bgms.size()]
	bgm_audio_stream_player.play()
# Func 音效开关
func sfx_play() -> void:
	var audio_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	audio_player.stream = sfxs[randi() % sfxs.size()]
	audio_player.finished.connect(func(): audio_player.queue_free())
	sfx.add_child(audio_player)
	audio_player.play()
# Func 插件PopLabel
func create_pop_label(popStr : String) -> void:
	var popLabel : PopLabel = POP_LABEL.instantiate()
	popLabel.text = popStr
	ui_ex.add_child(popLabel)
# Func 记录移动前格子
func save_last_slots() -> void:
	last_slots = []
	for i in slots : last_slots.append(i)
# Func 撤回移动
func undo_slots_move() -> void:
	if last_slots.size() == 0 : 
		create_pop_label("当前无法撤回")
		return
	slots = last_slots
	update_slots_score()
	update_remaining_slots()
	update_game_score()
	last_slots = []
# Func 横向移动
func move_rows(reverse_flag : bool = false) -> void:
	if not can_move(rows, reverse_flag) : 
		create_pop_label("当前方向无法移动")
		return
	sfx_play()
	save_last_slots()
	move(rows, reverse_flag)
	merge_slots(rows, reverse_flag)
	move(rows, reverse_flag)
	update_slots_in_rows()
	update_remaining_slots()
	create_slot_score()
	update_game_score()
# Func 纵向移动
func move_cols(reverse_flag : bool = false) -> void:
	if not can_move(cols, reverse_flag) : 
		create_pop_label("当前方向无法移动")
		return
	sfx_play()
	save_last_slots()
	move(cols, reverse_flag)
	merge_slots(cols, reverse_flag)
	move(cols, reverse_flag)
	update_slots_in_cols()
	update_remaining_slots()
	create_slot_score()
	update_game_score()
# Func 能否移动
func can_move(arrs : Array, reverse_flag : bool = false) -> bool:
	if reverse_flag:
		for arr in arrs.size():
			var non_zero : int = -1
			for i in range(arrs[arr].size()-1, -1, -1):
				if arrs[arr][i] == 0 : continue
				if arrs[arr][i] == non_zero : return true
				if i + 1 < arrs[arr].size() and arrs[arr][i + 1] == 0 : return true
				non_zero = arrs[arr][i]
	else:
		for arr in arrs.size():
			var non_zero : int = -1
			for i in arrs[arr].size():
				if arrs[arr][i] == 0 : continue
				if arrs[arr][i] == non_zero : return true
				if i - 1 >= 0 and arrs[arr][i - 1] == 0 : return true
				non_zero = arrs[arr][i]
	return false
# Func 移动格子
func move(arrs : Array, reverse_flag : bool = false) -> void:
	if reverse_flag :
		for arr in arrs.size():
			var right : int = arrs[arr].size() - 1
			for left in range(arrs[arr].size() -1, -1, -1):
				if arrs[arr][left] == 0 : continue
				var temp_slot : int = arrs[arr][left]
				arrs[arr][left] = arrs[arr][right]
				arrs[arr][right] = temp_slot
				right -= 1
		return
	for arr in arrs.size():
		var left : int = 0 
		for right in arrs[arr].size():
			if arrs[arr][right] == 0 : continue
			var temp_slot : int = arrs[arr][right]
			arrs[arr][right] = arrs[arr][left]
			arrs[arr][left] = temp_slot
			left += 1
# Func 合并格子
func merge_slots(arrs : Array, reverse_flag : bool = false) -> void:
	for arr in arrs.size():
		var arr_size =  arrs[arr].size()
		if reverse_flag :
			for i in range(arr_size - 1, 0, -1):
				if arrs[arr][i] == arrs[arr][i - 1] and arrs[arr][i] != 0:
					arrs[arr][i]  *= 2
					arrs[arr][i - 1] = 0
			continue
		for i in arr_size - 1:
			if arrs[arr][i] == arrs[arr][i + 1] and arrs[arr][i] != 0:
				arrs[arr][i] *= 2
				arrs[arr][i + 1] = 0
			
# Func 重新开始游戏
func restart_game() -> void:
	slots =[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	remaining_slots = range(16) 
	for i  in 2 : create_slot_score(2)
	update_game_score()
# Func 更新空位
func update_remaining_slots() -> void:
	remaining_slots = []
	for i in slots.size():
		if slots[i] == 0:
			remaining_slots.append(i)
# Func 更新游戏分数
func update_game_score() -> void:
	var game_score : int = 0
	for i in slots : game_score += i
	score_label.text = "游戏分数：%s" % game_score
	if not can_move(rows) and not can_move(rows, true) and not can_move(cols) and not can_move(cols, true) :
		var game_over = GAME_OVER.instantiate()
		ui_ex.add_child(game_over)
		game_over.score = game_score
		game_over.game_over.connect(restart_game)
# Func 根究rows更新slots
func update_slots_in_rows() -> void:
	for r in rows.size():
		for i in rows[r].size():
			slots[r * 4 + i] = rows[r][i]
# Func 根据cols更新slots
func update_slots_in_cols() -> void:
	for c in cols.size():
		for i in cols[c].size():
			slots[i * 4 + c] = cols[c][i]
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
