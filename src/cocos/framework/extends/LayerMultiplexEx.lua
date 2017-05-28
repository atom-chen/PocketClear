local LayerMultiplex = cc.LayerMultiplex;

function LayerMultiplex:initWithLayers(arr)
    self:initWithArray(arr);
    return self;
end

function LayerMultiplex:setLayer(index)
    self:switchTo(index);
    return self;
end