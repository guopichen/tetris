
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
    
end

-- function PlayScene:onCreate()
--     -- create game view and add it to stage
--     self.gameView_ = GameView:create()
--         :addEventListener(GameView.events.PLAYER_DEAD_EVENT, handler(self, self.onPlayerDead))
--         :start()
--         :addTo(self)
-- end

-- function PlayScene:onPlayerDead(event)
--     -- add game over text
--     local text = string.format("You killed %d bugs", self.gameView_:getKills())
--     cc.Label:createWithSystemFont(text, "Arial", 96)
--         :align(display.CENTER, display.center)
--         :addTo(self)

--     -- add exit button
--     local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
--         :onClicked(function()
--             self:getApp():enterScene("MainScene")
--         end)
--     cc.Menu:create(exitButton)
--         :move(display.cx, display.cy - 200)
--         :addTo(self)
-- end

return PlayScene
