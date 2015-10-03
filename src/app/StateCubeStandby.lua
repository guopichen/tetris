
local StateCubeStandby = class( "StateCubeStandby" )

function StateCubeStandby:ctor()
	print("this is StateCubeStandby:ctor")
end

function StateCubeStandby:onEnter()
	print("this is StateCubeStandby:onEnter")
	-- 随机一个方块
	math.randomseed(os.time())
	game.curCube = {}
	game.curCube.cube = require('app.Cube'):create(3)--
	game.curCube.row = 0
	game.curCube.col = 0
	-- 开始计时: 两秒后进入cubemove的状态
	local scheduler = cc.Director:getInstance():getScheduler()
    if self.schedulerUpdate ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerUpdate)
    end
    self.schedulerUpdate = scheduler:scheduleScriptFunc(function( delta )
        game.FSMStateCtrl:gotoState('StateCubeMove')
    end,  2, false)
end

function StateCubeStandby:onExit()
	local scheduler = cc.Director:getInstance():getScheduler()
    if self.schedulerUpdate ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerUpdate)
    end
end

function StateCubeStandby:onExecute()
end

return StateCubeStandby