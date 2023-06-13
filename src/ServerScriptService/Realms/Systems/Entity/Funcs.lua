local CollectionService = game:GetService("CollectionService")

local Properties, States = require(script.Parent.Properties), require(script.Parent.States)
local CoreHandler, StateHandler = require(script.Parent.CoreHandler), require(script.Parent.StateHandler)
local ScriptUtil = require(script.Parent.Parent.Parent.Utils.ScriptUtil)

local Funcs = {}

function Funcs:Init(Entity)
    function Entity:Construct(entity)
        local active = {}

        active.Properties = ScriptUtil:DeepCopy(Properties.Default)
        active.States = ScriptUtil:DeepCopy(States)
        active.Instance = entity

        ScriptUtil:Reconcile(active, CoreHandler)

        if Properties[entity.Name] then
            ScriptUtil:Reconcile(active.Properties, Properties[entity.Name])
        end

        function active:SetState(state)
            for _state, val in self.States do
                if _state == state then
                    self.States[_state] = true
                    StateHandler[_state](StateHandler[_state], active, true)
                elseif val then
                    self.States[_state] = false
                    StateHandler[_state](StateHandler[_state], active, false)
                end
            end

            self.CurrentState = state
        end

        function active:GetState()
            return self.CurrentState
        end

        task.spawn(function()
            active:Spawn()
            active:SetState("Idle")
    
            --local id = #self.Active + 1
            table.insert(self.Active, active)

            --[[print(entity.Name .. " constructed:", active)

            task.delay(5, function()
                active:Despawn()
                self.Active[id] = nil
            end)]]
        end)
    end
    
    for _, entity in CollectionService:GetTagged("Entity") do
        Entity:Construct(entity)
    end

    CollectionService:GetInstanceAddedSignal("Entity"):Connect(function(entity)
        Entity:Construct(entity)
    end)
end

return Funcs