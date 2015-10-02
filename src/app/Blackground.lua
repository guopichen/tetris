


local Blackground = class( "Blackground" )

local N = 4

-- 初始化背景为: 0
function Blackground:ctor( row, col )
	print("---this is Blackground:ctor----")
	self.row = row
	self.col = col
	self.m = {}
	for i=1,row do
		self.m[i] = {}
		for j=1,col do
			self.m[i][j] = 0
		end
	end
end


function Blackground:copyValue( cube, curCol, curRow )
	local maxCol = curCol+N>self.col and self.col or curCol+N
	local maxRow = curRow+N>self.row and self.row or curCol+N
	for i=minRow,maxRow do
		for j=minCol,maxCol do
			self.m[i][j] = cube[i][j]
		end
	end
end


function Blackground:left(cube, curRow, curCol)
	local backCol = curCol - 1
	if backCol<1 then return false end
	local maxRow = curRow+N>row and curRow or curRow+N
	for i=curRow,maxRow do
		if self.m[i][backCol] == 1 and cube[i-curRow][1]==1 then
			return false 
		end
	end
	self:copyValue(cube,curCol,curRow)
	return true
end

function Blackground:right(cube, curRow, curCol)
	local backCol = curCol - 1
	if backCol<1 then return false end
	local maxRow = curRow+N>row and curRow or curRow+N
	for i=curRow,maxRow do
		if self.m[i][backCol] == 1 and cube[i-curRow][N]==1 then
			return false 
		end
	end
	self:copyValue(cube,curCol,curRow)
	return true
end

function Blackground:down( cube, curRow, curCol )
	local backRow = curRow + 1
	if not backRow<totalRow then return false end -- 到底了
	local maxCol = curCol+N>col and col or curCol+N
	for j=curCol,maxCol do -- 只需判断和cube重叠的部分
		if self.m[backRow][j] == 1 and cube[N][j-curCol]==1 then -- 背景块和对应的cube块都为
			-- 
			self:checkDisapear()
			if #self.disapearLines > 1 then -- 有消除的行
				self:runDisapearEffect()
			else
				local stateName = self:isOver() and 'StateGameOver' or 'StateCubeStandby'
				game.FSMStateCtrl:gotoState(stateName)
			end
			return false
		end
	end
	self:copyValue(cube,curCol,curRow)
	return true
end

function Blackground:initBackRect( startPosX, startPosY )
	self.startPosX = startPosX
	self.startPosY = startPosY
end

function Blackground:isOver()
	
end

function Blackground:runDisapearEffect()
	-- body
end

-- 根据数据, 重绘
function Blackground:draw()



	
end

--[[ 
	检测消除
	由下往上, 由左往右, 依次检测
	if 此行全为1 then
		此行以上的所有行,全部下移一行(此行被覆盖,即被消除)
	end
--]]
function Blackground:checkDisapear()
	self.disapearLines = {}
	for r=self.row,1,-1 do
		local flag = true -- 消除标记
		for c=1,self.col do
			if 0 == self.m[r][c] then
				flag = false
				break
			end
		if flag then -- 消除此行(即:此行以上的所有行,全部下移一行,本行被覆盖)
			for i=self.row,2,-1 do
				for j=1,self.col do
					self.m[i][j] = self.m[i-1][j]
					self.disapearLines[i] = true -- 记录消除行
				end
			end
			-- 第一行全置为0
			for j=1,self.col do
					self.m[1][j] = 0
			end
		end
		end
	end
end


return Blackground


