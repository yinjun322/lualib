-- View TestCase

local View = PM.View

local ViewTestCase = {}

ViewTestCase["View register notify remove Observer Test"] = function()
  local body = {num=10}
  local noti = Notification.new("test_notification",body,"test")
  local context = {name="yinjun",num=1}
  local function test(con,notification)
    con.name = "yinjun lai le "
    local num = notification:getBody().num
    con.num = con.num*num
  end
  local observer = Observer.new(test,context)

  View.getInstance("test"):registerMediator("test_notification",observer)
  View.getInstance("test"):notifyObservers(noti)
  should.equal("ViewTestCase ret == yinjun laile ",context.name,"yinjun lai le")
  should.equal("ViewTestCase ret == 10",context.num,10)
  View.getInstance("test"):removeObserver("test_notification",context)
  View.getInstance("test"):notifyObservers(noti)
  should.equal("ViewTestCase ret == 10",context.num,10)
end

ViewTestCase["View register retrieve remove Mediator Test"] = function()
  local mediator = Mediator.new("TestMediator")
end


should.runTestCase(ViewTestCase)
