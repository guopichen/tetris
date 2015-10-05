
local MoveMsgCtrl = class( "MoveMsgCtrl" )

function MoveMsgCtrl:ctor()
end

function MoveMsgCtrl:onMoveMsg( event )
	-- print(event)
	if game.FSMStateCtrl:getCurStateName() ~= 'StateCubeMove' then return end
	if event == 'left' then
		if game.blackground:canLeft(game.curCube) then
			game.curCube:move('left')
		end
	elseif event == 'right' then
		if game.blackground:canRight(game.curCube) then
			game.curCube:move('right')
		end
	elseif event == 'down' then
		if game.blackground:canDown(game.curCube) then
			game.curCube:move('down')
		end
	elseif event == 'rotate' then
		game.curCube:rotate()
	end
    cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new('repaint'))
end


return MoveMsgCtrl