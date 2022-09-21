MiscData = {}

MiscData.STATUS_TO_IMG_NAME = {
	[1] = "PAR",
	[2] = "SLP",
	[3] = "FRZ",
	[4] = "BRN",
	[5] = "PSN",
	[6] = "",
}

MiscData.STATUS_TYPE =
	MiscUtils.readOnly(
	{
		POISON = "Poison",
		BURN = "Burn",
		FREEZE = "Freeze",
		SLEEP = "Sleep",
		PARALYZE = "Paralysis",
		CONFUSE = "Confusion",
		INFATUATION = "Infatuation",
		ALL = "All"
	}
)

MiscData.NATURES =
	MiscUtils.readOnly(
	{
		"Hardy",
		"Lonely",
		"Brave",
		"Adamant",
		"Naughty",
		"Bold",
		"Docile",
		"Relaxed",
		"Impish",
		"Lax",
		"Timid",
		"Hasty",
		"Serious",
		"Jolly",
		"Naive",
		"Modest",
		"Mild",
		"Quiet",
		"Bashful",
		"Rash",
		"Calm",
		"Gentle",
		"Sassy",
		"Careful",
		"Quirky"
	}
)

MiscData.NATURES_SORTED =
	MiscUtils.readOnly(
	{
		"Adamant",
		"Bashful",
		"Bold",
		"Brave",
		"Calm",
		"Careful",
		"Docile",
		"Gentle",
		"Hardy",
		"Hasty",
		"Impish",
		"Jolly",
		"Lax",
		"Lonely",
		"Mild",
		"Modest",
		"Naive",
		"Naughty",
		"Quiet",
		"Quirky",
		"Rash",
		"Relaxed",
		"Timid",
		"Sassy",
		"Serious"
	}
)