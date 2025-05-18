if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class Private
local Private = select(2, ...)

---@class WeakAuras
local WeakAuras = WeakAuras;
local L = WeakAuras.L;

local encounter_list = ""
local zoneId_list = ""
function Private.InitializeEncounterAndZoneLists()
  if encounter_list ~= "" then
    return
  end

  EJ_SelectTier(EJ_GetNumTiers())

  for _, inRaid in ipairs({false, true}) do
    local instance_index = 1
    local instance_id = EJ_GetInstanceByIndex(instance_index, true)
    local title = inRaid and L["Raids"] or L["Dungeons"]
    zoneId_list = ("%s|cffffd200%s|r\n"):format(zoneId_list, title)

    while instance_id do
      EJ_SelectInstance(instance_id)
      local instance_name, _, _, _, _, dungeonAreaMapID = EJ_GetInstanceInfo(instance_id)
      local ej_index = 1
      local boss, _, encounter_id  = EJ_GetEncounterInfoByIndex(ej_index)

      zoneId_list = ("%s%s: %d\n"):format(zoneId_list, instance_name, dungeonAreaMapID)

      -- Encounter ids
      if inRaid then
        while boss do
          if encounter_id then
            if instance_name then
              encounter_list = ("%s|cffffd200%s|r\n"):format(encounter_list, instance_name)
              instance_name = nil -- Only add it once per section
            end
            encounter_list = ("%s%s: %d\n"):format(encounter_list, boss, encounter_id)
          end
          ej_index = ej_index + 1
          boss, _, encounter_id = EJ_GetEncounterInfoByIndex(ej_index, instance_id)
        end
        encounter_list = encounter_list .. "\n"
      end

      instance_index = instance_index + 1
      instance_id = EJ_GetInstanceByIndex(instance_index, inRaid)
    end
    zoneId_list = zoneId_list .. "\n"
  end

  return encounter_list:sub(1, -3) .. "\n\n" .. L["Supports multiple entries, separated by commas\n"]
end

function Private.get_encounters_list()
  return encounter_list
end

function Private.get_zoneId_list()
  SetMapToCurrentZone()

  --local continent_id = GetCurrentMapContinent()
  --local zone_id = GetCurrentMapZone()
  --local map_area_id = GetCurrentMapAreaID()

  local currentmap_name = GetMapInfo()
  local currentmap_id = GetCurrentMapAreaID()
  local currentmap_zone_name = ""

  return ("%s|cffffd200%s|r%s: %d\n\n%s%s"):format(
    zoneId_list,
    L["Current Zone\n"],
    currentmap_name,
    currentmap_id,
    currentmap_zone_name,
    L["Supports multiple entries, separated by commas"]
  )
end

