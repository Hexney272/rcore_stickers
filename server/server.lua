local L0_1, L1_1, L2_1
L0_1 = Config
L0_1 = L0_1.Framework
L0_1 = nil == L0_1
NO_FRAMEWORK = L0_1
L0_1 = {}
StickerCacheDB = L0_1
L0_1 = {}
CachedStickers = L0_1
L0_1 = {}
CachedVehicles = L0_1
StickerCounter = 1
L0_1 = RegisterNetEvent
L1_1 = "lsrp_stickers:openMenu"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "lsrp_stickers:openMenu"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = source
  L2_2 = NetworkGetEntityFromNetworkId
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = DoesEntityExist
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = FetchVehicle
    L4_2 = GetVehicleNumberPlateText
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    L5_2 = L4_2
    L4_2 = L4_2.gsub
    L6_2 = "%s+"
    L7_2 = ""
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L5_2 = GetEntityModel
    L6_2 = L2_2
    L5_2 = L5_2(L6_2)
    L6_2 = L1_2
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L4_2 = Config
    L4_2 = L4_2.Accessibility
    L4_2 = L4_2.anyone
    if L4_2 then
      L4_2 = ""
      if L4_2 then
        goto lbl_37
      end
    end
    L4_2 = Config
    L4_2 = L4_2.Text
    L4_2 = L4_2.ERROR_NO_ACCESS_PLACE
    if not L4_2 then
      L4_2 = "You cannot place stickers on this vehicle."
    end
    ::lbl_37::
    L5_2 = Config
    L5_2 = L5_2.Accessibility
    L5_2 = L5_2.anyone
    if L5_2 then
      L5_2 = ""
      if L5_2 then
        goto lbl_51
      end
    end
    L5_2 = Config
    L5_2 = L5_2.Text
    L5_2 = L5_2.ERROR_NO_ACCESS_EDIT
    if not L5_2 then
      L5_2 = "You cannot edit stickers on this vehicle."
    end
    ::lbl_51::
    L6_2 = NO_FRAMEWORK
    if L6_2 then
      L6_2 = CachedStickers
      L6_2 = L6_2[A0_2]
      if L6_2 then
        L6_2 = CachedStickers
        L6_2 = L6_2[A0_2]
        L6_2 = #L6_2
        L7_2 = Config
        L7_2 = L7_2.EditorOptions
        L7_2 = L7_2.maxStickers
        if not L7_2 then
          L7_2 = 6
        end
        if L6_2 >= L7_2 then
          L6_2 = Config
          L6_2 = L6_2.Text
          L6_2 = L6_2.ERROR_MAX_STICKERS
          L4_2 = L6_2 or L4_2
          if not L6_2 then
            L4_2 = "This vehicle has already reached maximum amount of stickers."
          end
        end
      else
        L6_2 = Config
        L6_2 = L6_2.Text
        L6_2 = L6_2.ERROR_NO_STICKERS
        L5_2 = L6_2 or L5_2
        if not L6_2 then
          L5_2 = "This vehicle has no stickers on it."
        end
      end
      L6_2 = TriggerClientEvent
      L7_2 = "lsrp_stickers:openMenu"
      L8_2 = L1_2
      L9_2 = A0_2
      L10_2 = L4_2
      L11_2 = L5_2
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
    elseif L3_2 then
      L6_2 = GetPlayerId
      L7_2 = L1_2
      L6_2 = L6_2(L7_2)
      L7_2 = GetPlayerJob
      L8_2 = L1_2
      L7_2, L8_2 = L7_2(L8_2)
      L9_2 = L3_2.owner
      if L6_2 == L9_2 then
        L9_2 = Config
        L9_2 = L9_2.Accessibility
        L9_2 = L9_2.owner
        if L9_2 then
          L9_2 = ""
          L4_2 = L9_2 or L4_2
          if not L9_2 then
          end
        end
        L9_2 = Config
        L9_2 = L9_2.Accessibility
        L9_2 = L9_2.owner
        if L9_2 then
          L9_2 = ""
          L5_2 = L9_2 or L5_2
          if not L9_2 then
          end
        end
      end
      L9_2 = Config
      L9_2 = L9_2.AllowedJobs
      L9_2 = L9_2[L7_2]
      if L9_2 then
        L9_2 = type
        L10_2 = Config
        L10_2 = L10_2.AllowedJobs
        L10_2 = L10_2[L7_2]
        L9_2 = L9_2(L10_2)
        if "number" == L9_2 then
          L9_2 = Config
          L9_2 = L9_2.AllowedJobs
          L9_2 = L9_2[L7_2]
          if L8_2 >= L9_2 then
            L9_2 = Config
            L9_2 = L9_2.Accessibility
            L9_2 = L9_2.jobs
            if L9_2 then
              L9_2 = ""
              L4_2 = L9_2 or L4_2
              if not L9_2 then
              end
            end
            L9_2 = Config
            L9_2 = L9_2.Accessibility
            L9_2 = L9_2.jobs
            if L9_2 then
              L9_2 = ""
              L5_2 = L9_2 or L5_2
              if not L9_2 then
              end
            end
          end
        else
          L9_2 = Config
          L9_2 = L9_2.Accessibility
          L9_2 = L9_2.jobs
          if L9_2 then
            L9_2 = ""
            L4_2 = L9_2 or L4_2
            if not L9_2 then
            end
          end
          L9_2 = Config
          L9_2 = L9_2.Accessibility
          L9_2 = L9_2.jobs
          if L9_2 then
            L9_2 = ""
            L5_2 = L9_2 or L5_2
            if not L9_2 then
            end
          end
        end
      end
      L9_2 = Config
      L9_2 = L9_2.Accessibility
      L9_2 = L9_2.restricted
      if L9_2 then
        if "" == L4_2 then
          L9_2 = IsPlayerAllowedScript
          L10_2 = L1_2
          L9_2 = L9_2(L10_2)
          if L9_2 then
            L9_2 = ""
            if L9_2 then
              goto lbl_188
              L4_2 = L9_2 or L4_2
            end
          end
        end
        L9_2 = Config
        L9_2 = L9_2.Text
        L9_2 = L9_2.ERROR_NO_ACCESS_PLACE
        L4_2 = L9_2 or L4_2
        if not L9_2 then
          L4_2 = "You cannot place stickers on this vehicle."
        end
        ::lbl_188::
        if "" == L5_2 then
          L9_2 = IsPlayerAllowedScript
          L10_2 = L1_2
          L9_2 = L9_2(L10_2)
          if L9_2 then
            L9_2 = ""
            if L9_2 then
              goto lbl_204
              L5_2 = L9_2 or L5_2
            end
          end
        end
        L9_2 = Config
        L9_2 = L9_2.Text
        L9_2 = L9_2.ERROR_NO_ACCESS_EDIT
        L5_2 = L9_2 or L5_2
        if not L9_2 then
          L5_2 = "You cannot edit stickers on this vehicle."
        end
      end
      ::lbl_204::
      L9_2 = CachedStickers
      L9_2 = L9_2[A0_2]
      if L9_2 then
        L9_2 = CachedStickers
        L9_2 = L9_2[A0_2]
        L9_2 = #L9_2
        L10_2 = Config
        L10_2 = L10_2.EditorOptions
        L10_2 = L10_2.maxStickers
        if not L10_2 then
          L10_2 = 6
        end
        if L9_2 >= L10_2 then
          L9_2 = Config
          L9_2 = L9_2.Text
          L9_2 = L9_2.ERROR_MAX_STICKERS
          L4_2 = L9_2 or L4_2
          if not L9_2 then
            L4_2 = "This vehicle has already reached maximum amount of stickers."
          end
        end
      else
        L9_2 = Config
        L9_2 = L9_2.Text
        L9_2 = L9_2.ERROR_NO_STICKERS
        L5_2 = L9_2 or L5_2
        if not L9_2 then
          L5_2 = "This vehicle has no stickers on it."
        end
      end
      L9_2 = TriggerClientEvent
      L10_2 = "lsrp_stickers:openMenu"
      L11_2 = L1_2
      L12_2 = A0_2
      L13_2 = L4_2
      L14_2 = L5_2
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
    else
      L6_2 = Config
      L6_2 = L6_2.Text
      L6_2 = L6_2.ERROR_NO_ACCESS_PLACE
      L4_2 = L6_2 or L4_2
      if not L6_2 then
        L4_2 = "You cannot place stickers on this vehicle."
      end
      L6_2 = Config
      L6_2 = L6_2.Text
      L6_2 = L6_2.ERROR_NO_ACCESS_EDIT
      L5_2 = L6_2 or L5_2
      if not L6_2 then
        L5_2 = "You cannot edit stickers on this vehicle."
      end
      L6_2 = TriggerClientEvent
      L7_2 = "lsrp_stickers:openMenu"
      L8_2 = L1_2
      L9_2 = A0_2
      L10_2 = L4_2
      L11_2 = L5_2
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
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
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = source
  L3_2 = NetworkGetEntityFromNetworkId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = DoesEntityExist
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = CachedStickers
    L4_2 = L4_2[A0_2]
    if L4_2 then
      L4_2 = CachedStickers
      L4_2 = L4_2[A0_2]
      L4_2 = #L4_2
      L5_2 = Config
      L5_2 = L5_2.EditorOptions
      L5_2 = L5_2.maxStickers
      if not L5_2 then
        L5_2 = 6
      end
      if L4_2 >= L5_2 then
        L4_2 = ShowNotification
        L5_2 = L2_2
        L6_2 = Config
        L6_2 = L6_2.Text
        L6_2 = L6_2.ERROR_MAX_STICKERS
        if not L6_2 then
          L6_2 = "This vehicle has already reached maximum amount of stickers."
        end
        return L4_2(L5_2, L6_2)
      end
    end
    L4_2 = GetVehicleNumberPlateText
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = L4_2
    L4_2 = L4_2.gsub
    L6_2 = "%s+"
    L7_2 = ""
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L5_2 = GetEntityModel
    L6_2 = L3_2
    L5_2 = L5_2(L6_2)
    L6_2 = ClearVehicleStickerCache
    L7_2 = L5_2
    L8_2 = L4_2
    L6_2(L7_2, L8_2)
    L6_2 = FetchVehicle
    L7_2 = L4_2
    L8_2 = L5_2
    L9_2 = L2_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L7_2 = NO_FRAMEWORK
    if L7_2 or L6_2 then
      L7_2 = NO_FRAMEWORK
      if L7_2 then
        L7_2 = StickerCounter
        A1_2.id = L7_2
        L7_2 = StickerCounter
        L7_2 = L7_2 + 1
        StickerCounter = L7_2
      else
        L7_2 = GetStickerFromConfig
        L8_2 = A1_2.name
        L7_2 = L7_2(L8_2)
        L8_2 = L7_2.premium
        if L8_2 then
          L8_2 = IsPlayerAllowedSticker
          L9_2 = L2_2
          L10_2 = L7_2.name
          L8_2 = L8_2(L9_2, L10_2)
          if not L8_2 then
            L8_2 = ShowNotification
            L9_2 = L2_2
            L10_2 = Config
            L10_2 = L10_2.Text
            L10_2 = L10_2.ERORR_NOT_ALLOWED
            if not L10_2 then
              L10_2 = "You are not allowed to place this sticker."
            end
            return L8_2(L9_2, L10_2)
          end
        end
        L8_2 = GetPlayerMoney
        L9_2 = L2_2
        L8_2 = L8_2(L9_2)
        L9_2 = L7_2.price
        if L8_2 >= L9_2 then
          L8_2 = RemovePlayerMoney
          L9_2 = L2_2
          L10_2 = L7_2.price
          L8_2(L9_2, L10_2)
          L8_2 = InsertSticker
          L9_2 = A1_2
          L10_2 = L5_2
          L11_2 = L4_2
          L8_2 = L8_2(L9_2, L10_2, L11_2)
          A1_2.id = L8_2
        else
          L8_2 = ShowNotification
          L9_2 = L2_2
          L10_2 = Config
          L10_2 = L10_2.Text
          L10_2 = L10_2.ERROR_NO_MONEY
          if not L10_2 then
            L10_2 = "You do not have enough money for this sticker."
          end
          return L8_2(L9_2, L10_2)
        end
      end
      L7_2 = CachedStickers
      L7_2 = L7_2[A0_2]
      if nil == L7_2 then
        L7_2 = CachedStickers
        L8_2 = {}
        L7_2[A0_2] = L8_2
      end
      L7_2 = CachedVehicles
      L8_2 = L4_2
      L9_2 = L5_2
      L8_2 = L8_2 .. L9_2
      L7_2 = L7_2[L8_2]
      if nil == L7_2 then
        L7_2 = CachedVehicles
        L8_2 = L4_2
        L9_2 = L5_2
        L8_2 = L8_2 .. L9_2
        L7_2[L8_2] = true
      end
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = CachedStickers
      L8_2 = L8_2[A0_2]
      L9_2 = A1_2
      L7_2(L8_2, L9_2)
      L7_2 = ShowNotification
      L8_2 = L2_2
      L9_2 = Config
      L9_2 = L9_2.Text
      L9_2 = L9_2.SUCCESS_PLACED
      if not L9_2 then
        L9_2 = "Sticker has been successfully placed."
      end
      L7_2(L8_2, L9_2)
      L7_2 = TriggerClientEvent
      L8_2 = "lsrp_stickers:placeSticker"
      L9_2 = -1
      L10_2 = A0_2
      L11_2 = A1_2
      L7_2(L8_2, L9_2, L10_2, L11_2)
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
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = source
  L3_2 = NetworkGetEntityFromNetworkId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = DoesEntityExist
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = CachedStickers
    L4_2 = L4_2[A0_2]
    L5_2 = ClearVehicleStickerCache
    L6_2 = GetEntityModel
    L7_2 = L3_2
    L6_2 = L6_2(L7_2)
    L7_2 = GetVehicleNumberPlateText
    L8_2 = L3_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L5_2 = 1
    L6_2 = #L4_2
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = L4_2[L8_2]
      L9_2 = L9_2.id
      L10_2 = A1_2.id
      if L9_2 == L10_2 then
        L4_2[L8_2] = A1_2
        L9_2 = EditSticker
        L10_2 = A1_2
        L9_2(L10_2)
        L9_2 = ShowNotification
        L10_2 = L2_2
        L11_2 = Config
        L11_2 = L11_2.Text
        L11_2 = L11_2.SUCCESS_EDITED
        if not L11_2 then
          L11_2 = "Sticker has been successfully edited."
        end
        L9_2(L10_2, L11_2)
        L9_2 = TriggerClientEvent
        L10_2 = "lsrp_stickers:editSticker"
        L11_2 = -1
        L12_2 = A0_2
        L13_2 = A1_2
        L9_2(L10_2, L11_2, L12_2, L13_2)
        break
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
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = source
  L3_2 = NetworkGetEntityFromNetworkId
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = DoesEntityExist
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = CachedStickers
    L4_2 = L4_2[A0_2]
    L5_2 = GetVehicleNumberPlateText
    L6_2 = L3_2
    L5_2 = L5_2(L6_2)
    L6_2 = L5_2
    L5_2 = L5_2.gsub
    L7_2 = "%s+"
    L8_2 = ""
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    L6_2 = GetEntityModel
    L7_2 = L3_2
    L6_2 = L6_2(L7_2)
    L7_2 = ClearVehicleStickerCache
    L8_2 = L6_2
    L9_2 = L5_2
    L7_2(L8_2, L9_2)
    L7_2 = 1
    L8_2 = #L4_2
    L9_2 = 1
    for L10_2 = L7_2, L8_2, L9_2 do
      L11_2 = L4_2[L10_2]
      L11_2 = L11_2.id
      L12_2 = A1_2.id
      if L11_2 == L12_2 then
        L11_2 = table
        L11_2 = L11_2.remove
        L12_2 = L4_2
        L13_2 = L10_2
        L11_2(L12_2, L13_2)
        L11_2 = #L4_2
        if 0 == L11_2 then
          L11_2 = CachedStickers
          L11_2[A0_2] = nil
          L11_2 = CachedVehicles
          L12_2 = L5_2
          L13_2 = L6_2
          L12_2 = L12_2 .. L13_2
          L11_2[L12_2] = nil
        end
        L11_2 = DeleteSticker
        L12_2 = A1_2
        L11_2(L12_2)
        L11_2 = ShowNotification
        L12_2 = L2_2
        L13_2 = Config
        L13_2 = L13_2.Text
        L13_2 = L13_2.SUCCESS_REMOVED
        if not L13_2 then
          L13_2 = "Sticker has been successfully removed."
        end
        L11_2(L12_2, L13_2)
        L11_2 = TriggerClientEvent
        L12_2 = "lsrp_stickers:deleteSticker"
        L13_2 = -1
        L14_2 = A0_2
        L15_2 = A1_2
        L11_2(L12_2, L13_2, L14_2, L15_2)
        break
      end
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L0_2 = {}
  while true do
    L1_2 = Wait
    L2_2 = 5000
    L1_2(L2_2)
    L1_2 = GetAllVehicles
    L1_2 = L1_2()
    L2_2 = pairs
    L3_2 = L0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = DoesEntityExist
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      if not L8_2 then
        L8_2 = ClearVehicleStickerCache
        L9_2 = L7_2.model
        L10_2 = L7_2.plate
        L8_2(L9_2, L10_2)
        L0_2[L6_2] = nil
      end
    end
    L2_2 = 50
    L3_2 = 1
    L4_2 = #L1_2
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L2_2 = L2_2 - 1
      if 0 == L2_2 then
        L2_2 = 50
        L7_2 = Wait
        L8_2 = 50
        L7_2(L8_2)
      end
      L7_2 = L1_2[L6_2]
      L8_2 = DoesEntityExist
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = GetEntityPopulationType
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if 7 == L8_2 then
          L8_2 = GetVehicleNumberPlateText
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
          L9_2 = L8_2
          L8_2 = L8_2.gsub
          L10_2 = "%s+"
          L11_2 = ""
          L8_2 = L8_2(L9_2, L10_2, L11_2)
          L9_2 = GetEntityModel
          L10_2 = L7_2
          L9_2 = L9_2(L10_2)
          L10_2 = L0_2[L7_2]
          if not L10_2 then
            L10_2 = {}
            L10_2.plate = L8_2
            L10_2.model = L9_2
            L0_2[L7_2] = L10_2
          end
          L10_2 = CachedVehicles
          L11_2 = L8_2
          L12_2 = L9_2
          L11_2 = L11_2 .. L12_2
          L10_2 = L10_2[L11_2]
          if L10_2 then
            L10_2 = FetchStickers
            L11_2 = L9_2
            L12_2 = L8_2
            L10_2 = L10_2(L11_2, L12_2)
            L11_2 = NetworkGetNetworkIdFromEntity
            L12_2 = L7_2
            L11_2 = L11_2(L12_2)
            L12_2 = #L10_2
            if 0 ~= L12_2 then
              L12_2 = CachedStickers
              L12_2 = L12_2[L11_2]
              if nil == L12_2 then
                L12_2 = CachedStickers
                L13_2 = {}
                L12_2[L11_2] = L13_2
              end
              L12_2 = CachedStickers
              L12_2 = L12_2[L11_2]
              L12_2 = #L12_2
              if 0 == L12_2 then
                L12_2 = 1
                L13_2 = #L10_2
                L14_2 = 1
                for L15_2 = L12_2, L13_2, L14_2 do
                  L16_2 = L10_2[L15_2]
                  L17_2 = GetStickerFromConfig
                  L18_2 = L16_2.name
                  L17_2 = L17_2(L18_2)
                  L18_2 = table
                  L18_2 = L18_2.insert
                  L19_2 = CachedStickers
                  L19_2 = L19_2[L11_2]
                  L20_2 = {}
                  L21_2 = L16_2.id
                  L20_2.id = L21_2
                  L20_2.mapId = 0
                  L21_2 = L17_2.dict
                  L20_2.dict = L21_2
                  L20_2.handle = 0
                  L20_2.vehicleId = L11_2
                  L21_2 = L16_2.name
                  L20_2.name = L21_2
                  L21_2 = L16_2.scale
                  L20_2.scale = L21_2
                  L21_2 = L16_2.rotation
                  L20_2.rot = L21_2
                  L21_2 = vector3
                  L22_2 = L16_2.rFromX
                  L23_2 = L16_2.rFromY
                  L24_2 = L16_2.rFromZ
                  L21_2 = L21_2(L22_2, L23_2, L24_2)
                  L20_2.rFrom = L21_2
                  L21_2 = vector3
                  L22_2 = L16_2.rToX
                  L23_2 = L16_2.rToY
                  L24_2 = L16_2.rToZ
                  L21_2 = L21_2(L22_2, L23_2, L24_2)
                  L20_2.rTo = L21_2
                  L18_2(L19_2, L20_2)
                end
              end
            end
          end
        end
      end
    end
  end
