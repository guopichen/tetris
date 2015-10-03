
local StateGameMenu= class( "StateGameMenu" )

function StateGameMenu:ctor()
end

function StateGameMenu:onEnter()
	print("this is StateGameMenu:onEnter")
end

function StateGameMenu:onExit()
	print("this is StateGameMenu:onExit")
end

function StateGameMenu:onExecute()
end

return StateGameMenu
