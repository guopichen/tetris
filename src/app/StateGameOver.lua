
local StateGameOver = class( "StateGameOver" )

function StateGameOver:ctor()
end

function StateGameOver:onEnter()
	print("this is StateGameMenu:onEnter")
end

function StateGameOver:onExit()
end

function StateGameOver:onExecute()
end

return StateGameOver