end
L0_1(L1_1)
L0_1 = CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  while true do
    L0_2 = Wait
    L1_2 = 2000
    L0_2(L1_2)
    L0_2 = GetPlayers
    L0_2 = L0_2()
    L1_2 = {}
    L2_2 = pairs
    L3_2 = CachedStickers
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = NetworkGetEntityFromNetworkId
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = DoesEntityExist
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if L9_2 then
        L9_2 = GetEntityCoords
        L10_2 = L8_2
        L9_2 = L9_2(L10_2)
        L1_2[L6_2] = L9_2
      else
        L9_2 = CachedStickers
        L9_2[L6_2] = nil
        L9_2 = TriggerClientEvent
        L10_2 = "lsrp_stickers:deleteAllStickers"
        L11_2 = -1
        L12_2 = L6_2
        L9_2(L10_2, L11_2, L12_2)
      end
    end
    L2_2 = 20
    L3_2 = 1
    L4_2 = #L0_2
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L2_2 = L2_2 - 1
      if 0 == L2_2 then
        L2_2 = 20
        L7_2 = Wait
        L8_2 = 50
        L7_2(L8_2)
      end
      L7_2 = GetPlayerPed
      L8_2 = L0_2[L6_2]
      L7_2 = L7_2(L8_2)
      L8_2 = DoesEntityExist
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = GetEntityCoords
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        L9_2 = {}
        L10_2 = 0
        L11_2 = pairs
        L12_2 = CachedStickers
        L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
        for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
          L17_2 = L1_2[L15_2]
          if L17_2 then
            L17_2 = L1_2[L15_2]
            L17_2 = L8_2 - L17_2
            L17_2 = #L17_2
            L18_2 = Config
            L18_2 = L18_2.EditorOptions
            L18_2 = L18_2.loadDistance
            if not L18_2 then
              L18_2 = 50.0
            end
            if L17_2 < L18_2 and L10_2 < 56 then
              L9_2[L15_2] = L16_2
              L18_2 = #L16_2
              L10_2 = L10_2 + L18_2
            end
          end
        end
        L11_2 = TriggerClientEvent
        L12_2 = "lsrp_stickers:refreshStickers"
        L13_2 = L0_2[L6_2]
        L14_2 = L9_2
        L11_2(L12_2, L13_2, L14_2)
      end
    end
  end
