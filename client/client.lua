local L0_1, L1_1, L2_1, L3_1
L0_1 = Config
L0_1 = L0_1.Framework
L0_1 = nil == L0_1
NO_FRAMEWORK = L0_1
L0_1 = {}
ActiveIdentifiers = L0_1
L0_1 = {}
ActiveStickers = L0_1
SelectedVehicle = 0
ErrorMsgAdd = ""
ErrorMsgEdit = ""
L0_1 = Config
L0_1 = L0_1.Accessibility
L0_1 = L0_1.event
if L0_1 then
  L0_1 = RegisterNetEvent
  L1_1 = "rcore_stickers:openMenu"
  L0_1(L1_1)
  L0_1 = AddEventHandler
  L1_1 = "rcore_stickers:openMenu"
  function L2_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    SelectedVehicle = 0
    L0_2 = ShapeTestFromGameplayCam
    L0_2, L1_2, L2_2, L3_2, L4_2 = L0_2()
    if 0 ~= L4_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "lsrp_stickers:openMenu"
      L7_2 = NetworkGetNetworkIdFromEntity
      L8_2 = L4_2
      L7_2, L8_2 = L7_2(L8_2)
      L5_2(L6_2, L7_2, L8_2)
    else
      L5_2 = ShowNotification
      L6_2 = Config
      L6_2 = L6_2.Text
      L6_2 = L6_2.ERROR_NO_ENTITY
      if not L6_2 then
        L6_2 = "You are not looking at any vehicle."
      end
      L5_2(L6_2)
    end
  end
  L0_1(L1_1, L2_1)
else
  L0_1 = RegisterCommand
  L1_1 = "stickers"
  function L2_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    SelectedVehicle = 0
    L0_2 = ShapeTestFromGameplayCam
    L0_2, L1_2, L2_2, L3_2, L4_2 = L0_2()
    if 0 ~= L4_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "lsrp_stickers:openMenu"
      L7_2 = NetworkGetNetworkIdFromEntity
      L8_2 = L4_2
      L7_2, L8_2 = L7_2(L8_2)
      L5_2(L6_2, L7_2, L8_2)
    else
      L5_2 = ShowNotification
      L6_2 = Config
      L6_2 = L6_2.Text
      L6_2 = L6_2.ERROR_NO_ENTITY
      if not L6_2 then
        L6_2 = "You are not looking at any vehicle."
      end
      L5_2(L6_2)
    end
  end
  L3_1 = false
  L0_1(L1_1, L2_1, L3_1)
end
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:openMenu"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:openMenu"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2
  SelectedVehicle = A0_2
  ErrorMsgAdd = A1_2
  ErrorMsgEdit = A2_2
  L3_2 = WarMenu
  L3_2 = L3_2.OpenMenu
  L4_2 = "STICKERS_MAIN"
  L3_2(L4_2)
