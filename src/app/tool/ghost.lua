local ghost = class("ghost");

function ghost:ctor()

end

function ghost:add(node)
	local size = node:getBoundingBox()
    local posx,posy = node:getPosition()
    -- dump(size)
    -- print("pox:"..posx.."  posy:"..posy)
    if size.width < 1 then
        return
    end

    local canvas = cc.RenderTexture:create(size.width,size.height)
    node:setPosition(size.width/2,0)
    canvas:begin()
    node:visit()
    canvas:endToLua()
    cc.Director:getInstance():getRenderer():render()
    node:setPosition(posx,posy)

    local ghostSp = cc.Sprite:createWithTexture(canvas:getSprite():getTexture())
    ghostSp:setAnchorPoint(cc.p(0.5, 0))
    ghostSp:setPosition(posx, posy)
    ghostSp:setFlippedY(true);
    local fade = cc.Sequence:create(cc.FadeTo:create(1.0, 0),cc.CallFunc:create(function ()
        ghostSp:removeFromParent()
    end))
    node:getParent():addChild(ghostSp, node:getLocalZOrder());
    ghostSp:runAction(fade)
end

function ghost:getOne(node)
    local size = node:getBoundingBox()
    local posx,posy = node:getPosition()

    local canvas = cc.RenderTexture:create(size.width, size.height);
    node:setPosition(size.width/2, size.height/2)
    canvas:begin()
    node:visit()
    canvas:endToLua()
    cc.Director:getInstance():getRenderer():render()
    node:setPosition(posx,posy)

    local ghostSp = cc.Sprite:createWithTexture(canvas:getSprite():getTexture());
    ghostSp:setFlippedY(true);
    -- ghostSp:setPosition(posx, posy);

    -- local children = node:getChildren();
    -- for i=1, #children do
    --     if (children[i]:isVisible()) then
    --         -- print("#######################", children[i]:getName());
    --         local sprite = self:getOne(children[i]);
    --         sprite:addTo(ghostSp);
    --     end
    -- end

    return ghostSp;
end

return ghost;