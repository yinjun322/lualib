-- object.lua
-- Author: MarkYin
-- Date: 2015-10-09
-- 在lua中模拟class行为
-- 备注：
-- 1，出于自身的认识暂时只支持单继承
-- 2，灵活应对各种情况,增加是否调用父类的构造函数的设置,默认为false,表示自动调用父类构造
--

-- Parameters
-- className : 类名
-- super     : 父类
-- disableAutoSuperConstruction : 是否禁止自动调用父类构造函数


----------------------------------------------------------------------------------------

--Global Function
function class(className,super,disableAutoSuperConstruction)

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
  cls.__disableAutoSuperConstruction = disableAutoSuperConstruction
  function cls.new(...)
    local instance = setmetatable({},cls)
    instance.class = cls
    local function construct(cls,...)
      if cls.super and not cls.__disableAutoSuperConstruction then
        construct(cls.super)
      end
      if rawget(cls,"ctor")  then
        cls.ctor(instance,...)
      end
    end
    construct(cls,...)
    return instance
  end
  return cls

end

function super(obj,...)
  if obj.super then
    local construct = function(cls,...)
      if cls.super and not cls.__disableAutoSuperConstruction then
        construct(cls.super,...)
      end
      if rawget(cls.super,"ctor") then
        cls.super.ctor(obj,...)
      end
    end
    if obj.super.super then
      construct(obj.super.super,...)
    end
    if rawget(obj.super,"ctor") then
      obj.super.ctor(obj,...)
    end
  end
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
      obj = getmetatable(obj)
      obj = obj and obj.__index
    end
  end
  destory(object)
end
