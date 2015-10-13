-- 测试帮助类

local TestNum = 0
local TestSuccessNum = 0

local myPrint = function(str)
  print("[" .. TestSuccessNum .. "/" .. TestNum .. "]  " .. str)
end

should = {}

function should.equal(msg,act,exp)
  TestNum = TestNum + 1
  if act == exp then
    TestSuccessNum = TestSuccessNum + 1
    myPrint("OK : " .. msg)
  else
    myPrint("ERROR : " .. msg .. ",the act is " .. tostring(act))
  end
end

function should.equalNil(msg,act)
  TestNum = TestNum + 1
  if act == nil then
    TestSuccessNum = TestSuccessNum + 1
    myPrint("OK : " .. msg)
  else
    myPrint("ERROR : " .. msg .. ",the act is " .. tostring(act))
  end
end

function should.equalNotNil(msg,act)
  TestNum = TestNum + 1
  if act then
    TestSuccessNum = TestSuccessNum + 1
    myPrint("OK : " .. msg)
  else
    myPrint("ERROR : " .. msg .. ",the act is " .. tostring(act))
  end
end


function should.runTestCase(tcTb)
  for _,v in pairs(tcTb) do
    should.callTestCase(_,v)
  end
end


function should.callTestCase(msg,func)
  print("------------------" .. msg .. "...........start" .. "--------------------")
  func()
  print("------------------" .. msg .. "...........start" .. "--------------------")
end
