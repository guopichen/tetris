


local Blackground = class( "Blackground" )

local N = 4

-- row,col: 可操作区域的行列
function Blackground:ctor( row, col )
	-- print("---this is Blackground:ctor----")
	-- print("row is: "..row.." col is: "..col)
	-- 可操作区域
	self.row = row
	self.col = col
	self.matrix = {}
	for i=1,row do
		self.matrix[i] = {}
		for j=1,col do
			self.matrix[i][j] = 0
		end
	end
	-- test
	-- for j=1,col do
	-- 	self.matrix[self.row][j] = 1
	-- end
	
	self.rotateCube = require('app.Cube'):create(1)
end


function Blackground:getSize()
	return self.row,self.col
end

function Blackground:getMatrix()
	return self.matrix
end

function Blackground:copyCubeToBlackground( cube )
	-- --
	local matrixSize = cube:getMatrixSize()
	local cuebMatrix = cube:getMatrix()
	for r=1,matrixSize do
		for c=1,matrixSize do
			if cuebMatrix[r][c] == 1 then
				local row,col = cube:getBlackgourdPos(r,c)
				self.matrix[row][col] = 1
				-- print("row: "..row.." col: "..col.." r: "..r.." c: "..c)
			end
		end
	end
end

function Blackground:canRotate( cube )
	self.rotateCube:setType(cube:getType())
	self.rotateCube:setPos(cube:getPos())
	self.rotateCube:setShape(cube:getShape())
	--
	self.rotateCube:rotate()
	-- 
	local matrix = self.rotateCube:getMatrix()
	local matrixSize = self.rotateCube:getMatrixSize()
	for r=1,matrixSize do
		for c=1,matrixSize do
			if matrix[r][c] == 1 then
				local row,col = self.rotateCube:getBlackgourdPos(r,c)
				-- print('r: '..r..' c: '..c..' curCol: '..self.rotateCube:getCurCol()..' col: '..col)
				if row<1 or row>self.row or col<1 or col>self.col or self.matrix[row][col] == 1 then
					return false
				end
			end
		end
	end
	return true
end

function Blackground:canDown( cube )
	local cubeBounbary = cube:getBoundary('bottom')
	-- print('cubeBounbary: '..cubeBounbary)
	if not(cubeBounbary<self.row) then 
		game.blackground:copyCubeToBlackground(game.curCube)
		return false 
	end -- 到边了

	local matrix = cube:getMatrix()
	local matrixSize = cube:getMatrixSize()
	for r=matrixSize,1,-1 do
		for c=1,matrixSize do
			if matrix[r][c] == 1 then
				local row,col = cube:getBlackgourdPos(r,c)
				if self.matrix[row+1][col] == 1 then
					return false
				end
			end
		end
	end

	return true
end

function Blackground:canLeft(cube)
	local cubeBounbary = cube:getBoundary('left')
	if not(cubeBounbary>1) then return false end -- 到边了

	local matrix = cube:getMatrix()
	local matrixSize = cube:getMatrixSize()
	for c=1,matrixSize do
		for r=1,matrixSize do
			if matrix[r][c] == 1 then
				local row,col = cube:getBlackgourdPos(r,c)
				if self.matrix[row][col-1] == 1 then
					return false
				end
			end
		end
	end

	return true
end

function Blackground:canRight(cube)
	local cubeBounbary = cube:getBoundary('right')
	if not(cubeBounbary<self.col) then return false end -- 到边了

	local matrix = cube:getMatrix()
	local matrixSize = cube:getMatrixSize()
	for c=matrixSize,1,-1 do
		for r=1,matrixSize do
			if matrix[r][c] == 1 then
				local row,col = cube:getBlackgourdPos(r,c)
				if self.matrix[row][col+1] == 1 then
					return false
				end
			end
		end
	end

	return true

end

function Blackground:checkOver(cube)
	return cube:getCurRow()<2 and true or false
end


--[[ 
	检测消除
	由下往上, 由左往右, 依次检测
	if 此行全为1 then
		此行以上的所有行,全部下移一行(此行被覆盖,即被消除)
	end
--]]
function Blackground:checkDisapear()
	local rtn = false
	local disapear = true
	local testDumpFlag = true
	for r=1,self.row do
		for c=1,self.col do
			if self.matrix[r][c] == 0 then
				disapear = false
			end
		end
		if disapear then
			for c=1,self.col do
				if testDumpFlag then
					print('')
					print('消除之前')
					dump(self.matrix)
					testDumpFlag = nil
				end
				self.matrix[r][c] = 0 
			end
			rtn = true
		end
		disapear = true
	end

	-- print('xxxxxxx')
	-- print(rtn)
	if rtn then
		print('')
		print('下移之前')
		dump(self.matrix)
		local allZero = true -- 正行都是0
		for curRow=self.row,2,-1 do
			for col=1,self.col do
				if self.matrix[curRow][col] == 1 then
					allZero = false
					break
				end
			end
			if allZero then
				local zeroRow = curRow
				for r=zeroRow,2,-1 do -- 下移
					for c=1,self.col do
						self.matrix[r][c] = self.matrix[r-1][c]
					end
				end
			end
			allZero = true
		end
		print('')
		print('下移之后')
		dump(self.matrix)
	end

	return rtn
end


return Blackground


