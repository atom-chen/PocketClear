local SceneEx = cc.Scene;

function SceneEx:init(name, model, ...)
    self:setName(name)
        :enableNodeEvents();

    self.M = model;
    self.pushEsc = false;
    return self;
end

function SceneEx:onEnter()
    print(string.format("[scene]%s:onEnter", self:getName()));
    self:loading(configScene[self:getName()]);
end

function SceneEx:onExit()
    print(string.format("[scene]%s:onExit", self:getName()));
end

function SceneEx:onEnterTransitionFinish()
    print(string.format("[scene]%s:onEnterTransitionFinish", self:getName()));
end

function SceneEx:onExitTransitionStart()
    print(string.format("[scene]%s:onExitTransitionStart", self:getName()));
    if (self.preDelete) then
        self:preDelete()
    end
end

function SceneEx:onCleanup()
    print(string.format("[scene]%s:onCleanup", self:getName()));

    self.pushEsc = false; 
    
    --释放键盘事件
    if (DEBUG >= 2) then
        self:removeEventKeyboard();
    end
    
    --释放监听器
    if (self.customEventListeners)
        and (nil ~= next(self.customEventListeners)) then
        for i=1, #self.customEventListeners do
            self:getEventDispatcher()
                :removeEventListener(self.customEventListeners[i]);
        end
    end
    
    --释放定时器
    self:removeAllScheduler();
    
    --释放场景Model
    if (self.M) then
        self.M:delete();
        self.M = nil;
    end
    
    --释放场景view
    if (self.onDelete) then
        self:onDelete();
    end
    
    self:releaseResource();
    self:disableNodeEvents();
end

function SceneEx:loading(c)
    self.configure = c or {};

     --让某些设备没有黑边
    display.newSprite("image/ipadBg.jpg")
                :addTo(self)
                :centerTo(self)
                :setScale(4)
                :setLocalZOrder(-1000);

    --显示loading界面
    if (self.configure.loading) then
        self.loadingBG = display.newSprite(self.configure.loading.img)
                                :addTo(self)
                                :centerTo(self)
                                -- :setOpacity(0)
                                -- :fadeIn(0.3)
                                :setCascadeOpacityEnabled(true)
                                :setLocalZOrder(1000);
        self.loadingBGBeginTime = os.time();
        
        display.newSprite("image/tips/tips" .. math.random(1, 5) .. ".png")
               :addTo(self.loadingBG)
               :centerTo(self.loadingBG);
               
        if (DEBUG > 0) then
            cc.Label:createWithSystemFont("开始加载...", 30)
                    :addTo(self.loadingBG)
                    :centerTo(self.loadingBG)
                    :setName("info")
                    :setTextColor(cc.c4b(0, 0, 0, 255));
        end
    end
    
    --加载场景相关资源
    self:loadResource(self.configure.res, handler(self, self.initWithConfigure));
    return self;
end

