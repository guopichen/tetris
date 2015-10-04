-- 5种方块的定义以及旋转函数的实现

local Cube = class( "Cube" )

local t = 
{
	[1] = 
			{
				{1,0,0,0},
				{1,0,0,0},
				{1,0,0,0},
				{1,0,0,0},
			},
	[2] = 
			{
				{1,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
	[3] = 
			{
				{1,0,0,0},
				{1,1,0,0},
				{0,1,0,0},
				{0,0,0,0},
			},
	[4] = 
			{
				{1,1,0,0},
				{0,1,0,0},
				{0,1,0,0},
				{0,0,0,0},
			},
	[5] = 
			{
				{1,1,1,0},
				{0,1,0,0},
				{0,0,0,0},
				{0,0,0,0},
			},
	
}

function Cube:ctor( cubeType )
	print('---Cube:ctor---')
	if not cubeType then return end
	self.m = t[cubeType]
	self:updateMatrix()
end

function Cube:updateMatrix()
	local N = 4
	local flag = false
	--
	local bottomRow = 1
	for r=N,1,-1 do
		for c=1,N do
			-- print(r)
			if self.m[r][c] == 1 then
				self.bottomRow = r
				print('bottomRow: '..self.bottomRow)
				flag = true
				break
			end
		end
		if flag  then break end
	end

	--
	flag = false
	local leftCol = 1
	for c=1,N do
		for r=1,4 do
			if self.m[r][c] == 1 then
				self.leftCol = c
				print('leftCol: '..self.leftCol)
				flag = true
				break
			end
		end
		if flag  then break end
	end
	--
	flag = false
	local rightCol = 1
	for c=N,1,-1 do
		for r=1,4 do
			if self.m[r][c] == 1 then
				self.rightCol = c
				print('rightCol: '..self.rightCol)
				flag = true
				break
			end
		end
		if flag  then break end
	end
end


-- dir>0: 顺时针90°,   dir<0:逆时针90°
function Cube:rotate( dir )
	-- if not dir then return end
	local N = 4
	-- copy to m
	local m = { {},{},{},{}, }
	for i=1,N do
		for j=1,N do
			m[i][j] = self.m[i][j]
		end
	end

	-- 从左到右, 找到值为1的列, 然后整体左移
	-- local flag = false
	-- local col = 1
	-- for c=1,N do
	-- 	for r=1,N do
	-- 		if m[r][c] == 1 then
	-- 			col = c
	-- 			flag = true
	-- 			break
	-- 		end
	-- 	end
	-- 	if flag then break end
	-- end
	-- if col > 1 then -- 左移
	-- 	for c=1,col do
	-- 		for r=1,N do
	-- 			m[r][c] = m[r][c+1]
	-- 		end
	-- 	end
	-- 	--
	-- 	for c=col+1,N do
	-- 		for r=1,N do
	-- 			m[r][c] = 0
	-- 		end
	-- 	end
	-- end
	
	-- 从下往上, 找到值为1的列, 然后整体上移
	-- flag = false
	-- local row = N
	-- for r=N,1,-1 do
	-- 	for c=1,N do
	-- 		if m[r][c] == 1 then
	-- 			row = c
	-- 			flag = true
	-- 			break
	-- 		end
	-- 	end
	-- 	if flag then break end
	-- end
	-- if row > 1 then -- 上移
	-- 	for r=1,row-1 do
	-- 		for c=1,N do
	-- 			m[r][c] = m[r+1][c]
	-- 		end
	-- 	end
	-- 	--
	-- 	for r=row+1,N do
	-- 		for c=1,N do
	-- 			m[r][c] = 0
	-- 		end
	-- 	end
	-- end

	-- rotate self.m
	
	for i=1,N do
		for j=1,N do
			self.m[i][j] = m[j][N+1-i]
		end
	end

	self:updateMatrix()
end

return Cube




