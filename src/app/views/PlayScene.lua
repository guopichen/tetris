
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
    leftButton:setPosition(display.cx+100, display.cy)

    local function rightTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('right')
        end
    end
    local rightButton = ccui.Button:create('PlayButton.png')
    rightButton:setTouchEnabled(true)
    rightButton:addTouchEventListener(rightTouchEvent)
    self:addChild( rightButton)
    rightButton:setPosition(display.cx+300, display.cy)

    local function downTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('down')
        end
    end
    local downButton = ccui.Button:create('PlayButton.png')
    downButton:setTouchEnabled(true)
    downButton:addTouchEventListener(downTouchEvent)
    self:addChild( downButton)
    downButton:setPosition(display.cx+200, display.cy-200)


    local function ratoteTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('rotate')
        end
    end
    local rotateButton = ccui.Button:create('PlayButton.png')
    rotateButton:setTouchEnabled(true)
    rotateButton:addTouchEventListener(ratoteTouchEvent)
    self:addChild( rotateButton)
    rotateButton:setPosition(display.cx+200, display.cy+200)
    
    --
    self.cubeNodes = cc.Node:create()
    self.cubeNodes:setName('cubes')
    self:addChild(self.cubeNodes,2)

    -- 背景框
    self.w = 300
    self.h = 500
    local drawNode = cc.DrawNode:create()
    self.startPos = cc.p(100,100)
    local endPos = cc.p(self.startPos.x+self.w,self.startPos.y+self.h)
    drawNode:drawRect(self.startPos,endPos,cc.c4f(0,1,0,1))
    self:addChild(drawNode)
    --
    self:initCubes()

    --
    self.repaintListener  = cc.EventListenerCustom:create( 'repaint', function( event)
        self:draw()
    end)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(self.repaintListener,1)
end



function PlayScene:initCubes()
    local cubeSize = 23
    local space = 2
    local N = game.blackground.row
    for i=1,game.blackground.row do
        for j=1,game.blackground.col do
            local drawNode = cc.DrawNode:create()
            local startPos = cc.p(self.startPos.x+(j-1)*(cubeSize+space),self.startPos.y+(N-i)*(cubeSize+space))
            -- startPos.y = self.startPos.y
            drawNode:drawSolidRect(startPos,cc.p(startPos.x+cubeSize,startPos.y+cubeSize),cc.c4f(1,0,0,1))
            drawNode:setVisible(false)
            drawNode:setName(i..'*'..j)
            self.cubeNodes:addChild(drawNode)
        end
    end
end

-- 需要先渲染背景, 再渲染方块
function PlayScene:draw()
    local N=4
    local matrix = game.blackground.m
    for i=1,game.blackground.row do
        for j=1,game.blackground.col do
            local sp = self.cubeNodes:getChildByName(i..'*'..j)
            sp:setVisible(matrix[i][j] == 1 and true or false)
        end
    end
    
    for r=1,N do
        for c=1,N do
            local i = game.curCube.row+r-1
            local j= game.curCube.col+c-1
            -- print('')
            -- print(" i: "..i.." j: "..j.." curCol: "..game.curCube.col)
            -- print('')

            if not(i>game.row) and not(j>game.col) then
                local sp = self.cubeNodes:getChildByName(i..'*'..j)
                if game.curCube.cube.m[r][c] == 1 then
                    sp:setVisible(true)
                end
            end
        end
    end
    

    -- print("-----draw------")

end

-- cc.Director:getInstance():getEventDispatcher():removeEventListener(self.repaintListener)

return PlayScene
