-- oop test
-- 专门用来测试 object.lua 中的各种方法


require "object"

print("ooptest")

-- test1
print("-----------------test1------start---------")
local testCls = class("testCls")

function testCls:ctor()
  print("testCls:ctor")
  self.yinjun = "sb"
  self.yinjun1 = "sb1 yinjun"
end

function testCls:func1()
  print("testCls:func1")
  print("test 1 : " .. self.yinjun1)
  print("test 1 : " .. self.yinjun)
end

function testCls:dtor()
  print("testCls:dtor")
end


local obj1 = testCls.new()
obj1:func1()
delete(obj1)

print("-----------------test1------end---------")


-- test2
print("------------------test2------------start")

local testCls2 = class("testCls2",testCls)
function testCls2:ctor()
  print("testCls2:ctor")
  self.yinjun = "sb 2"
  self.yinjun2 = "sb2 yinjun"
end

function testCls2:func1()
  testCls.func1(self)
  print("testCls2:func1")
  print("test 2 : " .. self.yinjun2)
  print("test 2 : " .. self.yinjun)
  print("test 2 : " .. self.yinjun1)
end

function testCls2:dtor()
  print("testCls2:dtor")
end

local obj2 = testCls2.new()
obj2:func1()
delete(obj2)

print("test")
local obj3 = new(testCls2)
obj3:func1()
delete(obj3)


print("------------------test2------------end")

print("------------------test3---------------start")
local testCls3 = class("testCls3",testCls2,true)

function testCls3:ctor()
  super(self)
  print("testCls3:ctor")
end

function testCls3:dtor()
  print("testCls3:dtor")
end

local obj4 = testCls3.new()
delete(obj4)
print("------------------test3----------------end")

print("------------------test4------------------start")
local testCls4 = class("testCls4",testCls3,true)

function testCls4:ctor()
  super(self)
  print("testCls4:ctor")
end

function testCls4:dtor()
  print("testCls4:dtor")
end

local obj = testCls4.new()
delete(obj)
print("------------------test4------------------end")

print("------------------test5------------------start")
local testCls5 = class("testCls5",testCls4)
function testCls5:ctor()
  print("testCls5:ctor")
end
function testCls5:dtor()
  print("testCls5:dtor")
end
local obj = testCls5.new()
delete(obj)
print("------------------test5------------------end")

print("------------------test6------------------start")
local testCls6 = class("testCls6",testCls5,true)
function testCls6:ctor()
  super(self)
  print("testCls6:ctor")
end
function testCls6:dtor()
  print("testCls6:dtor")
end
local obj = new(testCls6)
obj:func1()
delete(obj)
print("------------------test6------------------end")



