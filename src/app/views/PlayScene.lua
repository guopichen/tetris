
local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

local GameView = import(".GameView")

function PlayScene:onCreate()
    print("---this is PlayScene:onCreate----")
	game.FSMStateCtrl:gotoState('StateCubeStandby')

    local function leftTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('left')
        end
    end
    local leftButton = ccui.Button:create('PlayButton.png')
    leftButton:setTouchEnabled(true)
    leftButton:addTouchEventListener(leftTouchEvent)
    self:addChild( leftButton)
    leftButton:setPosition(display.cx-200, display.cy)

    local function rightTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('right')
        end
    end
    local rightButton = ccui.Button:create('PlayButton.png')
    rightButton:setTouchEnabled(true)
    rightButton:addTouchEventListener(rightTouchEvent)
    self:addChild( rightButton)
    rightButton:setPosition(display.cx+200, display.cy)

    local function downTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('down')
        end
    end
    local downButton = ccui.Button:create('PlayButton.png')
    downButton:setTouchEnabled(true)
    downButton:addTouchEventListener(downTouchEvent)
    self:addChild( downButton)
    downButton:setPosition(display.cx, display.cy-200)
    
    --
    local cubes = cc.Node:create()
    cubes:setName('cubes')
    display.getRunningScene():addChild(cubes)

    -- 背景框
    local drawNode = cc.DrawNode:create()
    local startPos = cc.p(100,100)
    local endPos = cc.p(startPos.x+300,startPos.y+500)
    drawNode:drawRect(startPos,endPos,cc.c4f(1,0,0,1))
    self:addChild(drawNode)
end

function PlayScene:initCubes()
    for i=1,game.blackground.row do
        for j=1,game.blackground.col do
            --
            local sp = cc.Spirte:create("cube.png")
            sp:setName(i..j)
            local cubeSize = sp:getContentSize().width + 2
            local posX = self.startPosX + (i-1)*cubeSize
            local posY = self.startPosY + (j-1)*cubeSize
            sp:setPosition(cc.p(posX,posY))
            sp:setVisible(false)
            node:addChild(sp)
        end
    end
end

function PlayScene:draw()
    local matrix = game.blackground.m
    -- clear cubes
    local node = display.getRunningScene():getChilidByName('cubes')
    node:removeAllChildrenWithCleanup(true)
    for i=1,self.row do
        for j=1,self.col do
            local sp = node:getChildByName(i..j)
            sp:setVisible(matrix[i][j] == 1 and true or false)
        end
    end
end



return PlayScene
