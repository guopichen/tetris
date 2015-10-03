
local MoveMsgCtrl = class( "MoveMsgCtrl" )

function MoveMsgCtrl:ctor()
end

function MoveMsgCtrl:onMoveMsg( event )
	print(event)
	if game.FSMStateCtrl:getCurStateName() ~= 'StateCubeMove' then return end
	if event == 'left' then
		if game.blackground:left(game.curCube.cube,game.curCube.row,game.curCube.col) then
			game.curCube.col = curCube.col - 1
		end
	elseif event == 'right' then
		if game.blackground:right(game.curCube.cube,game.curCube.row,game.curCube.col) then
			game.curCube.col = curCube.col + 1
		end
	elseif event == 'down' then
		if game.blackground:down(game.curCube.cube,game.curCube.row,game.curCube.col) then
			game.curCube.row = game.curCube.row + 1
		end
	elseif event == 'rotate' then
		game.curCube.row = game.curCube.row + 1
	end
    game.blackground:draw()
end


return MoveMsgCtrl