end
L0_1(L1_1)
L0_1 = CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = Wait
  L1_2 = 1000
  L0_2(L1_2)
  L0_2 = NO_FRAMEWORK
  if L0_2 then
    function L0_2(A0_3, A1_3)
      local L2_3
      L2_3 = nil
      return L2_3
    end
    FetchVehicle = L0_2
    function L0_2()
      local L0_3, L1_3
      L0_3 = {}
      return L0_3
    end
    FetchAllStickers = L0_2
    function L0_2(A0_3, A1_3)
      local L2_3
      L2_3 = {}
      return L2_3
    end
    FetchStickers = L0_2
    function L0_2(A0_3, A1_3, A2_3)
      local L3_3
      L3_3 = nil
      return L3_3
    end
    InsertSticker = L0_2
    function L0_2(A0_3)
      local L1_3
      L1_3 = nil
      return L1_3
    end
    EditSticker = L0_2
    function L0_2(A0_3)
      local L1_3
      L1_3 = nil
      return L1_3
    end
    DeleteSticker = L0_2
    L0_2 = nil
    return L0_2
  end
  L0_2 = FetchAllStickers
  L0_2 = L0_2()
  L1_2 = 1
  L2_2 = #L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = L0_2[L4_2]
    L5_2 = L5_2.name
    L6_2 = false
    L7_2 = 1
    L8_2 = Config
    L8_2 = L8_2.Stickers
    L8_2 = #L8_2
    L9_2 = 1
    for L10_2 = L7_2, L8_2, L9_2 do
      L11_2 = Config
      L11_2 = L11_2.Stickers
      L11_2 = L11_2[L10_2]
      L11_2 = L11_2.stickers
      L12_2 = 1
      L13_2 = #L11_2
      L14_2 = 1
      for L15_2 = L12_2, L13_2, L14_2 do
        L16_2 = L11_2[L15_2]
        L16_2 = L16_2.name
        if L5_2 ~= L16_2 then
          L16_2 = L11_2[L15_2]
          L16_2 = L16_2.name2
          if L5_2 ~= L16_2 then
            goto lbl_54
          end
        end
        L6_2 = true
        goto lbl_56
        ::lbl_54::
      end
    end
    ::lbl_56::
    if false == L6_2 then
      L7_2 = DeleteSticker
      L8_2 = L0_2[L4_2]
      L7_2(L8_2)
    end
  end
  L1_2 = FetchAllStickers
  L1_2 = L1_2()
  L2_2 = GetAllVehicles
  L2_2 = L2_2()
  L3_2 = {}
  L4_2 = 1
  L5_2 = #L2_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = L2_2[L7_2]
    L9_2 = DoesEntityExist
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = GetEntityPopulationType
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if 7 == L9_2 then
        L9_2 = FetchStickers
        L10_2 = GetEntityModel
        L11_2 = L8_2
        L10_2 = L10_2(L11_2)
        L11_2 = GetVehicleNumberPlateText
        L12_2 = L8_2
        L11_2 = L11_2(L12_2)
        L12_2 = L11_2
        L11_2 = L11_2.gsub
        L13_2 = "%s+"
        L14_2 = ""
        L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L11_2(L12_2, L13_2, L14_2)
        L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
        L9_2 = L9_2[1]
        if L9_2 then
          L10_2 = L9_2.plate
          L11_2 = L9_2.model
          L10_2 = L10_2 .. L11_2
          L3_2[L10_2] = L8_2
        end
      end
    end
  end
  L4_2 = 1
  L5_2 = #L1_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = L1_2[L7_2]
    L9_2 = L8_2.plate
    L10_2 = L8_2.model
    L9_2 = L9_2 .. L10_2
    L9_2 = L3_2[L9_2]
    L10_2 = CachedVehicles
    L11_2 = L8_2.plate
    L12_2 = L8_2.model
    L11_2 = L11_2 .. L12_2
    L10_2 = L10_2[L11_2]
    if nil == L10_2 then
      L10_2 = CachedVehicles
      L11_2 = L8_2.plate
      L12_2 = L8_2.model
      L11_2 = L11_2 .. L12_2
      L10_2[L11_2] = true
    end
    if L9_2 then
      L10_2 = DoesEntityExist
      L11_2 = L9_2
      L10_2 = L10_2(L11_2)
      if L10_2 then
        L10_2 = NetworkGetNetworkIdFromEntity
        L11_2 = L9_2
        L10_2 = L10_2(L11_2)
        L11_2 = GetStickerFromConfig
        L12_2 = L8_2.name
        L11_2 = L11_2(L12_2)
        L12_2 = CachedStickers
        L12_2 = L12_2[L10_2]
        if nil == L12_2 then
          L12_2 = CachedStickers
          L13_2 = {}
          L12_2[L10_2] = L13_2
        end
        L12_2 = table
        L12_2 = L12_2.insert
        L13_2 = CachedStickers
        L13_2 = L13_2[L10_2]
        L14_2 = {}
        L15_2 = L8_2.id
        L14_2.id = L15_2
        L14_2.mapId = 0
        L15_2 = L11_2.dict
        L14_2.dict = L15_2
        L14_2.handle = 0
        L14_2.vehicleId = L10_2
        L15_2 = L8_2.name
        L14_2.name = L15_2
        L15_2 = L8_2.scale
        L14_2.scale = L15_2
        L15_2 = L8_2.rotation
        L14_2.rot = L15_2
        L15_2 = vector3
        L16_2 = L8_2.rFromX
        L17_2 = L8_2.rFromY
        L18_2 = L8_2.rFromZ
        L15_2 = L15_2(L16_2, L17_2, L18_2)
        L14_2.rFrom = L15_2
        L15_2 = vector3
        L16_2 = L8_2.rToX
        L17_2 = L8_2.rToY
        L18_2 = L8_2.rToZ
        L15_2 = L15_2(L16_2, L17_2, L18_2)
        L14_2.rTo = L15_2
        L12_2(L13_2, L14_2)
      end
    end
  end
end
L0_1(L1_1)
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = tostring
  L3_2 = A0_2
  L4_2 = A1_2
  L3_2 = L3_2 .. L4_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2
  L2_2 = L2_2.gsub
  L4_2 = "%s+"
  L5_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = StickerCacheDB
  L3_2[L2_2] = nil
end
ClearVehicleStickerCache = L0_1
