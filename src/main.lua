
cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src/")
cc.FileUtils:getInstance():addSearchPath("res/")

game = {}

require "config"
require "cocos.init"


local function gameInit()
	
	game = {}
	game.row = 20
	game.col = 10
	
	game.FSMStateCtrl = require('app.FSMStateCtrl').new()
	game.FSMStateCtrl:registState( 'StateCubeMove', require('app.StateCubeMove').new() )
	game.FSMStateCtrl:registState( 'StateCubeStandby', require('app.StateCubeStandby').new() )
	game.FSMStateCtrl:registState( 'StateGameMenu', require('app.StateGameMenu').new() )
	game.FSMStateCtrl:registState( 'StateGameOver', require('app.StateGameOver').new() )
	--
	game.MoveMsgCtrl = require('app.MoveMsgCtrl').new()
	--
	game.blackground = require('app.Blackground').new(20,10)
end

local function main()
	gameInit()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
