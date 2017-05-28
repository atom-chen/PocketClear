local DataFromNet = class("DataFromNet", require("app.module.dataCenter.dataFromXml"));
local xmlInst = cc.UserDefault:getInstance();

local visiterPasswd = "1234567890"
local sessionid = -1
local accountid
local passwd
local native
local crack
local sync

--需要的数据
--账户数据
--账户密码
--好友 --从网络获取
--排行榜数据
--头像
--昵称

function DataFromNet:onCreate()

	for i=1, #configData do
		--是否有自定义读取xml函数->N:用UserDefault读取
		--						   Y:自定义读取
		local method = "read" .. configData[i].name;
		if (nil ~= self[method]) then
			self[method](self, configData[i]);
		else
			self[configData[i].name] = self:read(configData[i]);
		end
	end

    --是否存在本地数据
    if cc.UserDefault:isXMLFileExist() then
        native = 1
    else
        native = 0
    end

    --是否是破解版
    crack = false

    --随机游客账户
    --
    local ac = cc.UserDefault:getInstance():getStringForKey("accountid", "")
    if ac == "" or string.len(ac) ~= 32 then
        accountid = self:produceVisiter()
        cc.UserDefault:getInstance():setStringForKey("accountid", accountid)
    else
        accountid = ac
    end
    self:visiterLogin()
end

--=========================================
--				存盘操作
--=========================================
function DataFromNet:persistent(key, value)
	if (nil == key) then
		return;
	end
	
	local keepKey, firstkey = clone(key), nil;
	if ("string" == type(key)) then
		firstkey = key;
	else
		firstkey = table.remove(key, 1);
	end

	if (self["persistent" .. firstkey]) then
		self["persistent" .. firstkey](self, unpack(key), value);
	else
		local property = self.propertyMap[firstkey];
		local method = "set" .. property.type .. "ForKey";
		xmlInst[method](xmlInst, key, value);
		xmlInst:flush();
        --上传网络
	end
end


--游客登陆
--windows下查找游客账号是否存在，使用随机的32为字符串
--android平台下使用32位设备唯一识别码
--生成随机32位游客账户
function DataFromNet:produceVisiter()
    local function randNumLetter() 
        local rand = math.random(1, 62)
        local ch = 48
        if rand > 10 and rand <= 36 then
            ch = 64
            rand = rand - 10
        elseif rand > 36 then
            ch = 97
            rand = rand - 10 - 26
        end
        ch = ch + rand - 1
        return string.char(ch)
    end

    local visiter = ""
    for i = 1, 32 do
        visiter = visiter..randNumLetter()
    end
    return visiter
end

--是否登录
function DataFromNet:isLogin()
    return sessionid > 0
end

--是否能使用服务
function DataFromNet:canUseServer()
    if not crack then
        return true
    else
        if sync then
            return true
        end
    end
    return false
end

--游客登陆
function DataFromNet:visiterLogin()
    net.httpVisit(
    "/login", 
    {accountid = accountid,
    passwd = visiterPasswd,
    native = native},
    function(ret) 
        if ret then
            if ret.login == 1 then
                sessionid = ret.sessionid
                --好友数据
                self.friends = ret.playerData.friends
                --排行榜数据 (前50名)
                self.scoreRank = ret.playerData.scoreRank
                self.starRank = ret.playerData.starRank
                --自己的名次
                self.scoreRanking = ret.playerData.scoreRanking
                self.starRanking = ret.playerData.scoreRanking
                if crack then--询问--服务器同步本地数据（可以使用一切网络功能了）
                    
                else
                    --网络数据存在
                    if ret.item or ret.firstGameTime or ret.maxCP or ret.checkPoint then
                        --有本地数据，本地数据覆盖服务器
                        if native == 1 then
                            self:uploadNative()
                        else--询问是否同步服务器数据
                            
                        end
                    else
                        if native == 1 then --本地数据覆盖服务器
                            self:uploadNative()
                        end
                    end
                end
            else
                print("login failed")
            end
        else
            print("http visit maybe have some error")
        end
    end)
end

--上传本地数据
function DataFromNet:uploadNative()
    local tempItme = {}
    for k, v in pairs(self.item) do
        local key = k
        if type(k) == "number" then
            key = tostring(key)
        end
        tempItme[key] = v
    end
    local tempcheckPoint = {}
    for k, v in pairs(self.checkPoint) do
        local key = k
        if type(k) == "number" then
            key = tostring(key)
        end
        tempcheckPoint[key] = v
    end
    self:setNetConfigData("item", tempItme)
    self:setNetConfigData("firstGameTime", self.firstGameTime)
    self:setNetConfigData("maxCP", self.maxCP)
    self:setNetConfigData("checkPoint", tempcheckPoint)
end


--获取网络时间
function DataFromNet:getNetTime(callFunc)
    net.httpVisit(
    "/time",
    {sessionid = sessionid,
    accountid = accountid},
    callFunc)
--    function(ret) 
--        if ret then
--            if ret.time ~= -1 then
--                print("get time success")
--            else
--                print("get time failed")
--            end
--        else
--            print("http visit maybe have some error")
--        end
--    end)
end


--使用兑换码1
function DataFromNet:useExchangeCode1(code)
    net.httpVisit(
    "/ecgCode1",
    {code = code},
    function(ret)
         if ret then
            if ret.canUse == 1 then
                print(ret.reward)
                self:useExchangeCode2(code, ret.confirm2)
            else
                print("兑换码不可用")
            end
         else
            print("http visit maybe have some error")
         end
    end)
end

--使用兑换码2
function DataFromNet:useExchangeCode2(code, confirm2)
    net.httpVisit(
    "/ecgCode2",
    {code = code,
    confirm2 = confirm2},
    function(ret)
         if ret then
            if ret.success == 1 then
                print("兑换成功")
            else
                print("兑换失败")
            end
         else
            print("http visit maybe have some error")
         end
    end)
end

--获取存档数据
function DataFromNet:getNetConfigData(name)
    net.httpVisit(
    "/getConfigData",
    {sessionid = sessionid,
    accountid = accountid,
    name = name},
    function(ret)
        if ret then
            if ret.success == 1 then
                print("获取成功")
                print(json.encode(ret.value))
            end
        else
            print("http visit maybe have some error")
        end
    end
    )
end

--设置存档数据
function DataFromNet:setNetConfigData(name, value)
    net.httpVisit(
    "/setConfigData",
    {sessionid = sessionid,
    accountid = accountid,
    name = name,
    value = value},
    function(ret)
        if ret then
            if ret.success == 1 then
                print("设置成功")
            end
        else
            print("http visit maybe have some error")
        end
    end
    )
end

return DataFromNet;