end
L3_1 = false
L0_1(L1_1, L2_1, L3_1)
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:refreshStickers"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:refreshStickers"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = next
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if nil == L1_2 then
    L1_2 = pairs
    L2_2 = ActiveStickers
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = RemoveSticker
      L8_2 = L6_2
      L7_2(L8_2)
      L7_2 = ActiveIdentifiers
      L8_2 = L6_2.mapId
      L7_2[L8_2] = false
      L7_2 = ActiveStickers
      L8_2 = L6_2.id
      L7_2[L8_2] = nil
    end
  else
    L1_2 = {}
    L2_2 = pairs
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = GetClosestVehicleToPlayer
      L9_2 = NO_FRAMEWORK
      if not L9_2 then
        L9_2 = true
        if L9_2 then
          goto lbl_37
        end
      end
      L9_2 = false
      ::lbl_37::
      L8_2 = L8_2(L9_2)
      L9_2 = 1
      L10_2 = #L7_2
      L11_2 = 1
      for L12_2 = L9_2, L10_2, L11_2 do
        L13_2 = L7_2[L12_2]
        L14_2 = DoesStickerTextureExist
        L15_2 = L13_2.name
        L16_2 = L13_2.dict
        L14_2 = L14_2(L15_2, L16_2)
        if L14_2 then
          L14_2 = L13_2.id
          L1_2[L14_2] = L13_2
          L14_2 = ActiveStickers
          L15_2 = L13_2.id
          L14_2 = L14_2[L15_2]
          if nil == L14_2 then
            L14_2 = NetworkGetEntityFromNetworkId
            L15_2 = L6_2
            L14_2 = L14_2(L15_2)
            L15_2 = GetUsableIdentifier
            L15_2 = L15_2()
            if nil == L15_2 then
              if L8_2 == L14_2 then
                L16_2 = SelectedVehicle
                if 0 == L16_2 then
                  L16_2 = FreeIdentifier
                  L17_2 = L14_2
                  L16_2 = L16_2(L17_2)
                  L15_2 = L16_2
                  goto lbl_74
                end
              end
            ::lbl_74::
            else
              L13_2.mapId = L15_2
              L16_2 = ApplySticker
              L17_2 = L13_2
              L18_2 = 1.0
              L16_2(L17_2, L18_2)
              L16_2 = ActiveIdentifiers
              L17_2 = L13_2.mapId
              L16_2[L17_2] = true
              L16_2 = ActiveStickers
              L17_2 = L13_2.id
              L16_2[L17_2] = L13_2
            end
          else
            L14_2 = IsDecalAlive
            L15_2 = ActiveStickers
            L16_2 = L13_2.id
            L15_2 = L15_2[L16_2]
            L15_2 = L15_2.handle
            L14_2 = L14_2(L15_2)
            if 1 ~= L14_2 then
              L14_2 = ApplySticker
              L15_2 = ActiveStickers
              L16_2 = L13_2.id
              L15_2 = L15_2[L16_2]
              L16_2 = 1.0
              L14_2(L15_2, L16_2)
            end
          end
        end
      end
    end
    L2_2 = pairs
    L3_2 = ActiveStickers
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = L7_2.id
      L8_2 = L1_2[L8_2]
      if nil == L8_2 then
        L8_2 = RemoveSticker
        L9_2 = L7_2
        L8_2(L9_2)
        L8_2 = ActiveIdentifiers
        L9_2 = L7_2.mapId
        L8_2[L9_2] = false
        L8_2 = ActiveStickers
        L9_2 = L7_2.id
        L8_2[L9_2] = nil
      end
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:placeSticker"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:placeSticker"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = IsVehicleInRange
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = DoesStickerTextureExist
    L3_2 = A1_2.name
    L4_2 = A1_2.dict
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = NetworkGetEntityFromNetworkId
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      L3_2 = GetUsableIdentifier
      L3_2 = L3_2()
      if nil == L3_2 then
        L4_2 = GetClosestVehicleToPlayer
        L5_2 = NO_FRAMEWORK
        if not L5_2 then
          L5_2 = true
          if L5_2 then
            goto lbl_27
          end
        end
        L5_2 = false
        ::lbl_27::
        L4_2 = L4_2(L5_2)
        if L4_2 == L2_2 then
          L4_2 = SelectedVehicle
          if 0 == L4_2 then
            L4_2 = FreeIdentifier
            L5_2 = L2_2
            L4_2 = L4_2(L5_2)
            L3_2 = L4_2
        end
        else
          L4_2 = nil
          return L4_2
        end
      end
      A1_2.mapId = L3_2
      L4_2 = ApplySticker
      L5_2 = A1_2
      L6_2 = 1.0
      L4_2(L5_2, L6_2)
      L4_2 = ActiveIdentifiers
      L5_2 = A1_2.mapId
      L4_2[L5_2] = true
      L4_2 = ActiveStickers
      L5_2 = A1_2.id
      L4_2[L5_2] = A1_2
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:editSticker"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:editSticker"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = IsVehicleInRange
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = DoesStickerTextureExist
    L3_2 = A1_2.name
    L4_2 = A1_2.dict
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = ActiveStickers
      L3_2 = A1_2.id
      L2_2 = L2_2[L3_2]
      if nil ~= L2_2 then
        L2_2 = RemoveSticker
        L3_2 = ActiveStickers
        L4_2 = A1_2.id
        L3_2 = L3_2[L4_2]
        L2_2(L3_2)
        L2_2 = ApplySticker
        L3_2 = A1_2
        L4_2 = 1.0
        L2_2(L3_2, L4_2)
        L2_2 = ActiveIdentifiers
        L3_2 = A1_2.mapId
        L2_2[L3_2] = true
        L2_2 = ActiveStickers
        L3_2 = A1_2.id
        L2_2[L3_2] = A1_2
      end
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:deleteSticker"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:deleteSticker"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = IsVehicleInRange
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = DoesStickerTextureExist
    L3_2 = A1_2.name
    L4_2 = A1_2.dict
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = ActiveStickers
      L3_2 = A1_2.id
      L2_2 = L2_2[L3_2]
      if nil ~= L2_2 then
        L2_2 = RemoveSticker
        L3_2 = ActiveStickers
        L4_2 = A1_2.id
        L3_2 = L3_2[L4_2]
        L2_2(L3_2)
        L2_2 = ActiveIdentifiers
        L3_2 = A1_2.mapId
        L2_2[L3_2] = false
        L2_2 = ActiveStickers
        L3_2 = A1_2.id
        L2_2[L3_2] = nil
      end
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:deleteAllStickers"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:deleteAllStickers"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = pairs
  L2_2 = ActiveStickers
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.vehicleId
    if L7_2 == A0_2 then
      L7_2 = RemoveSticker
      L8_2 = L6_2
      L7_2(L8_2)
      L7_2 = ActiveIdentifiers
      L8_2 = L6_2.mapId
      L7_2[L8_2] = false
      L7_2 = ActiveStickers
      L8_2 = L6_2.id
      L7_2[L8_2] = nil
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterNetEvent
L1_1 = "rcore_stickers:refreshStickers"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "rcore_stickers:refreshStickers"
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = ActiveStickers
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = RemoveSticker
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = RegisterCommand
L1_1 = "refreshstickers"
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = ActiveStickers
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = RemoveSticker
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
L3_1 = false
L0_1(L1_1, L2_1, L3_1)
L0_1 = AddEventHandler
L1_1 = "onResourceStop"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = GetCurrentResourceName
  L1_2 = L1_2()
  if L1_2 == A0_2 then
    L1_2 = pairs
    L2_2 = ActiveStickers
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = RemoveSticker
      L8_2 = L6_2
      L7_2(L8_2)
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = 0
  L1_2 = nil
  L2_2 = WarMenu
  L2_2 = L2_2.CreateMenu
  L3_2 = "STICKERS_MAIN"
  L4_2 = Config
  L4_2 = L4_2.Text
  L4_2 = L4_2.MENU_MAIN_TITLE
  if not L4_2 then
    L4_2 = "STICKERS"
  end
  L5_2 = Config
  L5_2 = L5_2.Text
  L5_2 = L5_2.MENU_MAIN_SUBTITLE
  if not L5_2 then
    L5_2 = "Options"
  end
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = WarMenu
  L2_2 = L2_2.CreateSubMenu
  L3_2 = "STICKERS_CATEGORY"
  L4_2 = "STICKERS_MAIN"
  L5_2 = Config
  L5_2 = L5_2.Text
  L5_2 = L5_2.MENU_CATEGORY_SUBTITLE
  if not L5_2 then
    L5_2 = "Categories"
  end
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = WarMenu
  L2_2 = L2_2.CreateSubMenu
  L3_2 = "STICKERS_EDIT"
  L4_2 = "STICKERS_MAIN"
  L5_2 = Config
  L5_2 = L5_2.Text
  L5_2 = L5_2.MENU_EDIT_SUBTITLE
  if not L5_2 then
    L5_2 = "Existing stickers"
  end
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = WarMenu
  L2_2 = L2_2.CreateSubMenu
  L3_2 = "STICKERS_ADD"
  L4_2 = "STICKERS_CATEGORY"
  L2_2(L3_2, L4_2)
  while true do
    L2_2 = Wait
    L3_2 = 0
    L2_2(L3_2)
    L2_2 = WarMenu
    L2_2 = L2_2.IsAnyMenuOpened
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = Wait
      L3_2 = 500
      L2_2(L3_2)
    end
    L2_2 = WarMenu
    L2_2 = L2_2.Begin
    L3_2 = "STICKERS_MAIN"
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = WarMenu
      L2_2 = L2_2.MenuButton
      L3_2 = Config
      L3_2 = L3_2.Text
      L3_2 = L3_2.MENU_BUTTON_ADD
      if not L3_2 then
        L3_2 = "Add"
      end
      L4_2 = "STICKERS_CATEGORY"
      L2_2(L3_2, L4_2)
      L2_2 = WarMenu
      L2_2 = L2_2.MenuButton
      L3_2 = Config
      L3_2 = L3_2.Text
      L3_2 = L3_2.MENU_BUTTON_EDIT
      if not L3_2 then
        L3_2 = "Edit"
      end
      L4_2 = "STICKERS_EDIT"
      L2_2(L3_2, L4_2)
      L2_2 = WarMenu
      L2_2 = L2_2.End
      L2_2()
    end
    L2_2 = WarMenu
    L2_2 = L2_2.Begin
    L3_2 = "STICKERS_CATEGORY"
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = ErrorMsgAdd
      if "" ~= L2_2 then
        L2_2 = WarMenu
        L2_2 = L2_2.ToolTip
        L3_2 = ErrorMsgAdd
        L2_2(L3_2)
      else
        L2_2 = 1
        L3_2 = Config
        L3_2 = L3_2.Stickers
        L3_2 = #L3_2
        L4_2 = 1
        for L5_2 = L2_2, L3_2, L4_2 do
          L6_2 = WarMenu
          L6_2 = L6_2.MenuButton
          L7_2 = Config
          L7_2 = L7_2.Stickers
          L7_2 = L7_2[L5_2]
          L7_2 = L7_2.category
          L8_2 = "STICKERS_ADD"
          L6_2 = L6_2(L7_2, L8_2)
          if L6_2 then
            L6_2 = WarMenu
            L6_2 = L6_2.SetSubTitle
            L7_2 = "STICKERS_ADD"
            L8_2 = Config
            L8_2 = L8_2.Stickers
            L8_2 = L8_2[L5_2]
            L8_2 = L8_2.category
            L6_2(L7_2, L8_2)
            L6_2 = Config
            L6_2 = L6_2.Stickers
            L6_2 = L6_2[L5_2]
            L1_2 = L6_2.stickers
          end
        end
      end
      L2_2 = WarMenu
      L2_2 = L2_2.End
      L2_2()
    end
    L2_2 = WarMenu
    L2_2 = L2_2.Begin
    L3_2 = "STICKERS_ADD"
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = 1
      L3_2 = #L1_2
      L4_2 = 1
      for L5_2 = L2_2, L3_2, L4_2 do
        L6_2 = L1_2[L5_2]
        L6_2 = L6_2.name
        L7_2 = L1_2[L5_2]
        L7_2 = L7_2.price
        L8_2 = L1_2[L5_2]
        L8_2 = L8_2.dict
        L9_2 = DoesStickerTextureExist
        L10_2 = L6_2
        L11_2 = L8_2
        L9_2 = L9_2(L10_2, L11_2)
        if L9_2 then
          L9_2 = NO_FRAMEWORK
          if L9_2 then
            L9_2 = WarMenu
            L9_2 = L9_2.Button
            L10_2 = L6_2
            L9_2(L10_2)
          elseif L7_2 > 0 then
            L9_2 = WarMenu
            L9_2 = L9_2.Button
            L10_2 = L6_2
            L11_2 = Config
            L11_2 = L11_2.Text
            L11_2 = L11_2.MENU_BUTTON_PRICE
            if not L11_2 then
              L11_2 = "~g~$%s"
            end
            L12_2 = L11_2
            L11_2 = L11_2.format
            L13_2 = L7_2
            L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L11_2(L12_2, L13_2)
            L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          else
            L9_2 = WarMenu
            L9_2 = L9_2.Button
            L10_2 = L6_2
            L11_2 = Config
            L11_2 = L11_2.Text
            L11_2 = L11_2.MENU_BUTTON_FREE
            if not L11_2 then
              L11_2 = "~g~FREE"
            end
            L9_2(L10_2, L11_2)
          end
          L9_2 = WarMenu
          L9_2 = L9_2.IsItemHovered
          L9_2 = L9_2()
          if L9_2 then
            L9_2 = GetStickerResolution
            L10_2 = L6_2
            L11_2 = L8_2
            L12_2 = 0.5
            L9_2, L10_2 = L9_2(L10_2, L11_2, L12_2)
            L11_2 = DrawSprite
            L12_2 = L8_2
            L13_2 = L6_2
            L14_2 = 0.5
            L15_2 = 0.5
            L16_2 = L9_2
            L17_2 = L10_2
            L18_2 = 0.0
            L19_2 = 255
            L20_2 = 255
            L21_2 = 255
            L22_2 = 255
            L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          end
          L9_2 = WarMenu
          L9_2 = L9_2.IsItemSelected
          L9_2 = L9_2()
          if L9_2 then
            L9_2 = NetworkGetEntityFromNetworkId
            L10_2 = SelectedVehicle
            L9_2 = L9_2(L10_2)
            L10_2 = GetUsableIdentifier
            L10_2 = L10_2()
            if nil == L10_2 then
              L11_2 = FreeIdentifier
              L12_2 = L9_2
              L11_2 = L11_2(L12_2)
              L10_2 = L11_2
            end
            L11_2 = ActiveIdentifiers
            L11_2[L10_2] = true
            L11_2 = StartEditor
            L12_2 = L10_2
            L13_2 = L6_2
            L14_2 = nil
            L15_2 = L9_2
            function L16_2(A0_3)
              local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
              if nil ~= A0_3 then
                L1_3 = 1
                L2_3 = #A0_3
                L3_3 = 1
                for L4_3 = L1_3, L2_3, L3_3 do
                  L5_3 = ActiveIdentifiers
                  L6_3 = A0_3[L4_3]
                  L6_3 = L6_3.mapId
                  L5_3[L6_3] = false
                  L5_3 = TriggerServerEvent
                  L6_3 = "lsrp_stickers:placeSticker"
                  L7_3 = SelectedVehicle
                  L8_3 = A0_3[L4_3]
                  L5_3(L6_3, L7_3, L8_3)
                end
              end
              SelectedVehicle = 0
            end
            L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
            L11_2 = WarMenu
            L11_2 = L11_2.CloseMenu
            L11_2()
          end
        end
      end
      L2_2 = WarMenu
      L2_2 = L2_2.End
      L2_2()
    end
    L2_2 = WarMenu
    L2_2 = L2_2.Begin
    L3_2 = "STICKERS_EDIT"
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = ErrorMsgEdit
      if "" ~= L2_2 then
        L2_2 = WarMenu
        L2_2 = L2_2.ToolTip
        L3_2 = ErrorMsgEdit
        L2_2(L3_2)
      else
        L2_2 = pairs
        L3_2 = ActiveStickers
        L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
        for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
          L8_2 = L7_2.vehicleId
          L9_2 = SelectedVehicle
          if L8_2 == L9_2 then
            L8_2 = WarMenu
            L8_2 = L8_2.Button
            L9_2 = L7_2.name
            L8_2(L9_2)
            L8_2 = WarMenu
            L8_2 = L8_2.IsItemHovered
            L8_2 = L8_2()
            if L8_2 and L6_2 ~= L0_2 then
              if 0 ~= L0_2 then
                L8_2 = ActiveStickers
                L8_2 = L8_2[L0_2]
                L9_2 = RemoveSticker
                L10_2 = L8_2
                L9_2(L10_2)
                L9_2 = ApplySticker
                L10_2 = L8_2
                L11_2 = 1.0
                L9_2(L10_2, L11_2)
              end
              L8_2 = RemoveSticker
              L9_2 = L7_2
              L8_2(L9_2)
              L8_2 = ApplySticker
              L9_2 = L7_2
              L10_2 = 0.3
              L8_2(L9_2, L10_2)
              L0_2 = L6_2
            end
            L8_2 = WarMenu
            L8_2 = L8_2.IsItemSelected
            L8_2 = L8_2()
            if L8_2 then
              L8_2 = RemoveSticker
              L9_2 = L7_2
              L8_2(L9_2)
              L8_2 = ApplySticker
              L9_2 = L7_2
              L10_2 = 1.0
              L8_2(L9_2, L10_2)
              L8_2 = StartEditor
              L9_2 = L7_2.mapId
              L10_2 = L7_2.name
              L11_2 = L7_2
              L12_2 = NetworkGetEntityFromNetworkId
              L13_2 = SelectedVehicle
              L12_2 = L12_2(L13_2)
              function L13_2(A0_3)
                local L1_3, L2_3, L3_3, L4_3
                if A0_3 then
                  L1_3 = next
                  L2_3 = A0_3
                  L1_3 = L1_3(L2_3)
                  if L1_3 then
                    L1_3 = TriggerServerEvent
                    L2_3 = "lsrp_stickers:editSticker"
                    L3_3 = SelectedVehicle
                    L4_3 = A0_3[1]
                    L1_3(L2_3, L3_3, L4_3)
                  else
                    L1_3 = TriggerServerEvent
                    L2_3 = "lsrp_stickers:deleteSticker"
                    L3_3 = SelectedVehicle
                    L4_3 = L7_2
                    L1_3(L2_3, L3_3, L4_3)
                  end
                end
                SelectedVehicle = 0
              end
              L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
              L0_2 = 0
              L8_2 = WarMenu
              L8_2 = L8_2.CloseMenu
              L8_2()
            end
          end
        end
      end
      L2_2 = WarMenu
      L2_2 = L2_2.End
      L2_2()
    elseif 0 ~= L0_2 then
      L2_2 = ActiveStickers
      L2_2 = L2_2[L0_2]
      L0_2 = 0
      L3_2 = RemoveSticker
      L4_2 = L2_2
      L3_2(L4_2)
      L3_2 = ApplySticker
      L4_2 = L2_2
      L5_2 = 1.0
      L3_2(L4_2, L5_2)
    end
  end
end
L0_1(L1_1)
L0_1 = CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = {}
  L1_2 = 1
  L2_2 = Config
  L2_2 = L2_2.Stickers
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = 1
    L6_2 = Config
    L6_2 = L6_2.Stickers
    L6_2 = L6_2[L4_2]
    L6_2 = L6_2.stickers
    L6_2 = #L6_2
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = Config
      L9_2 = L9_2.Stickers
      L9_2 = L9_2[L4_2]
      L9_2 = L9_2.stickers
      L9_2 = L9_2[L8_2]
      L9_2 = L9_2.dict
      if L9_2 then
        L10_2 = L0_2[L9_2]
        if nil == L10_2 then
          L10_2 = RequestStreamedTextureDict
          L11_2 = L9_2
          L12_2 = 0
          L10_2(L11_2, L12_2)
          repeat
            L10_2 = Wait
            L11_2 = 0
            L10_2(L11_2)
            L10_2 = HasStreamedTextureDictLoaded
            L11_2 = L9_2
            L10_2 = L10_2(L11_2)
          until L10_2
          L0_2[L9_2] = true
        end
      end
    end
  end
end
L0_1(L1_1)
