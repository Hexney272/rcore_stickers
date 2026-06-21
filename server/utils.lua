local L0_1, L1_1
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
