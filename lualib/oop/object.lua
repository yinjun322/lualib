-- object.lua
-- Author: MarkYin
-- Date: 2015-10-09
-- 在lua中模拟class行为
-- 备注：
-- 1，出于自身的认识暂时只支持单继承
-- 2，灵活应对各种情况,增加是否调用父类的构造函数的设置,默认为false,表示自动调用父类构造
--


----------------------------------------------------------------------------------------


function class(className,super)

  local superType = type(super)
  local cls
  if superType ~= 'table' then
    superType = nil
    super = nil
  end

  if super then
    cls = {}
    setmetatable(cls,{__index = super})
    cls.super = super
  else
    cls = {ctor = function() end}
  end

  cls.__cname = className
  cls.__index = cls
  function cls.new(...)
    local instance = setmetatable({},cls)
    instance.class = cls
    instance:ctor(...)
    return instance
  end
  return cls

end

function new(class,...)
  local instance = setmetatable({},class)
  instance.class = class
  instance:ctor(...)
  return instance
end

function delete(object)
  local function destory(obj)
    while obj do
      if rawget(obj,"dtor") then
        obj.dtor(obj)
      end
      local obj = getmetatable(obj)
      obj = obj and obj.__index
    end
  end
  destory(object)
end
