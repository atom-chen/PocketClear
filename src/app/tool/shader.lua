local shader = class("Shader");

function shader:ctor()

end

function shader:getGLProgam(vsh, fsh)
	local fileUtiles = cc.FileUtils:getInstance();

	local vertSource = nil;
	if (nil == vsh) then
		vertSource = "\n".."\n" ..
		"attribute vec4 a_position;\n" ..
        "attribute vec2 a_texCoord;\n" ..
        "attribute vec4 a_color;\n\n" ..
        "\n#ifdef GL_ES\n" .. 
        "varying lowp vec4 v_fragmentColor;\n" ..
        "varying mediump vec2 v_texCoord;\n" ..
        "\n#else\n" ..
        "varying vec4 v_fragmentColor;" ..
        "varying vec2 v_texCoord;" ..
        "\n#endif\n" ..
        "void main()\n" ..
        "{\n" .. 
        "   gl_Position = CC_MVPMatrix * a_position;\n"..
        "   v_fragmentColor = a_color;\n"..
        "   v_texCoord = a_texCoord;\n" ..
        "} \n";
    else
        vertSource = fileUtiles:getStringFromFile(vsh);
    end

    local fragSource = nil;
    if (nil == fsh) then

    else
    	fragSource = fileUtiles:getStringFromFile(fsh);
    end

    local glProgam = cc.GLProgram:createWithByteArrays(vertSource, fragSource);
    local glprogramstate = cc.GLProgramState:getOrCreateWithGLProgram(glProgam);
    return glprogramstate;
end

function shader:getRenderSprite(node)
    if (nil ~= node.getSpriteFrame) then
        return node;
    else
        if (nil == node) then
            return nil;
        end
        
        if (nil == node.getVirtualRenderer) then
            return nil;
        end

        local virtualRender = node:getVirtualRenderer();
        if (nil == virtualRender.getSprite) then
            return nil;
        end

        local sprite = virtualRender:getSprite();
        if (nil == sprite) then
            return nil;
        end
        return sprite;
    end
end

function shader:removeShader(node)
    if (node) then
        local sprite = self:getRenderSprite(node);
        if (sprite) then
            local glProgram = cc.GLProgramCache:getInstance():getGLProgram("ShaderPositionTextureColor_noMVP");
            sprite:setGLProgram(glProgram);
        end
    end

    local chridren = node:getChildren();
    for i=1, #chridren do
        self:removeShader(chridren[i]);
    end
end

function shader:blur(node)
	local sprite = self:getRenderSprite(node);
	local glprogramstate = self:getGLProgam(nil, "shader/example_Blur.fsh");
	glprogramstate:setUniformVec2("resolution", cc.p(64, 64));
	glprogramstate:setUniformFloat("blurRadius", 2);
    glprogramstate:setUniformFloat("sampleNum", 1);
	sprite:setGLProgramState(glprogramstate);
end

function shader:color(node, c)
	local sprite = self:getRenderSprite(node);
    if (sprite) then
        local glprogramstate = self:getGLProgam("shader/gray.vsh", "shader/gray.fsh");
        glprogramstate:setUniformFloat("red", c.r);
        glprogramstate:setUniformFloat("green", c.g);
        glprogramstate:setUniformFloat("blue", c.b);
        sprite:setGLProgramState(glprogramstate);
    end

    local chridren = node:getChildren();
    for i=1, #chridren do
        self:color(chridren[i], c);
    end
end

return shader;