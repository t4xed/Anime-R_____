local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Crypt = require(ReplicatedStorage.Cryptware.Crypt)
local Packages = ReplicatedStorage.Packages
local HotReloader = require(Packages.rewire).HotReloader

Crypt.Include(script.Parent.Systems)
Crypt.Utils(script.Parent.Utils)
Crypt.Utils(ReplicatedStorage.Shared)
Crypt.Start()