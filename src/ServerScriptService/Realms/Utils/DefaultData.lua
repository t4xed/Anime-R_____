return {
	PlayerData = {
		Essence = 0,
		Power = 1,
		Luck = 1
	},

	Leaderboards = {
		Essence = {
			Place = 0,
			Emoji = "🔮",
			Color = "#a026de"
		},

		Power = {
			Place = 0,
			Emoji = "🥊",
			Color = "#de3226"
		},
	},
	
	LevelData = {
		Level = 0,
		CurrentExp = 0,
		MaxExp = 10,
	},

	Multipliers = {
		Essence = 0,
		Power = 0,
		Luck = 0,
		Exp = 0,
	},
	
	PlayerStats = {
		Totals = {
			Power = 1,
			Essence = 1,
			MobsKilled = 0,
			IslandsUnlocked = 1,
		},
		
		Current = {
			Power = 1,
			Essence = 1,
			MobsKilled = 0,
			IslandsUnlocked = 1,
		}
	},
	
	Inventory = {
		Swords = {},
		Items = {},
		FightingStyles = {},

		Accessories = {
			Armor = {},
		},

		Potions = {
			Essence = {
				Owned = { ["15"] = 0, ["40"] = 0, ["125"] = 0, ["265"] = 0 },
				Time = 0,
			},

			Power = {
				Owned = { ["15"] = 0, ["40"] = 0, ["125"] = 0, ["265"] = 0 },
				Time = 0,
			},

			Exp = {
				Owned = { ["15"] = 0, ["40"] = 0, ["125"] = 0, ["265"] = 0 },
				Time = 0,
			},

			Luck = {
				Owned = { ["15"] = 0, ["40"] = 0, ["125"] = 0, ["265"] = 0 },
				Time = 0,
			},
		},
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

	Ban = {
		Active = false,
		Duration = nil,
	}
}