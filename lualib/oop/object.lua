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
  cls.__disableAutoSuperConstruction = disableAutoSuperConstruction or false
  function cls.new(...)
    local instance = setmetatable({},cls)
    instance.class = cls
    local function construct(cls,...)
      if cls.super and not cls.__disableAutoSuperConstruction then
        construct(cls.super)
      end
      if rawget(cls,"ctor")  then
        instance.currentSuper = cls.super
        cls.ctor(instance,...)
      end
    end
    instance.currentSuper = cls.super
    construct(cls,...)
    return instance
  end
  return cls

end

function super(obj,...)
  if obj.currentSuper then
    local construct
    construct = function(cls,...)
      if cls.super and not cls.__disableAutoSuperConstruction then
        construct(cls.super,...)
      end
      if rawget(cls,"ctor") then
        --因为只有super才会用到currentsuper这个变量,所以在调用前设置正确就ok
        obj.currentSuper = cls.super
        cls.ctor(obj,...)
      end
    end
    construct(obj.currentSuper,...)
  end
end


function new(cls,...)
  local instance = setmetatable({},cls)
  instance.class = cls
  local function construct(cls,...)
    if rawget(cls,"ctor") then
      instance.currentSuper = cls.super
      cls.ctor(instance,...)
    end
    if cls.super and not cls.__disableAutoSuperConstruction then
      construct(cls.super,...)
    end

  end
  if cls.super and not cls.__disableAutoSuperConstruction then
    construct(cls.super,...)
  end
  if rawget(cls,"ctor") then
    instance.currentSuper = cls.super
    cls.ctor(instance,...)
    instance.currentSuper = cls.super
  end
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