function SceneEx:initWithConfigure()
    if (DEBUG > 0) then
        if (nil ~= self.loadingBG) then
            self.loadingBG:seekNodeByName("info")
                      :setString("适配场景开始...");
        end
    end

    --添加键盘事件
    self:onEventKeyboard(function(keycode) --按下

    end, function(keycode) --释放
        local method = self["keyboard" .. keycode];
        if (nil ~= method) then
            method(self);
        end
    end)
    
    --添加音乐
    if (self.configure.bgMusic) then
        audio.playMusic(unpack(self.configure.bgMusic));
        
        if (self.configure.bgMusic.volume) then
            audio.setMusicVolume(self.configure.bgMusic.volume);
        end

        if (DEBUG > 0) then
            if (nil ~= self.loadingBG) then
                self.loadingBG:seekNodeByName("info")
                    :setString("添加音乐" .. self.configure.bgMusic[1]);
            end
        end
    end
    
    --初始化该场景自定义层
    if (nil ~= self.configure.customLayers)
        and (nil ~= next(self.configure.customLayers)) then
        local isCreateBGLayer, layerNum = false, #self.configure.customLayers;
        for i=1, layerNum do
            if (layerName == "bgLayer") then
                isCreateBGLayer = true;
            end

            local layerName = self.configure.customLayers[i];
            self[layerName] = cc.Layer:create()
                                :setAnchorPoint(cc.p(0, 0))
                                :setContentSize(cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height))
                                :addTo(self)
                                :centerTo(self)
                                :setLocalZOrder(-(layerNum-i));
        end
        
        if (not isCreateBGLayer) then
            self["bgLayer"] = cc.Layer:create()
                                      :setAnchorPoint(cc.p(0, 0))
                                      :setContentSize(cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height))
                                      :addTo(self)
                                      :centerTo(self)
                                      :setLocalZOrder(-layerNum);
        end

        if (DEBUG > 0) then
            if (nil ~= self.loadingBG) then
                self.loadingBG:seekNodeByName("info")
                    :setString("初始化该场景自定义层");
            end
        end
    end

    --添加背景图片
    if (self.configure.bgImg) then
        display.newSprite(self.configure.bgImg.img)
                :addTo(self.bgLayer)
                :centerTo(self.bgLayer);

        if (DEBUG > 0) then
            if (nil ~= self.loadingBG) then
                self.loadingBG:seekNodeByName("info")
                    :setString("添加背景图片" .. self.configure.bgImg.img);
            end
        end
    end
    
    --添加背景资源结点
    if (self.configure.nodeRes) then
        self.resourceNode = cc.CSLoader:createNode(self.configure.nodeRes.path)
                                       :setContentSize(CC_DESIGN_RESOLUTION)
                                       :addTo(self.bgLayer);
        if (DEBUG > 0) then
            if (nil ~= self.loadingBG) then
                self.loadingBG:seekNodeByName("info")
                    :setString("添加场景结点" .. self.configure.nodeRes.path);
            end
        end
    end
    
    --初始化步进函数
    if (self.loop) then
        self:scheduleUpdate(handler(self, self.loop));

        if (DEBUG > 0) then
            if (nil ~= self.loadingBG) then
                self.loadingBG:seekNodeByName("info")
                    :setString("初始化步进函数");
            end
        end
    end

    if (self.onCreate) then
        self:onCreate();
        
        if (DEBUG > 0) then
            if (nil ~= self.loadingBG) then
                self.loadingBG:seekNodeByName("info")
                    :setString("指定场景调用初始化函数");
            end
        end
    end
    
    --隐藏loading界面
    if (self.loadingBG) then
        local actionArr = {};
        local diffTime = os.time() - self.loadingBGBeginTime;

        if (diffTime <= self.configure.loading.minTime) then
            local waitTime = self.configure.loading.minTime - diffTime;
            table.insert(actionArr, cc.DelayTime:create(waitTime)); 
        end
        
        table.insert(actionArr, cc.FadeOut:create(0.3));
        table.insert(actionArr, cc.CallFunc:create(function ()
            if (self.onLoadingEnd) then
                self:onLoadingEnd();
            end
            
            if (DEBUG > 0) then
                if (nil ~= self.loadingBG) then
                    self.loadingBG:seekNodeByName("info")
                                  :setString("加载完成!!!!!")
                                  :hide();
                end
            end
        end));
        self.loadingBG:runAction(cc.Sequence:create(actionArr));
    end

    return self;
end

--场景主循环
function SceneEx:loop(dt)
    if (self.step) then
        self:step(dt);
    end
    
    if (self.panelLayer) then
        local chirdren = self.panelLayer:getChildren();
        for i=1, #chirdren do
            if (chirdren[i]) and (chirdren[i].step) then
                chirdren[i]:step(dt);
            end
        end
    end
end

