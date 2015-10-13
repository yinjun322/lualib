-- puremvc 初始化

--主要是配置package.path,以及把各个class加载到内存里面来

--并且在全局变量中间保存起来
package.path = package.path .. ";" .. "./?.lua"

--如果object还没加载,加载oop/object 进来

package.path = package.path .. ";" .. "./../oop/?.lua"
require "object"


PM = {}
PM.Controller = require "core/Controller"
PM.Model = require "core/Model"
PM.View = require "core/View"

PM.MacroCommand = require "patterns/command/MacroCommand"
PM.SimpleCommand = require "patterns/command/SimpleCommand"

PM.Facade = require "patterns/facade/Facade"

PM.Mediator = require "patterns/mediator/Mediator"

PM.Notification = require "patterns/observer/Notification"
PM.Notifier = require "patterns/observer/Notifier"
PM.Observer = require "patterns/observer/Observer"

PM.Proxy = require "patterns/proxy/Proxy"


