local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Component = require(ReplicatedStorage.Cryptware.Component)
local Silo = require(ReplicatedStorage.Cryptware.Silo)
local ScriptUtil = require(script.Parent.Parent.Utils.ScriptUtil)

local EntityComponent = Component.new({Tag = "Entity"})
local EntityStates = require(script.Parent.Parent.Utils.EntityStates)
local EntityProperties = require(script.Parent.Parent.Utils.EntityProperties)

local StateHandlers = script.StateHandlers
local PropertyHandler = require(script.PropertyHandler)

local instances = {}
local combined = {}

for _, mod in script.StateModifiers:GetChildren() do
	for funcName, func in require(mod) do
		combined[funcName] = func
	end
end

-- Class: Entity
function EntityComponent:Watch(stateToWatch)
    if instances[self.Instance] then
		instances[self.Instance]._states:Watch(
			function(state)
				return state[stateToWatch]
			end,

			function(anyState)
				if StateHandlers:FindFirstChild(stateToWatch) then
					require(StateHandlers[stateToWatch]):Init(anyState)
				else
					PropertyHandler:PropertyChanged(stateToWatch, anyState)
				end
			end
		)
    end
end

function EntityComponent:Create()
	local instance = instances[self.Instance]

	if not instance then
		instances[self.Instance] = {}
		instance = instances[self.Instance]

		instance._states = Silo.new(ScriptUtil:DeepCopy(EntityStates), combined)
		instance.Properties = ScriptUtil:DeepCopy(EntityProperties.Default)

		if EntityProperties[self.Instance.Name] then
			ScriptUtil:Reconcile(instance.Properties, EntityProperties[self.Instance.Name])
		end
	end
 
	return instance
end

function EntityComponent:GetState(inst)
    return instances[inst]._states
end

function EntityComponent:SetState(inst, index, value)
    instances[inst]._states[index] = value
end

function EntityComponent:Stop()
	instances[self.Instance] = nil
end

-- Class: Initializers
function EntityComponent:Construct()
	self:Create()
	self:Watch("Running")
end

function EntityComponent:Start()
	while task.wait() do
		for _, obj in CollectionService:GetTagged("Entity") do
			local instance = instances[obj]

			if instance then
				instance._states:Dispatch(instance._states.Actions.SetRunning(true))
			end
		end
 
	 	task.wait(2)
 
		for _, obj in CollectionService:GetTagged("Entity") do
			local instance = instances[obj]

			if instance then
				instance._states:Dispatch(instance._states.Actions.SetRunning(false))
			end
		end
 	end
end

return EntityComponent