--预加载场景相关资源
function SceneEx:loadResource(resource, endLoadingCall)
    self.loadProcess = 0;
    resource = resource or {};

    --第三步, 加载音效或者音乐
    local function loadMP3s()
        -- self.loadProcess = 3;
        -- if (resource.audios) then
        --     for i=1, #resource.audios do
        --         local mp3C = resource.mp3s[i];
        --         if (mp3C.type == "music") then
        --             audio.preloadMusic(mp3C[1]);
        --         else
        --             audio.preloadSound(mp3C[1]);
        --         end

        --         if (DEBUG > 0) then
        --             if (nil ~= self.loadingBG) then
        --                 self.loadingBG:seekNodeByName("info")
        --                           :setString("加载音效或者音乐..." .. mp3C.path);
        --             end
        --         end
        --     end
        -- end

        if (endLoadingCall) then
            endLoadingCall();
        end
    end

    --第二步, 加载骨骼动画
    local function loadArmatures()
        if (nil == resource.armatures) 
            or (nil == next(resource.armatures)) then
            loadMP3s();
            return;
        end

        local function armatureLoading(percent)
            if (percent >= 1) then
                loadMP3s();
            end
        end
        
        self.armaturesIDList = {};
        for i=1, #resource.armatures do
            local args, armatureC = {}, resource.armatures[i];
            if (armatureC.iFile) then
                table.insert(args, armatureC.iFile);
            end

            if (armatureC.pFile) then
                table.insert(args, armatureC.pFile);
            end
            table.insert(args, armatureC.cFile);
            
            local fileExtension = cc.FileUtils:getInstance():getFileExtension(armatureC.cFile);
            if (".exportjson" == fileExtension) then
                ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(unpack(args));
            else
                table.insert(args, armatureLoading);
                ccs.ArmatureDataManager:getInstance():addArmatureFileInfoAsync(unpack(args));
            end
            table.insert(self.armaturesIDList, armatureC.cFile);

            if (DEBUG > 0) then
                if (nil ~= self.loadingBG) then
                    self.loadingBG:seekNodeByName("info")
                        :setString("加载骨骼动画..." .. armatureC.cFile);
                end
            end
        end
    end

    --第一步, 加载纹理
    local function loadImages()
        if (nil == resource.imgs) 
            or (nil == next(resource.imgs)) then
            loadArmatures();
            return;
        end

        local loadCount = 0;
        local function imageLoading(texture)
            loadCount = loadCount + 1;
            local imageC = resource.imgs[loadCount];
            if (imageC.plist) then
                display.loadSpriteFramesWithTexture(imageC.plist, texture);
            end

            if (loadCount==(#resource.imgs)) then
                loadArmatures();
            end
        end

        for i=1, #resource.imgs do
            local imageC = resource.imgs[i];
            display.loadImage(imageC.img, imageLoading);

            if (DEBUG > 0) then
                if (nil ~= self.loadingBG) then
                    self.loadingBG:seekNodeByName("info")
                                  :setString("加载纹理..." .. imageC.img);
                end
            end
        end
    end

    loadImages();
end

--释放场景相关资源
function SceneEx:releaseResource()
    --释放骨骼动画
    for i=1, #self.armaturesIDList do
        local armatureID = self.armaturesIDList[i];
        ccs.ArmatureDataManager:getInstance():removeArmatureFileInfo(armatureID);
    end

    --释放整图
    cc.SpriteFrameCache:getInstance():removeSpriteFrames();
    
    --释放散图
    cc.Director:getInstance():getTextureCache():removeAllTextures();

    self.configure = nil;
    
    if (DEBUG > 1) then
        print("================================================================");
        print(cc.Director:getInstance():getTextureCache():getCachedTextureInfo());
        print("================================================================");
    end
end

--切换场景
function SceneEx:showWithScene(transition, time, more)
    self:setVisible(true);
    display.runScene(self, transition, time, more);
    return self;
end

--获得指定层
function SceneEx:getLayer(name)
    return self[name];
end

--动态加载骨骼动画
function SceneEx:loadArmature(id)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(id);
    table.insert(self.armaturesIDList, id);
end

-- {["nodeName"]={varname=name, events={event=, method=}}, ...},
function SceneEx:createResoueceBinding(binding)
    assert(self.resourceNode, "ViewBase:createResoueceBinding() - not load resource node");
    for nodeName, nodeBinding in pairs(binding) do
        local node = self.resourceNode:getChildByName(nodeName);
        if nodeBinding.varname then
            self[nodeBinding.varname] = node;
        end
        for _, event in ipairs(nodeBinding.events or {}) do
            if event.event == "touch" then
                node:onTouch(handler(self, self[event.method]));
            end
        end
    end
end

function SceneEx:setEscFlag(value)
    self.pushEsc = value;
end

--根据Panel名字来获取Panel
function SceneEx:getPanelByName(name)
    local panel = nil;
    local chidren = self:getLayer("panelLayer"):getChildren();
    for i=1, #chidren do
        local cName = chidren[i]:getName();
        if (cName == name) then
            panel = chidren[i];
            break;
        end
    end
    return panel;
end

--=============================================键盘监听
function SceneEx:keyboard6()
    if (self.pushEsc) then
        return;
    end
    
    self.pushEsc = true;
    local curScene = display.getRunningScene();
    if (curScene:getName() ~= "login") then
        require("app.context.contextPanel"):create("pause");
    end
end

function SceneEx:keyboard76() --数字0,打开查看器
    
end

function SceneEx:keyboard77() --数字1
    -- body
end

function SceneEx:keyboard78() --数字2
    -- body
end

function SceneEx:keyboard79() --数字3
    -- body
end

function SceneEx:keyboard80() --数字4
    -- body
end

function SceneEx:keyboard81() --数字5
    -- body
end

function SceneEx:keyboard82() --数字6
    -- body
end

function SceneEx:keyboard83() --数字7
    -- body
end

function SceneEx:keyboard84() --数字8
    -- body
end

function SceneEx:keyboard85() --数字9
    -- body
end