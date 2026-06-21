local L0_1, L1_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2)
  local L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2
  L8_2 = GetEntityForwardVector
  L9_2 = A7_2
  L8_2 = L8_2(L9_2)
  L9_2 = A1_2.x
  L10_2 = A1_2.x
  L9_2 = L9_2 * L10_2
  L10_2 = A1_2.y
  L11_2 = A1_2.y
  L10_2 = L10_2 * L11_2
  L9_2 = L9_2 + L10_2
  L10_2 = A1_2.z
  L11_2 = A1_2.z
  L10_2 = L10_2 * L11_2
  L9_2 = L9_2 + L10_2
  L10_2 = L8_2.x
  L11_2 = A1_2.x
  L10_2 = L10_2 * L11_2
  L11_2 = L8_2.y
  L12_2 = A1_2.y
  L11_2 = L11_2 * L12_2
  L10_2 = L10_2 + L11_2
  L11_2 = L8_2.z
  L12_2 = A1_2.z
  L11_2 = L11_2 * L12_2
  L10_2 = L10_2 + L11_2
  L11_2 = L10_2 / L9_2
  L11_2 = A1_2 * L11_2
  L11_2 = -L11_2
  L11_2 = L11_2 + L8_2
  L12_2 = quat
  L13_2 = A2_2
  L14_2 = A1_2
  L12_2 = L12_2(L13_2, L14_2)
  L12_2 = L12_2 * L11_2
  L13_2 = AddDecal
  L14_2 = A6_2
  L15_2 = A0_2.x
  L16_2 = A0_2.y
  L17_2 = A0_2.z
  L18_2 = A1_2.x
  L19_2 = A1_2.y
  L20_2 = A1_2.z
  L21_2 = L12_2.x
  L22_2 = L12_2.y
  L23_2 = L12_2.z
  L24_2 = A3_2
  L25_2 = A4_2
  L26_2 = 1.0
  L27_2 = 1.0
  L28_2 = 1.0
  L29_2 = A5_2
  L30_2 = math
  L30_2 = L30_2.maxinteger
  L30_2 = L30_2 + 0.0
  L31_2 = 1
  L32_2 = 0
  L33_2 = true
  return L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2)
end
AddSticker = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = NetworkGetEntityFromNetworkId
  L3_2 = A0_2.vehicleId
  L2_2 = L2_2(L3_2)
  L3_2 = GetStickerResolution
  L4_2 = A0_2.name
  L5_2 = A0_2.dict
  L6_2 = A0_2.scale
  L3_2, L4_2 = L3_2(L4_2, L5_2, L6_2)
  L5_2 = GetSurfaceNormalFromRelativeCoords
  L6_2 = A0_2.rFrom
  L7_2 = A0_2.rTo
  L8_2 = L2_2
  L5_2, L6_2 = L5_2(L6_2, L7_2, L8_2)
  L7_2 = PatchDecalDiffuseMap
  L8_2 = A0_2.mapId
  L9_2 = A0_2.dict
  L10_2 = A0_2.name
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = AddSticker
  L8_2 = L5_2
  L9_2 = -L6_2
  L10_2 = A0_2.rot
  L11_2 = L3_2
  L12_2 = L4_2
  L13_2 = A1_2
  L14_2 = A0_2.mapId
  L15_2 = L2_2
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  A0_2.handle = L7_2
end
ApplySticker = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.handle
  L2_2 = IsDecalAlive
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = CreateThread
    function L3_2()
      local L0_3, L1_3
      repeat
        L0_3 = RemoveDecal
        L1_3 = L1_2
        L0_3(L1_3)
        L0_3 = Wait
        L1_3 = 0
        L0_3(L1_3)
        L0_3 = IsDecalAlive
        L1_3 = L1_2
        L0_3 = L0_3(L1_3)
      until 1 ~= L0_3
    end
    L2_2(L3_2)
  end
end
RemoveSticker = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = GetTextureResolution
  L3_2 = A1_2
  L4_2 = A0_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = #L2_2
  L3_2 = L3_2 > 10.0
  return L3_2
end
DoesStickerTextureExist = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = GetTextureResolution
  L4_2 = A1_2
  L5_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2.x
  L5_2 = L3_2.y
  L4_2 = L4_2 + L5_2
  L5_2 = L3_2.x
  L5_2 = L5_2 / L4_2
  L5_2 = L5_2 * A2_2
  L6_2 = L3_2.y
  L6_2 = L6_2 / L4_2
  L6_2 = L6_2 * A2_2
  return L5_2, L6_2
end
GetStickerResolution = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
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
      L10_2 = L9_2.name
      if L10_2 ~= A0_2 then
        L10_2 = L9_2.name2
        if L10_2 ~= A0_2 then
          goto lbl_27
        end
      end
      do return L9_2 end
      ::lbl_27::
    end
  end
end
GetStickerFromConfig = L0_1
