
local StateCubeMove = class( "StateCubeMove" )

function StateCubeMove:ctor()
    self:createNextCube()
end

function StateCubeMove:createNextCube()
    math.randomseed(os.time())
    game.nextCube = require('app.Cube'):create(math.random(1,7))
    game.nextCube:setPos(1,6)
end

function StateCubeMove:onEnter()
    print("----this is StateCubeMove:onEnter---")
    game.curCube = game.nextCube
    self:createNextCube()
    cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new('repaint'))
	-- 开始计时, 2秒下落一次
	local scheduler = cc.Director:getInstance():getScheduler()
    if self.schedulerUpdate ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerUpdate)
    end
    self.schedulerUpdate = scheduler:scheduleScriptFunc(function( delta )
        if game.blackground:canDown(game.curCube) then 
            game.curCube:move('down')
            cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new('repaint'))
        else
            game.FSMStateCtrl:gotoState('StateCheck')
        end
        
    end,  1, false)
end

function StateCubeMove:onExit()
	local scheduler = cc.Director:getInstance():getScheduler()
    if self.schedulerUpdate ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerUpdate)
    end
end

function StateCubeMove:onExecute()
end

return StateCubeMove
