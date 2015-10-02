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
				{1,1,0,0},
				{1,1,0,0},
				{0,0,0,0},
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
	if not cubeType then return end
	self.m = t[cubeType]
end

-- 根据数据, 重绘
function Cube:draw()
end

-- dir>0: 顺时针90°,   dir<0:逆时针90°
function Cube:rotate( t, dir )
	-- if not dir then return end

	-- copy to m
	local m = { {},{},{},{}, }
	for i=1,N do
		for j=1,N do
			m[i][j] = self.m[i][j]
		end
	end
	-- rotate self.m
	local N = 4
	for i=1,N do
		for j=1,N do
			self.m[i][j] = m[j][N+1-i]
		end
	end
end

return Cube




