--场景配置
local configScene = {
	--模板
	-- template = {
	-- 	res = {
	-- 		imgs = {{plist="", img="",}, {img="",},}, --场景所需要的图(整图or散图)
	-- 		armatures = {}, --场景所需要的骨骼动画
	-- 		mp3 = {}, --场景所需要的音乐or音效
	-- 	},

	-- 	loading = {img="", }, --loading过程
	-- 	bgImg = {img="", }, --背景图片
	-- 	nodeRes = {path="",}, --场景配置文件
	-- 	transition = {}, --场景动画
	--  bgMusic = {path="", loop=false, volume=1,}, --场景背景音乐
	--  customLayers = {"bgLayer", "menuLayer", "panelLayer"}, --每个场景自定义层
	-- },

	--===============================================
	--					 登陆
	--===============================================
	login = {
		res = {
			armatures = {
				-- configArmature.marsSplash, 
				configArmature.login, 
				configArmature.logo, 
				configArmature.loginBtn,
			},
			
			audios = {
				configAudio.music_1, 
			},
		},
		
	 	bgMusic = configAudio.music_1, --场景背景音乐
	},
	
	--===============================================
	--				    选择关卡
	--===============================================
	selectLevel = {
		res = {
			imgs = {
				{img="tiledMap/guanka002.png",},
				{img="tiledMap/guanka003.png",},
				{img="tiledMap/guanka004.png",},
				{img="tiledMap/guanka005.png",},
				{img="tiledMap/guanka006.png",},
				{img="tiledMap/guanka007.png",},
				{img="tiledMap/guanka008.png",},
				{img="tiledMap/guanka009.png",},
				{img="tiledMap/guanka010.png",},
				{img="tiledMap/guanka011.png",},
				{img="tiledMap/guanka012.png",},
				{img="tiledMap/guanka013.png",},
				{img="tiledMap/guanka014.png",},
				{img="tiledMap/guanka015.png",},
				{img="tiledMap/guanka016.png",},
				{plist="texture/common.plist", img="texture/common.png",}, 
				{plist="texture/selectLevel.plist", img="texture/selectLevel.png",},
			},
			
			armatures = {
				configArmature.star, 
				configArmature.head,
				configArmature.cpLock,
				configArmature.icon,
				configArmature.newReward,
				configArmature.flipBrand,
			},
			
			audios = {
				configAudio.music_1, 
			},
		},
		
		loading = {img="image/loading.jpg", minTime=2.0,}, --loading过程
		bgMusic = configAudio.music_3, --场景背景音乐
		customLayers = {"bgLayer", "menuLayer", "panelLayer", "msgBoxLayer",},
		nodeRes = {path="texture/selectLevel.csb", },

		--====================================选择关卡自定义配置
		updateProperty = {
			--需要更新属性的名字, 更新属性的存档名字, 更新属性对应图标所进行的操作, 
			{"coin", {"item", 1, "num"}, 
			function()
				require("app.context.contextPanel")
					:create("shop", SHOP.MONEY)
					:getV()
					:registerCloseCallback(function()
						require("app.context.contextPoint")
							:create("coinAddBtn");
					end);
			end,},

			{"diamond", {"item", 2, "num"},
			function()
				require("app.context.contextPanel")
					:create("shop", SHOP.MONEY)
					:getV()
					:registerCloseCallback(function()
						require("app.context.contextPoint")
							:create("diamondAddBtn");
					end);
			end,},

			{"star", {"item", 3, "num"},},

			{"power", {"item", 4, "num"},
			function()
				local endTime = dataCenter:getDataByKey({"item", 200, "timebar"});
				if (endTime > 0) then
					return;
				end

				local curPower = dataCenter:getDataByKey({"item", 4, "num"});
				if (curPower >= golbal.powerLimit) then
					return;
				end

				require("app.context.contextPanel")
					:create("power")
					:getV()
					:registerCloseCallback(function()
						--体力已满判断
						local endTime = dataCenter:getDataByKey({"item", 200, "timebar"});
						local curPower = dataCenter:getDataByKey({"item", 4, "num"});
						if (endTime>0) or (curPower>=golbal.powerLimit) then
							return;
						end

						require("app.context.contextPanel")
							:create("fullPower");
					end);
			end,},

			{"score", {"item", 5, "num"},},

			{"magicTrip", "maxCP",},
		},

		--图标
		icons = {
			--左侧图标
			{
				function(root)
					local top = root:seekNodeByName("top");
					local pos = cc.p(top:getPosition());
					return cc.p(40, pos.y-140);
				end,

				cc.p(0, -160),

				--是否可见, 图标名字, 图标骨骼动画名字, 图标对应的操作, 礼包id, 动态显示(根据在线开关来决定是否显示)
				{	
					--免费钻石
					{
						name="freeDiamond", name_a="mianfeizuanshi", 
						opfunc=function()
							require("app.module.msgBox.msgBox")
                                    :create(configPanel.msgBox_VideoReward, 
                                    		function() --sure call
                                    			golbal.playVideoAD(function(result)
													local itemID = nil;
													if ("look" == result) then --观看视频
														itemID = 220;
													elseif ("download" == result) then --下载游戏
														itemID = 223;
													else
														return;
													end

													local itemData = configItem[itemID];
													local id= itemData.pack[1].id;
													local num = math.random(itemData.pack[1].num.min, itemData.pack[1].num.max);
													display.getRunningScene().M:addItem(id, num);

													require("app.context.contextPanel")
														:create("showItemReward", {{id, num},});
												end);
                                    		end);

							--数据统计
							golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._3,});
						end,

						isVisible=function()
							return golbal.isShowIconAtSelectLevel();
						end,
					},

					--翻牌
					{
						name="flipBrand", name_a="fanpai", giftID=109,
						opfunc=function(target)
							local energy = dataCenter:getDataByKey("flipBrandEnergy");
							if (energy >= golbal.flipBrandEnergy) then
								display.getRunningScene().M:modifyDataByKey("flipBrandEnergy", -golbal.flipBrandEnergy);
								require("app.context.contextPoint")
									:create(109, {configAccountingData[2],});
							else
								local flipBrandCue = target:seekNodeByName("flipBrandCue");
								if (nil == flipBrandCue) then
									ccs.Armature:create("icon")
										:setName("flipBrandCue")
										:addTo(target)
										:play("fanpaitishi")
										:moveDiff(180, 140)
										:delayCall(2.0, function(armature)
											armature:removeSelf();
										end);
								end
							end
						end,

						isVisible=function()
							local maxCP = dataCenter:getDataByKey("maxCP");
							if (maxCP >= golbal.flipBrandTriggerCP) then
								if (maxCP == golbal.flipBrandTriggerCP) then
									local m, s = dataCenter:getDataByKey({"guideIndex", 10020, #configGuide[10020]+1});
									if (nil==m)and(nil==s) then
										dataCenter:setDataByKey("flipBrandEnergy", golbal.flipBrandEnergy);
									end
								end

								--引导调用
								local id = nil;
								id = golbal.scheduler(function()
									require("app.context.contextGuide")
										:create(10020, 1);
									golbal.removeScheduler(id);
									id = nil;
								end, 0, false);
								return true;
							end
							return false;
						end,
					},

					--红包
					{
						name="redPacket", name_a="hongbao", 
						opfunc=function(target)
							local redIndex = dataCenter:getDataByKey("redIndex");
							local itemID = configRedData[redIndex];
							if (nil == itemID) then
								return;
							end
							
							local endTime = dataCenter:getDataByKey({"item", itemID, "timebar"});
							if (os.time() >= endTime) then
								require("app.context.contextPanel")
									:create("redPacket");
							else
								target:seekNodeByName("armature")
									  :play("nohongbao")
							end
						end,

						isVisible=function()
							return true;
						end,
					},
					
					--投诉热线
					{ 
						name="complain", name_a="tousurexian", 
						opfunc=function()
							require("app.context.contextPanel")
								:create("complain");
						end,
					},

					--补满体力
					{
						name="", name_a="", 
						opfunc=function() --图标响应操作
						end,
					},
				}, --图标列表
			},

			--右侧图标
			{
				function(root)
					local top = root:seekNodeByName("top");
					local pos = cc.p(top:getPosition());
					local rootSize = root:getContentSize();
					return cc.p(rootSize.width-144, pos.y+(-140));
				end,

				cc.p(0, -140),

				--是否可见, 图标名字, 图标骨骼动画名字, 
				{	
					--游戏公告
					{ 
						name="notice", name_a="gonggao", 
						opfunc=function()
							golbal.lua2oc("Adapter", "showInterstitialNotification", {msg="notice",});
						end,

						isVisible=function()
							return true;
						end,
					},

					--签到
					{
						name="signIn", name_a="qiandaonormal", 
						opfunc=function()
							require("app.context.contextPanel")
								:create("signIn");
						end,
						
						isVisible=function()
							local maxCP = dataCenter:getDataByKey("maxCP");
							if (maxCP >= golbal.signInTriggerCP) then
								if (not display.getRunningScene().M:isSign()) then
									local id = nil;
									id = golbal.scheduler(function()
										require("app.context.contextGuide")
											:create(10006, 1);
										golbal.removeScheduler(id);
										id = nil;
									end, 0, false);
								end
								return true;
							end
							return false;
						end,
					},

					--奇幻之旅
					{
						name="magicTrip", name_a="qihuanlvcheng", 
						opfunc=function()
							require("app.context.contextPanel")
								:create("trip");
						end,

						isVisible=function()
							local unlockLimit = configTrip[1][2];
							local maxCP = dataCenter:getDataByKey("maxCP");
							if (maxCP >= unlockLimit) then
								if (unlockLimit == maxCP) then
									local id = nil;
									id = golbal.scheduler(function()
										require("app.context.contextGuide")
											:create(10007, 1);
										golbal.removeScheduler(id);
										id = nil;
									end, 0, false);
								end
								return true;
							end
							return false;
						end,
					},

					--星级奖励
					{
						name="starReward", name_a="haohualibaonormal", 
						opfunc=function()
							require("app.context.contextPanel")
								:create("starReward");
						end,
						
						isVisible=function()
							local curStars = dataCenter:getDataByKey({"item", 3, "num"});
							if (curStars >= configStarReward[1].stars) then
								local id = nil;
								id = golbal.scheduler(function()
									require("app.context.contextGuide")
										:create(10010, 1);
									golbal.removeScheduler(id);
									id = nil;
								end, 0, false);
								return true;
							end
							return false;
						end,
					},

					--首充大礼包
					{
						name="firstCharge", name_a="yimaoqian", giftID=106,
						opfunc=function()
							require("app.context.contextPoint")
								:create(106);
						end,

						isVisible=function()
							if (dataCenter:getDataByKey("maxCP") >= golbal.firstChargeTriggerCP) then
								return true;
							end
							return false;
						end,
					},
					
					--倒霉熊的礼物
					{
						name="backkom", name_a="yiyuanqian", giftID=110,
						opfunc=function() 
							require("app.context.contextPoint")
								:create(110);
						end,

						isVisible=function()
							if (dataCenter:getDataByKey({"item", 106, "buyTime"}) > 0) then
								return true;
							end
							return false;
						end,
					},

					--至尊大礼包
					{
						name="extreme", name_a="zhizunlibao", 
						giftID=108,
						opfunc=function()
							require("app.context.contextPoint")
								:create(108);
						end,

						isVisible=function()
							if (dataCenter:getDataByKey({"item", 110, "buyTime"}) > 0) then
								return true;
							end
							return false;
						end,
					},

					--新手礼包
					{	
						name="", name_a="", 
						opfunc=function()
						end,
					},

					--豪华大礼包
					{
						name="luxury", name_a="haohualibao", giftID=107,
						opfunc=function() 
							require("app.context.contextPoint")
								:create(107);
						end,
					},
					
					--VIP钻石大礼包
					{
						name="", name_a="", 
						opfunc=function()
						end,
					},
				}, --图标列表
			},

			--左下侧图标
			{
				function(root)
					return cc.p(20, 10);
				end,
				
				cc.p(140, 0),
				
				--是否可见, 图标名字, 图标骨骼动画名字, 
				{
					--系统
					{
						name="system", name_a="shezhi", 
						opfunc=function()
						require("app.context.contextPanel")
							:create("pause");
						end,

						isVisible=function()
							return true;
						end,
					},

					--加5步
					{
						visible=false, name="", name_a="", 
						opfunc=function()
						end,
					},

					--豪华钻石礼包
					{
						name="luxuryDiamond", name_a="haohualibaonormal", giftID=105,
						opfunc=function()
							require("app.context.contextPoint")
								:create(105);
						end,
					},

					--一大袋金币
					{
						name="bigCoin", name_a="haohualibaonormal", giftID=115,
						opfunc=function()
							require("app.context.contextPoint")
								:create(115);
						end,
					},

					{
						name="", name_a="haohualibaonormal", 
						opfunc=function()
						end,
					},	

					{
						name="", name_a="haohualibaonormal", 
						opfunc=function()
						end,
					},	
				}, --图标列表
			},

			--右下侧图标
			{
				function(root)
					local rootSize = root:getContentSize();
					return cc.p(rootSize.width-144, 10);
				end,

				cc.p(-150, 0),

				--是否可见, 图标名字, 图标骨骼动画名字, 
				{
					--商店
					{
						name="shop", name_a="shangdian", 
						opfunc=function()
							require("app.context.contextPanel")
								:create("shop", SHOP.MEAL);
						end,

						isVisible=function()
							return true;
						end,
					},

					--幸运转轮
					{
						name="wheel", name_a="xingyunzhuanpan", 
						opfunc=function()
							require("app.context.contextPanel")
								:create("wheel");
						end,

						isVisible=function()
							local maxCP = dataCenter:getDataByKey("maxCP");
							if (maxCP >= golbal.wheelTriggerCP) then
								-- local id = nil;
								-- id = golbal.scheduler(function()
								-- 	require("app.context.contextGuide")
								-- 		:create(10014, 1);
								-- 	golbal.removeScheduler(id);
								-- 	id = nil;
								-- end, 0, false);
								return true;
							end
							return false
						end,
					},

					--社区
					{
						name="community", name_a="huodong", 
						opfunc=function()
							golbal.lua2oc("Adapter", "show");
						end,

						isVisible=function()
							return golbal.isShowIconAtSelectLevel();
						end,
					},

					{
						name="", name_a="haohualibaonormal", 
						opfunc=function()
						end,
					},
				}, --图标列表
			},
		},
	},
	
	--===============================================
	--				    主场景
	--===============================================
	main = {
		res = {
			imgs = {
				{plist="texture/common.plist", img="texture/common.png",}, 
				{plist="texture/main.plist", img="texture/main.png",}, 
				{plist="texture/redPacket.plist", img="texture/redPacket.png",}, 
			},
			
			armatures = {
				configArmature.grid_t,
				configArmature.backkom,
				configArmature.cbEffect,
				
				configArmature.lizard,
				configArmature.star, 
				configArmature.starActivate,
				configArmature.attackPre,
				configArmature.actionStep,
				configArmature.actionTime,

				configArmature.hammer,
				configArmature.bomb,

				configArmature.pitch,
			},
			
			audios = {
				configAudio.music_2, 
			},
		},
		
		loading = {img="image/loading.jpg", minTime=2.0,}, --loading过程
		bgMusic = configAudio.music_2, --场景背景音乐
		customLayers = {"bgLayer", "menuLayer", "panelLayer", "msgBoxLayer",},
		nodeRes = {path="texture/main.csb", },
	},
};

return configScene;