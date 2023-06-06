local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Cryptware.Component)

local ExtendedComponents = {}
for _, module in script:GetChildren() do
    table.insert(ExtendedComponents, require(module))
end

local EntityComponent = Component.new({Tag = "EntityComponent", Extensions = ExtendedComponents})

local function clone(tbl)
	local newTbl = {}
	for index, value in tbl do
		if type(value) == "table" then
			newTbl[index] = clone(value)
		else
			newTbl[index] = value
		end
	end
	return newTbl
end

-- Class: Meta
function EntityComponent:_copydata(component)
    component.EntityState = clone(self.Extensions.EntityState)
end

function EntityComponent:_getstate(model)
    return self[model]
end

function EntityComponent:_shouldperformaction(mod)
    require(mod)
end

-- Class: Entity
function EntityComponent:Spawn(models)

end

function EntityComponent:Destroy(models)
-- Destroy their RBXScriptSignal events and any loops that is running [ ONLY FOR THE MODEL TAGGED THIS WILL NOT APPLY FOR ALL ENTITY ]
end

-- Class: Initializers
function EntityComponent:Construct()
    self.ExtendedComponents = {}

    for _, module in script:GetChildren() do
        self.ExtendedComponents[module.Name] = require(module)
    end
end

function EntityComponent:Start()
    
end

return EntityComponent