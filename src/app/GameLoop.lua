

--[[
 方块可移动的状态
--]]

local function moveDown()
	if not cubeMove.down() then
		if checkGameOver() then
			pushStage('over')
		end
	end
end

local function onMoveMsg( dir )
	if dir == 'left' then
		cubeMove.left()
	elseif dir == 'right' then
		cubeMove.right()
	elseif dir == 'down' then
		moveDown()
	end
end


--[[
 gameOver状态
--]]

--[[
 方块不可移动的状态
--]]


-- while( not gameOver )
-- {
-- 	随机一个方块;
-- 	if ( 检测下移 )
-- 	{
-- 		下移
-- 	}	
-- }

-- if ( moveMsg )
-- {
-- 	if ( canMove() )
-- 		move()
-- }