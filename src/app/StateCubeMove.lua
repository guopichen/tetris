
local StateCubeMove = class( "StateCubeMove" )

function StateCubeMove:ctor()
end

function StateCubeMove:onEnter()
    print("----this is StateCubeMove:onEnter---")
	-- 开始计时, 2秒下落一次
	local scheduler = cc.Director:getInstance():getScheduler()
    if self.schedulerUpdate ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerUpdate)
    end
    self.schedulerUpdate = scheduler:scheduleScriptFunc(function( delta )
        game.blackground:down(game.curCube.cube,game.curCube.row,game.curCube.col)
        cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new('repaint'))
    end,  2, false)
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
