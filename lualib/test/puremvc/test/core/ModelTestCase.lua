-- Model TestCase

local Proxy = PM.Proxy
local Model = PM.Model

ModelTestCase = {}

ModelTestCase["Model TestCase"] = function()
  local proxy = Proxy.new("proxyTest",{yinjun=250})
  Model.getInstance("ModelTest"):registerProxy(proxy)
  local proxy_ret = Model.getInstance("ModelTest"):retrieveProxy("proxyTest")
  should.equal("Model retrieveProxy proxy:getProxyName == proxyTest",proxy_ret:getProxyName(),"proxyTest")
  local ret = Model.getInstance("ModelTest"):hasProxy("proxyTest")
  should.equal("Model hasProxy == true",ret,true)

  Model.getInstance("ModelTest"):removeProxy("proxyTest")
  local proxy_ret = Model.getInstance("ModelTest"):retrieveProxy("proxyTest")
  should.equalNil("Model retrieveProxy proxy:getProxyName is nil",proxy_ret)
  local ret = Model.getInstance("ModelTest"):hasProxy("proxyTest")
  should.equal("Model hasProxy == false",ret,false)

end
