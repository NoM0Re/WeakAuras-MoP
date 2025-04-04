if not WeakAuras.IsCorrectVersion() then return end
local AddonName, OptionsPrivate = ...

local SharedMedia = LibStub("LibSharedMedia-3.0");
local L = WeakAuras.L;

local function createOptions(parentData, data, index, subIndex)
  local options = {
    __title = L["Model %s"]:format(subIndex),
    __order = 1,
    bar_model_visible = {
      type = "toggle",
      width = WeakAuras.doubleWidth,
      name = L["Show Model"],
      order = 9,
    },
    model_fileId = {
      type = "input",
      width = WeakAuras.doubleWidth - 0.15,
      name = L["Model"],
      order =  10,
      hidden = true
    },
    model_path = {
      type = "input",
      width = WeakAuras.doubleWidth - 0.15,
      name = L["Model"],
      order =  10.5,
      -- hidden = not WeakAuras.IsClassic()
    },
    chooseModel = {
      type = "execute",
      width = 0.15,
      name = L["Choose"],
      order =  11,
      func = function()
        OptionsPrivate.OpenModelPicker(parentData, {"subRegions", index});
      end,
      imageWidth = 24,
      imageHeight = 24,
      control = "WeakAurasIcon",
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\browse",
    },
    bar_model_clip = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Clipped by Progress"],
      order = 12,
      hidden = function() return parentData.regionType ~= "aurabar" end
    },
    bar_model_alpha = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Alpha"],
      order = 13,
      min = 0,
      max = 1,
      bigStep = 0.1
    },
    api = {
      type = "toggle",
      name = L["Use SetTransform"],
      order = 14,
      width = WeakAuras.normalWidth
    },
    model_z = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Z Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 20,
      hidden = function() return data.api end
    },
    model_x = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["X Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 30,
      hidden = function() return data.api end
    },
    model_y = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Y Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 40,
      hidden = function() return data.api end
    },
    rotation = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Rotation"],
      min = 0,
      max = 360,
      step = 1,
      bigStep = 3,
      order = 45,
      hidden = function() return data.api end
    },
    -- New Settings
    model_st_tx = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["X Offset"],
      softMin = -1000,
      softMax = 1000,
      step = 1,
      bigStep = 5,
      order = 20,
      hidden = function() return not data.api end
    },
    model_st_ty = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Y Offset"],
      softMin = -1000,
      softMax = 1000,
      step = 1,
      bigStep = 5,
      order = 21,
      hidden = function() return not data.api end
    },
    model_st_tz = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Z Offset"],
      softMin = -1000,
      softMax = 1000,
      step = 1,
      bigStep = 5,
      order = 22,
      hidden = function() return not data.api end
    },
    model_st_rx = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["X Rotation"],
      min = 0,
      max = 360,
      step = 1,
      bigStep = 3,
      order = 23,
      hidden = function() return not data.api end
    },
    model_st_ry = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Y Rotation"],
      min = 0,
      max = 360,
      step = 1,
      bigStep = 3,
      order = 24,
      hidden = function() return not data.api end
    },
    model_st_rz = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Z Rotation"],
      min = 0,
      max = 360,
      step = 1,
      bigStep = 3,
      order = 25,
      hidden = function() return not data.api end
    },
    model_st_us = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Scale"],
      min = 5,
      max = 1000,
      step = 0.1,
      bigStep = 5,
      order = 26,
      hidden = function() return not data.api end
    },
  }

  OptionsPrivate.AddUpDownDeleteDuplicate(options, parentData, index, "subbarmodel")

  return options
end

WeakAuras.RegisterSubRegionOptions("subbarmodel", createOptions, L["Shows a model"]);
