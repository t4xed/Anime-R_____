local State = {}

function State:Idle(active, current)
    --print("Idle:", current)
end

function State:Moving(active, current)
    print("Moving:", current)
end

function State:Attacking(active, current)
    print("Attacking:", current)
end

function State:Stunned(active, current)
    print("Stunned:", current)
end

function State:Focusing(active, current)
    print("Focusing:", current)
end

function State:Chasing(active, current)
    print("Chasing:", current)
end

return State