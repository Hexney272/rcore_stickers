local L0_1, L1_1
L0_1 = {}
Tooltip = L0_1
L0_1 = Tooltip
function L1_1(A0_2, A1_2, ...)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = {}
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = ...
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L2_2[8] = L10_2
  L3_2 = BeginScaleformMovieMethod
  L4_2 = A0_2.handle
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = 1
  L4_2 = #L2_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L2_2[L6_2]
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "number" == L8_2 then
      L8_2 = math
      L8_2 = L8_2.type
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        goto lbl_29
      end
    end
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    ::lbl_29::
    if "string" == L8_2 then
      L9_2 = _ENV
      L10_2 = "ScaleformMovieMethodAddParamPlayerNameString"
      L9_2 = L9_2[L10_2]
      L10_2 = L7_2
      L9_2(L10_2)
    elseif "boolean" == L8_2 then
      L9_2 = ScaleformMovieMethodAddParamBool
      L10_2 = L7_2
      L9_2(L10_2)
    elseif "integer" == L8_2 then
      L9_2 = ScaleformMovieMethodAddParamInt
      L10_2 = L7_2
      L9_2(L10_2)
    elseif "float" == L8_2 then
      L9_2 = ScaleformMovieMethodAddParamFloat
      L10_2 = L7_2
      L9_2(L10_2)
    end
  end
  L3_2 = EndScaleformMovieMethod
  L3_2()
end
L0_1.BeginMethod = L1_1
L0_1 = Tooltip
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = SetScaleformMovieAsNoLongerNeeded
  L2_2 = A0_2.handle
  L1_2(L2_2)
  A0_2.handle = 0
end
L0_1.Release = L1_1
L0_1 = Tooltip
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A0_2
  L1_2 = A0_2.BeginMethod
  L3_2 = "DRAW_INSTRUCTIONAL_BUTTONS"
  L1_2(L2_2, L3_2)
  L1_2 = DrawScaleformMovieFullscreen
  L2_2 = A0_2.handle
  L3_2 = 255
  L4_2 = 255
  L5_2 = 255
  L6_2 = 255
  L7_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
end
L0_1.Draw = L1_1
L0_1 = Tooltip
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = RequestScaleformMovie
  L2_2 = "INSTRUCTIONAL_BUTTONS"
  L1_2 = L1_2(L2_2)
  A0_2.handle = L1_2
  while true do
    L1_2 = HasScaleformMovieLoaded
    L2_2 = A0_2.handle
    L1_2 = L1_2(L2_2)
    if L1_2 then
      break
    end
    L1_2 = Wait
    L2_2 = 0
    L1_2(L2_2)
  end
  L2_2 = A0_2
  L1_2 = A0_2.BeginMethod
  L3_2 = "CLEAR_ALL"
  L4_2 = 200
  L1_2(L2_2, L3_2, L4_2)
  L2_2 = A0_2
  L1_2 = A0_2.BeginMethod
  L3_2 = "SET_BACKGROUND_COLOUR"
  L4_2 = 0
  L5_2 = 0
  L6_2 = 0
  L7_2 = 64
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
end
L0_1.Load = L1_1
L0_1 = Tooltip
function L1_1(A0_2)
  local L1_2, L2_2
  L1_2 = SetScaleformMovieAsNoLongerNeeded
  L2_2 = A0_2.handle
  L1_2(L2_2)
end
L0_1.__gc = L1_1
