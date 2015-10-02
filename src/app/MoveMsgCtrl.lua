
local MoveMsgCtrl = class( "MoveMsgCtrl" )

function MoveMsgCtrl:ctor()
end

function MoveMsgCtrl:onMoveMsg( event )
	print(event)
	if game.FSMStateCtrl:getCurStateName() ~= 'StateCubeMove' then return end
	if event == 'left' then
		game.blackground:left(game.curCube.cube,game.curCube.row,game.curCube.col)
	elseif event == 'right' then
		game.blackground:right(game.curCube.cube,game.curCube.row,game.curCube.col)
	elseif event == 'down' then
		game.blackground:down(game.curCube.cube,game.curCube.row,game.curCube.col)
	end
	game.curCube.cube:draw()
    game.blackground:draw()
end


return MoveMsgCtrl