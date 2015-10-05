
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

game = {}

require "config"
require "cocos.init"


local function gameInit()
	
	game = {}
	
	game.FSMStateCtrl = require('app.FSMStateCtrl'):create()
	game.FSMStateCtrl:registState( 'StateCubeMove', require('app.StateCubeMove'):create() )
	-- game.FSMStateCtrl:registState( 'StateCubeStandby', require('app.StateCubeStandby'):create() )
	game.FSMStateCtrl:registState( 'StateGameMenu', require('app.StateGameMenu'):create() )
	game.FSMStateCtrl:registState( 'StateGameOver', require('app.StateGameOver'):create() )
	game.FSMStateCtrl:registState( 'StateCheck', require('app.StateCheck'):create() )
	--
	game.MoveMsgCtrl = require('app.MoveMsgCtrl'):create()
	--
	game.blackground = require('app.Blackground'):create(20,12)
end

local function main()
	gameInit()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
