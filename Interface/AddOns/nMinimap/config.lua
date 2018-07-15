local addon, nMinimap = ...

nMinimap.Config = {
    tab = {
        show = true,
        showAlways = true,

        showBelowMinimap = false,

        -- Number of addons shown in the memory section of the info tooltip. Set to "nil" to show all.
		numberOfAddons = nil, 
    },

    mouseover = {
        zoneText = true,
        instanceDifficulty = false,
    },
}
