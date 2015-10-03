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
	self:updateBottomRow()
end

function Cube:updateBottomRow()
	local bottomRow = 1
	for r=4,1,-1 do
		for c=1,4 do
			-- print(r)
			if self.m[r][c] == 1 then
				self.bottomRow = r
				print('bottomRow: '..self.bottomRow)
				return
			end
		end
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
	-- rotate self.m
	
	for i=1,N do
		for j=1,N do
			self.m[i][j] = m[j][N+1-i]
		end
	end

	self:updateBottomRow()
end

return Cube




