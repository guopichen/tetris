
local FSMStateCtrl = class( "FSMStateCtrl" )

function FSMStateCtrl:ctor()
	self.states = {}
end

function FSMStateCtrl:registState( stateName, state )
	-- state:onEnter()
	self.states[stateName] = state
end

function FSMStateCtrl:getCurStateName()
	return self.curStateName
end

function FSMStateCtrl:gotoState( stateName )
	-- print("gotoState: "..stateName)
	if not self.states[stateName] then return end
	if self.curState then self.curState:onExit() end
	self.curStateName = stateName
	self.curState = self.states[stateName]
	self.curState:onEnter()
	self.curState:onExecute()
end

return FSMStateCtrl