Private.talentInfo = {
  ["HUNTER"] = {
    {
      "INTERFACE\\ICONS\\ability_hunter_posthaste", -- [1]
      1, -- [2]
      1, -- [3]
      109215, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\INV_Misc_Web_01", -- [1]
      1, -- [2]
      2, -- [3]
      109298, -- [4]
    }, -- [2]
    {
      "INTERFACE\\ICONS\\ability_hunter_pet_chimera", -- [1]
      1, -- [2]
      3, -- [3]
      118675, -- [4]
    }, -- [3]
    {
      "INTERFACE\\ICONS\\spell_shaman_bindelemental", -- [1]
      2, -- [2]
      1, -- [3]
      109248, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\INV_Spear_02", -- [1]
      2, -- [2]
      2, -- [3]
      19386, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Ability_Devour", -- [1]
      2, -- [2]
      3, -- [3]
      19577, -- [4]
    }, -- [6]
    {
      "INTERFACE\\ICONS\\ability_hunter_onewithnature", -- [1]
      3, -- [2]
      1, -- [3]
      109304, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\spell_hunter_aspectoftheironhawk", -- [1]
      3, -- [2]
      2, -- [3]
      109260, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_Druid_DemoralizingRoar", -- [1]
      3, -- [2]
      3, -- [3]
      109212, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Ability_Hunter_AspectoftheViper", -- [1]
      4, -- [2]
      1, -- [3]
      82726, -- [4]
    }, -- [10]
    {
      "INTERFACE\\ICONS\\ability_hunter_sickem", -- [1]
      4, -- [2]
      2, -- [3]
      120679, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Ability_Hunter_ThrilloftheHunt", -- [1]
      4, -- [2]
      3, -- [3]
      109306, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\ability_hunter_murderofcrows", -- [1]
      5, -- [2]
      1, -- [3]
      131894, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Arcane_Arcane04", -- [1]
      5, -- [2]
      2, -- [3]
      130392, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Ability_Hunter_CatlikeReflexes", -- [1]
      5, -- [2]
      3, -- [3]
      120697, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\ability_glaivetoss", -- [1]
      6, -- [2]
      1, -- [3]
      117050, -- [4]
    }, -- [16]
    {
      "INTERFACE\\ICONS\\ability_hunter_resistanceisfutile", -- [1]
      6, -- [2]
      2, -- [3]
      109259, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Ability_Hunter_RapidRegeneration", -- [1]
      6, -- [2]
      3, -- [3]
      120360, -- [4]
    }, -- [18]
  },
  ["WARRIOR"] = {
    {
      "Interface\\Icons\\Ability_Warrior_BullRush", -- [1]
      1, -- [2]
      1, -- [3]
      103826, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\INV_Misc_Horn_04", -- [1]
      1, -- [2]
      2, -- [3]
      103827, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Ability_Warrior_Warbringer", -- [1]
      1, -- [2]
      3, -- [3]
      103828, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Ability_Warrior_FocusedRage", -- [1]
      2, -- [2]
      1, -- [3]
      55694, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Ability_Hunter_Harass", -- [1]
      2, -- [2]
      2, -- [3]
      29838, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\spell_impending_victory", -- [1]
      2, -- [2]
      3, -- [3]
      103840, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Ability_BullRush", -- [1]
      3, -- [2]
      1, -- [3]
      107566, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Shadow_DeathScream", -- [1]
      3, -- [2]
      2, -- [3]
      12323, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\warrior_disruptingshout", -- [1]
      3, -- [2]
      3, -- [3]
      102060, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Ability_Warrior_Bladestorm", -- [1]
      4, -- [2]
      1, -- [3]
      46924, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Ability_Warrior_Shockwave", -- [1]
      4, -- [2]
      2, -- [3]
      46968, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\ability_warrior_dragonroar", -- [1]
      4, -- [2]
      3, -- [3]
      118000, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Ability_Warrior_ShieldBreak", -- [1]
      5, -- [2]
      1, -- [3]
      114028, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Ability_Warrior_Safeguard", -- [1]
      5, -- [2]
      2, -- [3]
      114029, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Ability_Warrior_Vigilance", -- [1]
      5, -- [2]
      3, -- [3]
      114030, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\warrior_talent_icon_avatar", -- [1]
      6, -- [2]
      1, -- [3]
      107574, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_Warrior_BloodBath", -- [1]
      6, -- [2]
      2, -- [3]
      12292, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\warrior_talent_icon_stormbolt", -- [1]
      6, -- [2]
      3, -- [3]
      107570, -- [4]
    }, -- [18]
  },
  ["ROGUE"] = {
    {
      "Interface\\Icons\\Ability_Stealth", -- [1]
      1, -- [2]
      1, -- [3]
      14062, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\rogue_subterfuge", -- [1]
      1, -- [2]
      2, -- [3]
      108208, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\rogue_shadowfocus", -- [1]
      1, -- [2]
      3, -- [3]
      108209, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\INV_ThrowingKnife_06", -- [1]
      2, -- [2]
      1, -- [3]
      26679, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\rogue_nerve _strike", -- [1]
      2, -- [2]
      2, -- [3]
      108210, -- [4]
    }, -- [5]
    {
      "INTERFACE\\ICONS\\ability_rogue_combatreadiness", -- [1]
      2, -- [2]
      3, -- [3]
      74001, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Ability_Rogue_CheatDeath", -- [1]
      3, -- [2]
      1, -- [3]
      31230, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\rogue_leeching_poison", -- [1]
      3, -- [2]
      2, -- [3]
      108211, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_Rogue_TurntheTables", -- [1]
      3, -- [2]
      3, -- [3]
      79008, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Ability_Rogue_UnfairAdvantage", -- [1]
      4, -- [2]
      1, -- [3]
      138106, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Ability_Rogue_Shadowstep", -- [1]
      4, -- [2]
      2, -- [3]
      36554, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\rogue_burstofspeed", -- [1]
      4, -- [2]
      3, -- [3]
      108212, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Ability_Rogue_PreyontheWeak", -- [1]
      5, -- [2]
      1, -- [3]
      131511, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\rogue_paralytic_poison", -- [1]
      5, -- [2]
      2, -- [3]
      108215, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\ability_rogue_dirtydeeds", -- [1]
      5, -- [2]
      3, -- [3]
      108216, -- [4]
    }, -- [15]
    {
      "INTERFACE\\ICONS\\inv_throwingknife_07", -- [1]
      6, -- [2]
      1, -- [3]
      114014, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Achievement_BG_killingblow_berserker", -- [1]
      6, -- [2]
      2, -- [3]
      137619, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Ability_Rogue_SlaughterfromtheShadows", -- [1]
      6, -- [2]
      3, -- [3]
      114015, -- [4]
    }, -- [18]
  },
  ["MAGE"] = {
    {
      "Interface\\Icons\\Spell_Nature_EnchantArmor", -- [1]
      1, -- [2]
      1, -- [3]
      12043, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Spell_Fire_BurningSpeed", -- [1]
      1, -- [2]
      2, -- [3]
      108843, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\spell_mage_iceflows", -- [1]
      1, -- [2]
      3, -- [3]
      108839, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\spell_mage_temporalshield", -- [1]
      2, -- [2]
      1, -- [3]
      115610, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\INV_Elemental_Primal_Fire", -- [1]
      2, -- [2]
      2, -- [3]
      140468, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Ice_Lament", -- [1]
      2, -- [2]
      3, -- [3]
      11426, -- [4]
    }, -- [6]
    {
      "INTERFACE\\ICONS\\spell_frost_ring of frost", -- [1]
      3, -- [2]
      1, -- [3]
      113724, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Frost_FrostWard", -- [1]
      3, -- [2]
      2, -- [3]
      111264, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\ability_mage_frostjaw", -- [1]
      3, -- [2]
      3, -- [3]
      102051, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\ability_mage_greaterinvisibility", -- [1]
      4, -- [2]
      1, -- [3]
      110959, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\spell_fire_rune", -- [1]
      4, -- [2]
      2, -- [3]
      86949, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Spell_Frost_WizardMark", -- [1]
      4, -- [2]
      3, -- [3]
      11958, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\spell_mage_nethertempest", -- [1]
      5, -- [2]
      1, -- [3]
      114923, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Ability_Mage_LivingBomb", -- [1]
      5, -- [2]
      2, -- [3]
      44457, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\spell_mage_frostbomb", -- [1]
      5, -- [2]
      3, -- [3]
      112948, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Arcane_Arcane03", -- [1]
      6, -- [2]
      1, -- [3]
      114003, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\spell_mage_runeofpower", -- [1]
      6, -- [2]
      2, -- [3]
      116011, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility", -- [1]
      6, -- [2]
      3, -- [3]
      1463, -- [4]
    }, -- [18]
  },
  ["PRIEST"] = {
    {
      "Interface\\Icons\\spell_priest_voidtendrils", -- [1]
      1, -- [2]
      1, -- [3]
      108920, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\spell_priest_psyfiend", -- [1]
      1, -- [2]
      2, -- [3]
      108921, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Shadow_ShadowWordDominate", -- [1]
      1, -- [2]
      3, -- [3]
      605, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Holy_SymbolOfHope", -- [1]
      2, -- [2]
      1, -- [3]
      64129, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\ability_priest_angelicfeather", -- [1]
      2, -- [2]
      2, -- [3]
      121536, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\ability_priest_phantasm", -- [1]
      2, -- [2]
      3, -- [3]
      108942, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Holy_SurgeOfLight", -- [1]
      3, -- [2]
      1, -- [3]
      109186, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Shadow_SoulLeech_3", -- [1]
      3, -- [2]
      2, -- [3]
      123040, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\ability_priest_flashoflight", -- [1]
      3, -- [2]
      3, -- [3]
      139139, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Holy_TestOfFaith", -- [1]
      4, -- [2]
      1, -- [3]
      19236, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\spell_priest_spectralguise", -- [1]
      4, -- [2]
      2, -- [3]
      112833, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\ability_priest_angelicbulwark", -- [1]
      4, -- [2]
      3, -- [3]
      108945, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_Shadow_MindTwisting", -- [1]
      5, -- [2]
      1, -- [3]
      109142, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Spell_Holy_PowerInfusion", -- [1]
      5, -- [2]
      2, -- [3]
      10060, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\spell_priest_burningwill", -- [1]
      5, -- [2]
      3, -- [3]
      109175, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\ability_priest_cascade", -- [1]
      6, -- [2]
      1, -- [3]
      121135, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\spell_priest_divinestar", -- [1]
      6, -- [2]
      2, -- [3]
      110744, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\ability_priest_halo", -- [1]
      6, -- [2]
      3, -- [3]
      120517, -- [4]
    }, -- [18]
  },
  ["WARLOCK"] = {
    {
      "Interface\\Icons\\spell_warlock_darkregeneration", -- [1]
      1, -- [2]
      1, -- [3]
      108359, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\warlock_siphonlife", -- [1]
      1, -- [2]
      2, -- [3]
      108370, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\spell_warlock_harvestoflife", -- [1]
      1, -- [2]
      3, -- [3]
      108371, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Ability_Warlock_ShadowFlame", -- [1]
      2, -- [2]
      1, -- [3]
      47897, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\ability_warlock_mortalcoil", -- [1]
      2, -- [2]
      2, -- [3]
      6789, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\ability_warlock_shadowfurytga", -- [1]
      2, -- [2]
      3, -- [3]
      30283, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\ability_warlock_soullink", -- [1]
      3, -- [2]
      1, -- [3]
      108415, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\warlock_sacrificial_pact", -- [1]
      3, -- [2]
      2, -- [3]
      108416, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\ability_deathwing_bloodcorruption_death", -- [1]
      3, -- [2]
      3, -- [3]
      110913, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\ability_deathwing_bloodcorruption_earth", -- [1]
      4, -- [2]
      1, -- [3]
      111397, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\ability_deathwing_sealarmorbreachtga", -- [1]
      4, -- [2]
      2, -- [3]
      111400, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\warlock_spelldrain", -- [1]
      4, -- [2]
      3, -- [3]
      108482, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\warlock_grimoireofcommand", -- [1]
      5, -- [2]
      1, -- [3]
      108499, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\warlock_grimoireofservice", -- [1]
      5, -- [2]
      2, -- [3]
      108501, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\warlock_grimoireofsacrifice", -- [1]
      5, -- [2]
      3, -- [3]
      108503, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Achievement_Boss_Archimonde ", -- [1]
      6, -- [2]
      1, -- [3]
      108505, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Achievement_Boss_Kiljaedan", -- [1]
      6, -- [2]
      2, -- [3]
      137587, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Achievement_Boss_Magtheridon", -- [1]
      6, -- [2]
      3, -- [3]
      108508, -- [4]
    }, -- [18]
  },
  ["DEATHKNIGHT"] = {
    {
      "Interface\\Icons\\ability_deathknight_roilingblood", -- [1]
      1, -- [2]
      1, -- [3]
      108170, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\Ability_Creature_Disease_02", -- [1]
      1, -- [2]
      2, -- [3]
      123693, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\Spell_Shadow_Contagion", -- [1]
      1, -- [2]
      3, -- [3]
      115989, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Shadow_RaiseDead", -- [1]
      2, -- [2]
      1, -- [3]
      49039, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_DeathKnight_AntiMagicZone", -- [1]
      2, -- [2]
      2, -- [3]
      51052, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\INV_Misc_ShadowEgg", -- [1]
      2, -- [2]
      3, -- [3]
      114556, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Spell_Shadow_DemonicEmpathy", -- [1]
      3, -- [2]
      1, -- [3]
      96268, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\Spell_Frost_Wisp", -- [1]
      3, -- [2]
      2, -- [3]
      50041, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\ability_deathknight_asphixiate", -- [1]
      3, -- [2]
      3, -- [3]
      108194, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Shadow_DeathPact", -- [1]
      4, -- [2]
      1, -- [3]
      48743, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\ability_deathknight_deathsiphon", -- [1]
      4, -- [2]
      2, -- [3]
      108196, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\ability_deathknight_deathsiphon2", -- [1]
      4, -- [2]
      3, -- [3]
      119975, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Spell_DeathKnight_BloodTap", -- [1]
      5, -- [2]
      1, -- [3]
      45529, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\INV_Misc_Rune_10", -- [1]
      5, -- [2]
      2, -- [3]
      81229, -- [4]
    }, -- [14]
    {
      "INTERFACE\\ICONS\\spell_shadow_rune", -- [1]
      5, -- [2]
      3, -- [3]
      51462, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\ability_deathknight_aoedeathgrip", -- [1]
      6, -- [2]
      1, -- [3]
      108199, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\ability_deathknight_remorselesswinters2", -- [1]
      6, -- [2]
      2, -- [3]
      108200, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\ability_deathknight_desecratedground", -- [1]
      6, -- [2]
      3, -- [3]
      108201, -- [4]
    }, -- [18]
  },
  ["PALADIN"] = {
    {
      "Interface\\Icons\\ability_paladin_speedoflight", -- [1]
      1, -- [2]
      1, -- [3]
      85499, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\ability_paladin_longarmofthelaw", -- [1]
      1, -- [2]
      2, -- [3]
      87172, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\ability_paladin_veneration", -- [1]
      1, -- [2]
      3, -- [3]
      26023, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Holy_FistOfJustice", -- [1]
      2, -- [2]
      1, -- [3]
      105593, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Holy_PrayerOfHealing", -- [1]
      2, -- [2]
      2, -- [3]
      20066, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\ability_paladin_turnevil", -- [1]
      2, -- [2]
      3, -- [3]
      110301, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\Ability_Paladin_GaurdedbytheLight", -- [1]
      3, -- [2]
      1, -- [3]
      85804, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\INV_Torch_Thrown", -- [1]
      3, -- [2]
      2, -- [3]
      114163, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_Paladin_BlessedMending", -- [1]
      3, -- [2]
      3, -- [3]
      20925, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Holy_SealOfWisdom", -- [1]
      4, -- [2]
      1, -- [3]
      114039, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\spell_holy_unyieldingfaith", -- [1]
      4, -- [2]
      2, -- [3]
      114154, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\ability_paladin_clemency", -- [1]
      4, -- [2]
      3, -- [3]
      105622, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\ability_paladin_holyavenger", -- [1]
      5, -- [2]
      1, -- [3]
      105809, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\Ability_Paladin_SanctifiedWrath", -- [1]
      5, -- [2]
      2, -- [3]
      53376, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Spell_Holy_DivinePurpose", -- [1]
      5, -- [2]
      3, -- [3]
      86172, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\spell_paladin_holyprism", -- [1]
      6, -- [2]
      1, -- [3]
      114165, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\spell_paladin_lightshammer", -- [1]
      6, -- [2]
      2, -- [3]
      114158, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\spell_paladin_executionsentence", -- [1]
      6, -- [2]
      3, -- [3]
      114157, -- [4]
    }, -- [18]
  },
  ["DRUID"] = {
    {
      "Interface\\Icons\\spell_druid_tirelesspursuit", -- [1]
      1, -- [2]
      1, -- [3]
      131768, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\spell_druid_displacement", -- [1]
      1, -- [2]
      2, -- [3]
      102280, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\spell_druid_wildcharge", -- [1]
      1, -- [2]
      3, -- [3]
      102401, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\INV_Misc_Head_Dragon_Green", -- [1]
      2, -- [2]
      1, -- [3]
      145108, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Nature_NatureBlessing", -- [1]
      2, -- [2]
      2, -- [3]
      108238, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Ability_Druid_NaturalPerfection", -- [1]
      2, -- [2]
      3, -- [3]
      102351, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\spell_druid_swarm", -- [1]
      3, -- [2]
      1, -- [3]
      106707, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\spell_druid_massentanglement", -- [1]
      3, -- [2]
      2, -- [3]
      102359, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\Ability_Druid_Typhoon", -- [1]
      3, -- [2]
      3, -- [3]
      132469, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Ability_Druid_ManaTree", -- [1]
      4, -- [2]
      1, -- [3]
      114107, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\spell_druid_incarnation", -- [1]
      4, -- [2]
      2, -- [3]
      106731, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\Ability_Druid_ForceofNature", -- [1]
      4, -- [2]
      3, -- [3]
      106737, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\Ability_Druid_DemoralizingRoar", -- [1]
      5, -- [2]
      1, -- [3]
      99, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\spell_druid_ursolsvortex", -- [1]
      5, -- [2]
      2, -- [3]
      102793, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\Ability_Druid_Bash", -- [1]
      5, -- [2]
      3, -- [3]
      5211, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\Spell_Holy_BlessingOfAgility", -- [1]
      6, -- [2]
      1, -- [3]
      108288, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\Ability_Druid_Dreamstate", -- [1]
      6, -- [2]
      2, -- [3]
      108373, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\Achievement_Zone_Feralas", -- [1]
      6, -- [2]
      3, -- [3]
      124974, -- [4]
    }, -- [18]
  },
  ["MONK"] = {
    {
      "Interface\\Icons\\ability_monk_quipunch", -- [1]
      1, -- [2]
      1, -- [3]
      115173, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\ability_monk_tigerslust", -- [1]
      1, -- [2]
      2, -- [3]
      116841, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\ability_monk_standingkick", -- [1]
      1, -- [2]
      3, -- [3]
      115174, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\ability_monk_chiwave", -- [1]
      2, -- [2]
      1, -- [3]
      115098, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\ability_monk_forcesphere", -- [1]
      2, -- [2]
      2, -- [3]
      124081, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\Spell_Arcane_ArcaneTorrent", -- [1]
      2, -- [2]
      3, -- [3]
      123986, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\ability_monk_powerstrikes", -- [1]
      3, -- [2]
      1, -- [3]
      121817, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\ability_monk_ascension", -- [1]
      3, -- [2]
      2, -- [3]
      115396, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\ability_monk_chibrew", -- [1]
      3, -- [2]
      3, -- [3]
      115399, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\spell_monk_ringofpeace", -- [1]
      4, -- [2]
      1, -- [3]
      116844, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\ability_monk_chargingoxwave", -- [1]
      4, -- [2]
      2, -- [3]
      119392, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\ability_monk_legsweep", -- [1]
      4, -- [2]
      3, -- [3]
      119381, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\ability_monk_jasmineforcetea", -- [1]
      5, -- [2]
      1, -- [3]
      122280, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\ability_monk_dampenharm", -- [1]
      5, -- [2]
      2, -- [3]
      122278, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\spell_monk_diffusemagic", -- [1]
      5, -- [2]
      3, -- [3]
      122783, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\ability_monk_rushingjadewind", -- [1]
      6, -- [2]
      1, -- [3]
      116847, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\ability_monk_summontigerstatue", -- [1]
      6, -- [2]
      2, -- [3]
      123904, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\ability_monk_quitornado", -- [1]
      6, -- [2]
      3, -- [3]
      115008, -- [4]
    }, -- [18]
  },
  ["SHAMAN"] = {
    {
      "Interface\\Icons\\Spell_Nature_NatureGuardian", -- [1]
      1, -- [2]
      1, -- [3]
      30884, -- [4]
    }, -- [1]
    {
      "Interface\\Icons\\ability_shaman_stonebulwark", -- [1]
      1, -- [2]
      2, -- [3]
      108270, -- [4]
    }, -- [2]
    {
      "Interface\\Icons\\ability_shaman_astralshift", -- [1]
      1, -- [2]
      3, -- [3]
      108271, -- [4]
    }, -- [3]
    {
      "Interface\\Icons\\Spell_Fire_BlueCano", -- [1]
      2, -- [2]
      1, -- [3]
      63374, -- [4]
    }, -- [4]
    {
      "Interface\\Icons\\Spell_Nature_StrangleVines", -- [1]
      2, -- [2]
      2, -- [3]
      51485, -- [4]
    }, -- [5]
    {
      "Interface\\Icons\\ability_shaman_windwalktotem", -- [1]
      2, -- [2]
      3, -- [3]
      108273, -- [4]
    }, -- [6]
    {
      "Interface\\Icons\\ability_shaman_multitotemactivation", -- [1]
      3, -- [2]
      1, -- [3]
      108285, -- [4]
    }, -- [7]
    {
      "Interface\\Icons\\ability_shaman_totemcooldownrefund", -- [1]
      3, -- [2]
      2, -- [3]
      108284, -- [4]
    }, -- [8]
    {
      "Interface\\Icons\\ability_shaman_totemrelocation", -- [1]
      3, -- [2]
      3, -- [3]
      108287, -- [4]
    }, -- [9]
    {
      "Interface\\Icons\\Spell_Nature_WispHeal", -- [1]
      4, -- [2]
      1, -- [3]
      16166, -- [4]
    }, -- [10]
    {
      "Interface\\Icons\\Spell_Shaman_ElementalOath", -- [1]
      4, -- [2]
      2, -- [3]
      16188, -- [4]
    }, -- [11]
    {
      "Interface\\Icons\\ability_shaman_echooftheelements", -- [1]
      4, -- [2]
      3, -- [3]
      108283, -- [4]
    }, -- [12]
    {
      "Interface\\Icons\\INV_Spear_04", -- [1]
      5, -- [2]
      1, -- [3]
      147074, -- [4]
    }, -- [13]
    {
      "Interface\\Icons\\ability_shaman_ancestralguidance", -- [1]
      5, -- [2]
      2, -- [3]
      108281, -- [4]
    }, -- [14]
    {
      "Interface\\Icons\\ability_shaman_fortifyingwaters", -- [1]
      5, -- [2]
      3, -- [3]
      108282, -- [4]
    }, -- [15]
    {
      "Interface\\Icons\\shaman_talent_unleashedfury", -- [1]
      6, -- [2]
      1, -- [3]
      117012, -- [4]
    }, -- [16]
    {
      "Interface\\Icons\\shaman_talent_primalelementalist", -- [1]
      6, -- [2]
      2, -- [3]
      117013, -- [4]
    }, -- [17]
    {
      "Interface\\Icons\\shaman_talent_elementalblast", -- [1]
      6, -- [2]
      3, -- [3]
      117014, -- [4]
    }, -- [18]
  },
}
