-- oop test
-- 专门用来测试 object.lua 中的各种方法


require "object"

print("ooptest")

local testCls = class("testCls")

function testCls:ctor()
  print("testCls:ctor")
end

function testCls:func1()
  print("testCls:func1")
end

function testCls:dtor()
  print("testCls:dtor")
end

-- test1
print("-----------------test1------start---------")

local obj1 = testCls.new()
obj1:func1()
delete(obj1)

print("-----------------test1------end---------")


-- test2
print("------------------test2------------start")

local testCls2 = class("testCls2",testCls)
function testCls2:ctor()
  print("testCls2:ctor")
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

