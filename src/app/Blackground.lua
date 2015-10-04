


local Blackground = class( "Blackground" )

local N = 4

-- 初始化背景为: 0
function Blackground:ctor( row, col )
	print("---this is Blackground:ctor----")
	print("row is: "..row.." col is: "..col)
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
	-- print("----this is Blackground:copyValue----")

	-- print("curCol: "..curCol.." curRow: "..curRow)


	-- --
	for r=1,N do
		for c=1,N do
			if cube.m[r][c] == 1 then
				local col = curCol+c-1
				local row = curRow+r-1
				-- if not(col>self.col) and not(row>self.row) then
				-- print("row: "..row.." col: "..col.." r: "..r.." c: "..c)
				self.m[row][col] = cube.m[r][c]
				-- end
			end
		end
	end
end

function Blackground:down( cube, curRow, curCol )
	local lastRow = curRow+cube.bottomRow-1
	print('lastRow: '..lastRow)
	if not(lastRow<self.row) then
		self:copyValue(cube,curCol,curRow)
		return false -- 到底了
	end
	--
	-- local nextRow = lastRow + 1
	for r=cube.bottomRow,1,-1 do
		for c=1,N do
			if cube.m[r][c] == 1 and self.m[curRow+r][curCol+c-1] == 1 then
				self:copyValue(cube,curCol,curRow)
				return false
			end
		end
	end

	return true
end

function Blackground:left(cube, curRow, curCol)
	local leftCol = curCol+cube.leftCol-1
	if not(leftCol>1) then
		return false -- 到边了
	end
	--
	for c=cube.leftCol,N do
		for r=1,N do 
			if cube.m[r][c] == 1 and self.m[curRow+r-1][curCol+c-2] == 1 then
				return false
			end
		end
	end
	return true
end

function Blackground:right(cube, curRow, curCol)
	local rightCol = curCol+cube.rightCol-1
	if not(rightCol<self.col) then
		return false -- 到边了
	end
	--
	for c=cube.rightCol,1,-1 do
		for r=1,N do 
			if cube.m[r][c] == 1 and self.m[curRow+r-1][curCol+c] == 1 then
				return false
			end
		end
	end
	return true
end

function Blackground:initBackRect( startPosX, startPosY )
	self.startPosX = startPosX
	self.startPosY = startPosY
end

function Blackground:isOver()
	return false
end

function Blackground:runDisapearEffect()
	-- body
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


