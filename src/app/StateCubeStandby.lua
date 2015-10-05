
local StateCubeStandby = class( "StateCubeStandby" )

function StateCubeStandby:ctor()
	print("this is StateCubeStandby:ctor")
	self:createNextCube()
end

function StateCubeStandby:createNextCube()
	math.randomseed(os.time())
	game.nextCube = require('app.Cube'):create(math.random(1,7))
	game.nextCube:setPos(1,6)
end


function StateCubeStandby:onEnter()
	print("this is StateCubeStandby:onEnter")
	--
	game.curCube = game.nextCube
	self:createNextCube()
	-- 开始计时: 两秒后进入cubemove的状态
	local scheduler = cc.Director:getInstance():getScheduler()
    if self.schedulerUpdate ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerUpdate)
    end
    self.schedulerUpdate = scheduler:scheduleScriptFunc(function( delta )
        game.FSMStateCtrl:gotoState('StateCubeMove')
    end,  0.1, false)
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