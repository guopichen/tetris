
local StateCheckDisapear = class( "StateCheckDisapear" )

function StateCheckDisapear:ctor()
	print("this is StateCheckDisapear:ctor")
end

function StateCheckDisapear:onEnter()
	print("this is StateCheckDisapear:onEnter")
end

function StateCheckDisapear:onExit()
	if game.blackground:checkDisapear() then
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new('repaint'))
	end
end

function StateCheckDisapear:onExecute()
end

return StateCheckDisapear