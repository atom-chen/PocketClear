--音乐or音效配置
local configAudio = {
	--音乐
	music_1 = {"music/bgm_1.mp3", true,}, --登陆or选择关卡场景背景音乐 volume-(0.0-1.0)
	music_2 = {"music/bg.mp3", true,}, --三消场景的背景音乐 volume-(0.0-1.0)
	music_3 = {"music/worldmap.mp3", true,}, --选择关卡音效
	music_4 = {"music/jinzhanggan.mp3", true,}, --最后5步or最后30秒

	--音效 (音效路径, 是否循环, 音量)
	sound_1 = {"music/open.mp3", false,}, --登陆or选择关卡界面背景音乐 volume-(0.0-1.0)
	sound_2 = {"music/checkpoint_Btn.mp3", false,}, --面板进入,退出
	sound_3 = {"music/pushBtn.wav", false}, --通用按钮声

	--自动消除音效
	sound_4 = {"music/autodel1.mp3", false,}, --2连
	sound_5 = {"music/autodel2.mp3", false,}, --3连
	sound_6 = {"music/autodel3.mp3", false,}, --4连
	sound_7 = {"music/autodel4.mp3", false,}, --5连
	sound_8 = {"music/autodel5.mp3", false,}, --6连
	sound_9 = {"music/autodel6.mp3", false,}, --7连
	sound_10 = {"music/autodel7.mp3", false,}, --8连
	sound_11 = {"music/autodel8.mp3", false,}, --9连

	--combo音效
	sound_12 = {"music/good.mp3", false,}, --combo音效
	sound_13 = {"music/great.mp3", false,}, --combo音效
	sound_14 = {"music/Amazing.mp3", false,}, --combo音效
	sound_15 = {"music/Excellent.mp3", false,}, --combo音效
	sound_16 = {"music/Unbelievable.mp3", false,}, --combo音效

	--炸弹爆炸
	sound_17 = {"music/bombDel.mp3", false,}, --横消or竖消
	sound_18 = {"music/bomb.mp3", false,}, --范围炸弹

	sound_19 = {"music/shouji.mp3", false,}, --收集
	sound_20 = {"music/chuizi.mp3", false,}, --锤子敲击

	sound_21 = {"music/meteor.mp3", false,}, --bonutime射击声音
	sound_22 = {"music/bonus_time.mp3", false,}, --bonustime呼声
	sound_23 = {"music/shengli.mp3", false,}, --胜利呼声

	sound_24 = {"music/yeah.mp3", false,}, --胜利呼声
	sound_25 = {"music/Win.mp3", false,}, --胜利“当当当 当当当 当”

	sound_26 = {"music/321_Go.mp3", false,}, --时间关卡倒计时

	sound_27 = {"music/AFdie.mp3", false,}, --小丑死亡
	sound_28 = {"music/AFfagong.mp3", false,}, --小丑攻击前置
	sound_29 = {"music/AFrendongxi.mp3", false,}, --小丑攻击
	sound_30 = {"music/AFshouji.mp3", false,}, --小丑受击
	sound_31 = {"music/AFxiao.mp3", false,}, --小丑笑
	sound_32 = {"music/AFyun.mp3", false,}, --小丑眩晕

	sound_33 = {"music/drop.mp3", false,}, --方块掉落
	sound_34 = {"music/xiaochu.mp3", false,}, --方块删除
	sound_35 = {"music/createBomb.mp3", false,}, --创建炸弹
	sound_36 = {"music/createBomb_row.mp3", false,}, --创建导弹
	sound_37 = {"music/daojishi.mp3", false,}, --倒计时
	sound_38 = {"music/hurryup.mp3", false,}, --快点
	-- sound_39 = {"music/jinzhanggan.mp3", false,}, --最后5步or最后30秒
	sound_40 = {"music/lose.mp3", false,}, --游戏失败
	sound_41 = {"music/sheng5bu.mp3", false,}, --还剩5步
};

return configAudio;