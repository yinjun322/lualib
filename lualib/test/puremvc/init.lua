--测试用例初始化

--把puremvc模块导进来

package.path = package.path .. ";" .. "./../../?.lua" .. ";" .. "./../../oop/?.lua" .. ";" .. "./../../puremvc/?.lua"


require "puremvc/init"

--同时加载帮助类

require "help"
