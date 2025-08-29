MiscData = {}

MiscData.STATUS_TO_IMG_NAME = {
	[1] = "PAR",
	[2] = "SLP",
	[3] = "FRZ",
	[4] = "BRN",
	[5] = "PSN",
	[6] = ""
}

MiscData.STATUS_TYPE =
	MiscUtils.readOnly(
	{
			POISON = Localizations.PokemonStatusType.poison,
			BURN = Localizations.PokemonStatusType.burn,
			FREEZE = Localizations.PokemonStatusType.freeze,
			SLEEP = Localizations.PokemonStatusType.sleep,
			PARALYZE = Localizations.PokemonStatusType.paralysis,
			CONFUSE = Localizations.PokemonStatusType.confuse,
			INFATUATION = Localizations.PokemonStatusType.infatuation,
			ALL = Localizations.PokemonStatusType.all
	}
)

MiscData.NATURE_TRANSLATION_TO_KEY = {
	[Localizations.PokemonNatures.hardy] = "Hardy",
	[Localizations.PokemonNatures.lonely] = "Lonely",
	[Localizations.PokemonNatures.brave] = "Brave",
	[Localizations.PokemonNatures.adamant] = "Adamant",
	[Localizations.PokemonNatures.naughty] = "Naughty",
	[Localizations.PokemonNatures.bold] = "Bold",
	[Localizations.PokemonNatures.docile] = "Docile",
	[Localizations.PokemonNatures.relaxed] = "RELAXED",
	[Localizations.PokemonNatures.impish] = "Impish",
	[Localizations.PokemonNatures.lax] = "Lax",
	[Localizations.PokemonNatures.timid] = "Timid",
	[Localizations.PokemonNatures.hasty] = "Hasty",
	[Localizations.PokemonNatures.serious] = "Serious",
	[Localizations.PokemonNatures.jolly] = "Jolly",
	[Localizations.PokemonNatures.naive] = "Naive",
	[Localizations.PokemonNatures.modest] = "Modest",
	[Localizations.PokemonNatures.mild] = "Mild",
	[Localizations.PokemonNatures.quiet] = "Quiet",
	[Localizations.PokemonNatures.bashful] = "Bashful",
	[Localizations.PokemonNatures.rash] = "Rash",
	[Localizations.PokemonNatures.calm] = "Calm",
	[Localizations.PokemonNatures.gentle] = "Gentle",
	[Localizations.PokemonNatures.sassy] = "Sassy",
	[Localizations.PokemonNatures.careful] = "Careful",
	[Localizations.PokemonNatures.quirky] = "Quirky"
}
MiscData.NATURES =
	MiscUtils.readOnly(
	{
			Localizations.PokemonNatures.hardy,
			Localizations.PokemonNatures.lonely,
			Localizations.PokemonNatures.brave,
			Localizations.PokemonNatures.adamant,
			Localizations.PokemonNatures.naughty,
			Localizations.PokemonNatures.bold,
			Localizations.PokemonNatures.docile,
			Localizations.PokemonNatures.relaxed,
			Localizations.PokemonNatures.impish,
			Localizations.PokemonNatures.lax,
			Localizations.PokemonNatures.timid,
			Localizations.PokemonNatures.hasty,
			Localizations.PokemonNatures.serious,
			Localizations.PokemonNatures.jolly,
			Localizations.PokemonNatures.naive,
			Localizations.PokemonNatures.modest,
			Localizations.PokemonNatures.mild,
			Localizations.PokemonNatures.quiet,
			Localizations.PokemonNatures.bashful,
			Localizations.PokemonNatures.rash,
			Localizations.PokemonNatures.calm,
			Localizations.PokemonNatures.gentle,
			Localizations.PokemonNatures.sassy,
			Localizations.PokemonNatures.careful,
			Localizations.PokemonNatures.quirky,
	}
)

MiscData.NATURES_SORTED =
	MiscUtils.readOnly(
	{
			Localizations.PokemonNatures.adamant,
			Localizations.PokemonNatures.bashful,
			Localizations.PokemonNatures.bold,
			Localizations.PokemonNatures.brave,
			Localizations.PokemonNatures.calm,
			Localizations.PokemonNatures.careful,
			Localizations.PokemonNatures.docile,
			Localizations.PokemonNatures.gentle,
			Localizations.PokemonNatures.hardy,
			Localizations.PokemonNatures.hasty,
			Localizations.PokemonNatures.impish,
			Localizations.PokemonNatures.jolly,
			Localizations.PokemonNatures.lax,
			Localizations.PokemonNatures.lonely,
			Localizations.PokemonNatures.mild,
			Localizations.PokemonNatures.modest,
			Localizations.PokemonNatures.naive,
			Localizations.PokemonNatures.naughty,
			Localizations.PokemonNatures.quiet,
			Localizations.PokemonNatures.quirky,
			Localizations.PokemonNatures.rash,
			Localizations.PokemonNatures.relaxed,
			Localizations.PokemonNatures.timid,
			Localizations.PokemonNatures.sassy,
			Localizations.PokemonNatures.serious,
	}
)
