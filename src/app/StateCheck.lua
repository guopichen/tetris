
local StateCheck = class( "StateCheck" )

function StateCheck:ctor()
	-- print("this is StateCheck:ctor")
end

function StateCheck:onEnter()
	-- print("this is StateCheck:onEnter")
	-- 赋值
	game.blackground:copyCubeToBlackground(game.curCube)
	-- 消除
	if game.blackground:checkDisapear() then
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new('repaint'))
	end
	if game.blackground:checkOver(game.curCube) then
		game.FSMStateCtrl:gotoState('StateGameOver')
		return
	end
	game.FSMStateCtrl:gotoState('StateCubeMove')
end

function StateCheck:onExit()
end

function StateCheck:onExecute()
end

return StateCheck