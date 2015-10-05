-- 5种方块的定义以及旋转函数的实现

local Cube = class( "Cube" )

local matrixSize = 4
local t = 
{
	[1] =
		{
			{
				{1,0,0,0},
				{1,0,0,0},
				{1,0,0,0},
				{1,0,0,0},
			},
			{
				{1,1,1,1},
				{0,0,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,0,0,0},
				{1,0,0,0},
				{1,0,0,0},
				{1,0,0,0},
			},
			{
				{1,1,1,1},
				{0,0,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
		},

	[2] = 
		{
			{
				{1,1,1,0},
				{0,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,0,0,0},
				{1,1,0,0},
				{1,0,0,0},
				{0,0,0,0},
			},
			{
				{0,1,0,0},
				{1,1,1,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{0,1,0,0},
				{1,1,0,0},
				{0,1,0,0},
				{0,0,0,0},
			},
		},
	[3] = 
		{
			{
				{1,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
		},
	[4] = 
		{
			{
				{1,1,0,0},
				{0,1,0,0},
				{0,1,0,0},
				{0,0,0,0},
			},
			{
				{1,1,1,0},
				{1,0,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,0,0,0},
				{1,0,0,0},
				{1,1,0,0},
				{0,0,0,0},
			},
			{
				{0,0,1,0},
				{1,1,1,0},
				{0,0,0,0},
				{0,0,0,0},
			},
		},

	[5] = 
		{
			{
				{1,1,0,0},
				{1,0,0,0},
				{1,0,0,0},
				{0,0,0,0},
			},
			{
				{1,0,0,0},
				{1,1,1,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{0,1,0,0},
				{0,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
			},
			{
				{1,1,1,0},
				{0,0,1,0},
				{0,0,0,0},
				{0,0,0,0},
			},
		},

	[6] = 
		{
			{
				{1,0,0,0},
				{1,1,0,0},
				{0,1,0,0},
				{0,0,0,0},
			},
			{
				{0,1,1,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{1,0,0,0},
				{1,1,0,0},
				{0,1,0,0},
				{0,0,0,0},
			},
			{
				{0,1,1,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
		},

	[7] = 
		{
			{
				{0,1,0,0},
				{1,1,0,0},
				{1,0,0,0},
				{0,0,0,0},
			},
			{
				{1,1,0,0},
				{0,1,1,0},
				{0,0,0,0},
				{0,0,0,0},
			},
			{
				{0,1,0,0},
				{1,1,0,0},
				{1,0,0,0},
				{0,0,0,0},
			},
			{
				{1,1,0,0},
				{0,1,1,0},
				{0,0,0,0},
				{0,0,0,0},
			},
		},
}

function Cube:ctor( cubeType )
	-- print('---Cube:ctor---')
	if not cubeType then return end
	-- print(t[1][1])
	self.cubeType = cubeType
	self:setShape(1)
	-- 所在位置(矩阵的第一行第一列为标准)
	self.curRow = 1
	self.curCol = 1
	--
end

-- 获取方块的三个方向的边界值所在背景中的位置(右边界值:在方块矩阵的列中,有值为1的最右边的一列)
function Cube:getBoundary( dir )
	if dir == 'left' then
		return self.curCol
	elseif dir == 'right' then
		return self.curCol + self.rBoundary - 1
	elseif dir == 'bottom' then
		return self.curRow + self.bBoundary - 1
	end
	return 0
end

function Cube:move( dir, blackgroundRow, blackgroundCol )
	if dir == 'left' then
		self.curCol = self.curCol - 1
	elseif dir == 'right' then
		self.curCol = self.curCol + 1
	elseif dir == 'down' then
		self.curRow = self.curRow + 1
	end
	-- print("curCube row: "..self.curRow.." col:"..self.curCol)
end

function Cube:getPos( row, col )
	return self.curRow,self.curCol
end

function Cube:setPos( row, col )
	self.curRow = row
	self.curCol = col
end

-- 获取在对应的背景的行列
function Cube:getBlackgourdPos(row, col)
	-- print("curCube row: "..self.curRow.." col:"..self.curCol)
	return self.curRow+row-1,self.curCol+col-1
end

function Cube:getCurRow()
	return self.curRow
end

function Cube:getCurCol()
	return self.curCol
end

function Cube:getMatrix(  )
	return self.matrix
end

function Cube:getMatrixSize(  )
	return matrixSize
end

function Cube:getShape()
	return self.curShape
end

function Cube:setType( type )
	self.cubeType = type
end

function Cube:getType()
	return self.cubeType
end

function Cube:setShape( shape )
	self.curShape = shape
	self.matrix = t[self.cubeType][shape]
	self:updateMatrix()
end

-- dir>0: 顺时针90°,   dir<0:逆时针90°
function Cube:rotate( dir )
	self.curShape = self.curShape + 1
	if self.curShape > matrixSize then self.curShape = 1 end
	self.matrix = t[self.cubeType][self.curShape]
	--
	self:updateMatrix()
end

function Cube:updateMatrix()
	local flag = false
	--
	for r=matrixSize,1,-1 do
		for c=1,matrixSize do
			if self.matrix[r][c] == 1 then
				self.bBoundary = r
				-- print('bBoundary: '..self.bBoundary)
				flag = true
				break
			end
		end
		if flag  then break end
	end

	--
	flag = false
	for c=matrixSize,1,-1 do
		for r=1,matrixSize do
			if self.matrix[r][c] == 1 then
				self.rBoundary = c
				-- print('rBoundary: '..self.rBoundary)
				flag = true
				break
			end
		end
		if flag  then break end
	end 
end


return Cube




