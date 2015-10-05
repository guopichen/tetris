
local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

local GameView = import(".GameView")

function PlayScene:onCreate()
    -- print("---this is PlayScene:onCreate----")
	game.FSMStateCtrl:gotoState('StateCubeMove')

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


    local function moveToBottomTouchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            game.MoveMsgCtrl:onMoveMsg('moveToBottom')
        end
    end
    local moveToBottomButton = ccui.Button:create('Star.png')
    moveToBottomButton:setTouchEnabled(true)
    moveToBottomButton:addTouchEventListener(moveToBottomTouchEvent)
    self:addChild( moveToBottomButton)
    moveToBottomButton:setPosition(display.cx+400, display.cy-200)


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
    -- next
    self.nextCubeNode = cc.Node:create()
    self:addChild(self.nextCubeNode,2)



    --
    self:initDraw()

    --
    self.repaintListener  = cc.EventListenerCustom:create( 'repaint', function( event)
        self:draw()
    end)
    cc.Director:getInstance():getEventDispatcher():addEventListenerWithFixedPriority(self.repaintListener,1)
end


function PlayScene:initDraw()
    local cubeSize = 23
    local space = 2
    local startPos = cc.p(100,20)
    local totalRow, totalCol = game.blackground:getSize()

    -- 方块
    for r=1,totalRow do
        for c=1,totalCol do
            local drawNode = cc.DrawNode:create()
            local pos = cc.p(startPos.x+(c-1)*(cubeSize+space),startPos.y+(totalRow-r)*(cubeSize+space))
            
            local endPos = cc.p(pos.x+cubeSize,pos.y+cubeSize)
            drawNode:drawSolidRect(pos,endPos, cc.c4f(1,0,0,1))
            drawNode:setVisible(false)
            drawNode:setName(r..'*'..c)
            self.cubeNodes:addChild(drawNode)
        end
    end

    -- next cube
    local nextStartPos = cc.p(startPos.x-50,startPos.y)--cc.p(startPos.x+100,startPos.y+300)
    local matrixSize = 4
    for r=1,matrixSize do
        for c=1,matrixSize do
            local drawNode = cc.DrawNode:create()
            local pos = cc.p(nextStartPos.x+(c-1)*(cubeSize+space),nextStartPos.y+(cubeSize-r)*(cubeSize+space))
            local endPos = cc.p(pos.x+cubeSize,pos.y+cubeSize)
            drawNode:drawSolidRect(pos,endPos, cc.c4f(1,0,0,1))
            drawNode:setVisible(false)
            drawNode:setName(r..'*'..c)
            self.nextCubeNode:addChild(drawNode)

        end
    end
    -- test
    -- self.nextCubeNode:getChildByName('1*1'):setVisible(false)

    -- 背景框
    local drawNode = cc.DrawNode:create()
    local endPos = cc.p(startPos.x+cubeSize*totalCol+space*(totalCol-1),
                        startPos.y+cubeSize*totalRow+space*(totalRow-1))
    drawNode:drawRect(startPos,endPos,cc.c4f(0,1,0,1))
    self:addChild(drawNode)


end

-- 需要先渲染背景, 再渲染方块
function PlayScene:draw()

    local totalRow, totalCol = game.blackground:getSize()
    local matrix = game.blackground:getMatrix()
    for r=1,totalRow do
        for c=1,totalCol do
            local sp = self.cubeNodes:getChildByName(r..'*'..c)
            sp:setVisible(matrix[r][c] == 1 and true or false)
        end
    end

    local matrixSize = game.curCube:getMatrixSize()
    -- cur cube
    local cubeMatrix = game.curCube:getMatrix()
    for r=1,matrixSize do
        for c=1,matrixSize do
            if cubeMatrix[r][c] == 1 then
                local i,j = game.curCube:getBlackgourdPos(r,c)
                -- print('i: '..i..' j: '..j)
                local sp = self.cubeNodes:getChildByName(i..'*'..j)
                sp:setVisible(true)
            end
        end
    end

    -- nextCube
    local nextMatrix = game.nextCube:getMatrix()
    for r=1,matrixSize do
        for c=1,matrixSize do
            local sp = self.nextCubeNode:getChildByName(r..'*'..c)
            sp:setVisible(nextMatrix[r][c] == 1 and true or false)
        end
    end

end

-- cc.Director:getInstance():getEventDispatcher():removeEventListener(self.repaintListener)

return PlayScene
