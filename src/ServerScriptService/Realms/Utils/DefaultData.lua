local InfiniteMath = require(game:GetService("ReplicatedStorage").Cryptware.InfiniteMath)

return {
	PlayerData = {
		Essence = InfiniteMath.new(0),
		Power = InfiniteMath.new(1),
		Luck = InfiniteMath.new(1),
	},
	
	LevelData = {
		Level = 0,
		CurrentExp = 0,
		MaxExp = 10,
		ExpMulti = 1.0,
	},
	
	Leaderstats = {
		"Power",
		"Essence",
	},
	
	Potions = {
		Essence = 0,
		Power = 0,
		Exp = 0,
		Luck = 0,
	},
	
	PlayerStats = {
		Totals = {
			Power = InfiniteMath.new(1),
			Essence = InfiniteMath.new(1),
			MobsKilled = InfiniteMath.new(0),
			IslandsUnlocked = 1,
		},
		
		Current = {
			Power = InfiniteMath.new(1),
			Essence = InfiniteMath.new(1),
			MobsKilled = InfiniteMath.new(0),
			IslandsUnlocked = 1,
		}
	},
	
	Inventory = {
		Swords = {},
		Items = {},
		FightingStyles = {},
		Accessories = {
			Armor = {},
		}
	},
	
	Quests = {
		Normal = {},
		Traverser = {},
		FightingStyle = {},
	},
	
	SkillTrees = {
		Character = {},
		Sword = {},
		FightingStyle = {},
	},
	
	Story = {},
	IslandsUnlocked = {},
	BoatsUnlocked = {},

	Gamepasses = {},
	Settings = {},
}