-- Controller TestCase

local Controller = PM.Controller

TestCase = {}

TestCase["Controller Test"] = function()
  Controller.getInstance("control"):registerCommand("test1",1)
  local ret = Controller.getInstance("control"):hasCommand("test1")
  should.equal("Controller hasCommand(test) is true",ret,true)
  Controller.getInstance("control"):removeCommand("test1")
  local ret = Controller.getInstance("control"):hasCommand("test1")
  should.equal("Controller hasCommand is False",ret,false)
end



should.runTestCase(TestCase)
