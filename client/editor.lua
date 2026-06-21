local L0_1, L1_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2
  L5_2 = CreateThread
  function L6_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3
    L0_3 = Config
    L0_3 = L0_3.Controls
    L0_3 = L0_3.EDITOR_CONFIRM
    if not L0_3 then
      L0_3 = 176
    end
    L1_3 = Config
    L1_3 = L1_3.Controls
    L1_3 = L1_3.EDITOR_CANCEL
    if not L1_3 then
      L1_3 = 177
    end
    L2_3 = Config
    L2_3 = L2_3.Controls
    L2_3 = L2_3.EDITOR_REMOVE
    if not L2_3 then
      L2_3 = 178
    end
    L3_3 = Config
    L3_3 = L3_3.Controls
    L3_3 = L3_3.EDITOR_SPEED
    if not L3_3 then
      L3_3 = 155
    end
    L4_3 = Config
    L4_3 = L4_3.Controls
    L4_3 = L4_3.EDITOR_LOCK
    if not L4_3 then
      L4_3 = 171
    end
    L5_3 = Config
    L5_3 = L5_3.Controls
    L5_3 = L5_3.EDITOR_MIRROR
    if not L5_3 then
      L5_3 = 132
    end
    L6_3 = Config
    L6_3 = L6_3.Controls
    L6_3 = L6_3.EDITOR_SCALE_UP
    if not L6_3 then
      L6_3 = 181
    end
    L7_3 = Config
    L7_3 = L7_3.Controls
    L7_3 = L7_3.EDITOR_SCALE_DOWN
    if not L7_3 then
      L7_3 = 180
    end
    L8_3 = Config
    L8_3 = L8_3.Controls
    L8_3 = L8_3.EDITOR_ROTATE_LEFT
    if not L8_3 then
      L8_3 = 174
    end
    L9_3 = Config
    L9_3 = L9_3.Controls
    L9_3 = L9_3.EDITOR_ROTATE_RIGHT
    if not L9_3 then
      L9_3 = 175
    end
    L10_3 = Config
    L10_3 = L10_3.Text
    L10_3 = L10_3.EDITOR_PLACE
    if not L10_3 then
      L10_3 = "Place ($%s)"
    end
    L11_3 = Config
    L11_3 = L11_3.Text
    L11_3 = L11_3.EDITOR_SCALE
    if not L11_3 then
      L11_3 = "Scale (%sx)"
    end
    L12_3 = Config
    L12_3 = L12_3.Text
    L12_3 = L12_3.EDITOR_ROTATE
    if not L12_3 then
      L12_3 = "Rotate (%s\194\176)"
    end
    L13_3 = Config
    L13_3 = L13_3.Text
    L13_3 = L13_3.EDITOR_SPEED
    if not L13_3 then
      L13_3 = "Speed (Hold)"
    end
    L14_3 = Config
    L14_3 = L14_3.Text
    L14_3 = L14_3.EDITOR_LOCK_ON
    if not L14_3 then
      L14_3 = "Lock Position (On)"
    end
    L15_3 = Config
    L15_3 = L15_3.Text
    L15_3 = L15_3.EDITOR_LOCK_OFF
    if not L15_3 then
      L15_3 = "Lock Position (Off)"
    end
    L16_3 = Config
    L16_3 = L16_3.Text
    L16_3 = L16_3.EDITOR_MIRROR_ON
    if not L16_3 then
      L16_3 = "Mirror (On)"
    end
    L17_3 = Config
    L17_3 = L17_3.Text
    L17_3 = L17_3.EDITOR_MIRROR_OFF
    if not L17_3 then
      L17_3 = "Mirror (Off)"
    end
    L18_3 = Config
    L18_3 = L18_3.Text
    L18_3 = L18_3.EDITOR_REMOVE
    if not L18_3 then
      L18_3 = "Remove"
    end
    L19_3 = Config
    L19_3 = L19_3.Text
    L19_3 = L19_3.EDITOR_CANCEL
    if not L19_3 then
      L19_3 = "Cancel"
    end
    L20_3 = GetStickerFromConfig
    L21_3 = A1_2
    L20_3 = L20_3(L21_3)
    L21_3 = vector3
    L22_3 = 0.0
    L23_3 = 0.0
    L24_3 = 0.0
    L21_3 = L21_3(L22_3, L23_3, L24_3)
    L22_3 = vector3
    L23_3 = 0.0
    L24_3 = 0.0
    L25_3 = 0.0
    L22_3 = L22_3(L23_3, L24_3, L25_3)
    L23_3 = 0
    L24_3 = A2_2
    if L24_3 then
      L24_3 = true
      if L24_3 then
        goto lbl_142
      end
    end
    L24_3 = false
    ::lbl_142::
    L25_3 = {}
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.id
      if L26_3 then
        goto lbl_151
      end
    end
    L26_3 = 0
    ::lbl_151::
    L25_3.id = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.mapId
      if L26_3 then
        goto lbl_159
      end
    end
    L26_3 = A0_2
    ::lbl_159::
    L25_3.mapId = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.dict
      if L26_3 then
        goto lbl_167
      end
    end
    L26_3 = L20_3.dict
    ::lbl_167::
    L25_3.dict = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.handle
      if L26_3 then
        goto lbl_175
      end
    end
    L26_3 = 0
    ::lbl_175::
    L25_3.handle = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.vehicleId
      if L26_3 then
        goto lbl_185
      end
    end
    L26_3 = NetworkGetNetworkIdFromEntity
    L27_3 = A3_2
    L26_3 = L26_3(L27_3)
    ::lbl_185::
    L25_3.vehicleId = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.name
      if L26_3 then
        goto lbl_193
      end
    end
    L26_3 = L20_3.name
    ::lbl_193::
    L25_3.name = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.scale
      if L26_3 then
        goto lbl_201
      end
    end
    L26_3 = 1.0
    ::lbl_201::
    L25_3.scale = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.rot
      if L26_3 then
        goto lbl_209
      end
    end
    L26_3 = 180.0
    ::lbl_209::
    L25_3.rot = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.rFrom
      if L26_3 then
        goto lbl_221
      end
    end
    L26_3 = vector3
    L27_3 = 0.0
    L28_3 = 0.0
    L29_3 = 0.0
    L26_3 = L26_3(L27_3, L28_3, L29_3)
    ::lbl_221::
    L25_3.rFrom = L26_3
    L26_3 = A2_2
    if L26_3 then
      L26_3 = A2_2.rTo
      if L26_3 then
        goto lbl_233
      end
    end
    L26_3 = vector3
    L27_3 = 0.0
    L28_3 = 0.0
    L29_3 = 0.0
    L26_3 = L26_3(L27_3, L28_3, L29_3)
    ::lbl_233::
    L25_3.rTo = L26_3
    L26_3 = false
    L27_3 = table
    L27_3 = L27_3.clone
    L28_3 = L25_3
    L27_3 = L27_3(L28_3)
    L28_3 = GetModelDimensions
    L29_3 = GetEntityModel
    L30_3 = A3_2
    L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L29_3(L30_3)
    L28_3, L29_3 = L28_3(L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
    L30_3 = L29_3 - L28_3
    L31_3 = Tooltip
    L32_3 = L31_3
    L31_3 = L31_3.Load
    L31_3(L32_3)
    L31_3 = Tooltip
    L32_3 = L31_3
    L31_3 = L31_3.BeginMethod
    L33_3 = "SET_DATA_SLOT"
    L34_3 = 0
    L35_3 = GetControlInstructionalButton
    L36_3 = 2
    L37_3 = L0_3
    L38_3 = true
    L35_3 = L35_3(L36_3, L37_3, L38_3)
    L37_3 = L10_3
    L36_3 = L10_3.format
    L38_3 = A2_2
    if L38_3 then
      L38_3 = 0
      if L38_3 then
        goto lbl_266
      end
    end
    L38_3 = L20_3.price
    ::lbl_266::
    L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L36_3(L37_3, L38_3)
    L31_3(L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
    L31_3 = Tooltip
    L32_3 = L31_3
    L31_3 = L31_3.BeginMethod
    L33_3 = "SET_DATA_SLOT"
    L34_3 = 1
    L35_3 = GetControlInstructionalButton
    L36_3 = 2
    L37_3 = L7_3
    L38_3 = true
    L35_3 = L35_3(L36_3, L37_3, L38_3)
    L36_3 = GetControlInstructionalButton
    L37_3 = 2
    L38_3 = L6_3
    L39_3 = true
    L36_3 = L36_3(L37_3, L38_3, L39_3)
    L38_3 = L11_3
    L37_3 = L11_3.format
    L39_3 = math
    L39_3 = L39_3.floor
    L40_3 = L25_3.scale
    L40_3 = L40_3 * 100
    L39_3 = L39_3(L40_3)
    L39_3 = L39_3 / 100
    L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L37_3(L38_3, L39_3)
    L31_3(L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
    L31_3 = Tooltip
    L32_3 = L31_3
    L31_3 = L31_3.BeginMethod
    L33_3 = "SET_DATA_SLOT"
    L34_3 = 2
    L35_3 = GetControlInstructionalButton
    L36_3 = 2
    L37_3 = L9_3
    L38_3 = true
    L35_3 = L35_3(L36_3, L37_3, L38_3)
    L36_3 = GetControlInstructionalButton
    L37_3 = 2
    L38_3 = L8_3
    L39_3 = true
    L36_3 = L36_3(L37_3, L38_3, L39_3)
    L38_3 = L12_3
    L37_3 = L12_3.format
    L39_3 = math
    L39_3 = L39_3.floor
    L40_3 = L25_3.rot
    L40_3 = L40_3 * 10
    L39_3 = L39_3(L40_3)
    L39_3 = L39_3 / 10
    L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L37_3(L38_3, L39_3)
    L31_3(L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
    L31_3 = Tooltip
    L32_3 = L31_3
    L31_3 = L31_3.BeginMethod
    L33_3 = "SET_DATA_SLOT"
    L34_3 = 3
    L35_3 = GetControlInstructionalButton
    L36_3 = 2
    L37_3 = L3_3
    L38_3 = true
    L35_3 = L35_3(L36_3, L37_3, L38_3)
    L36_3 = L13_3
    L31_3(L32_3, L33_3, L34_3, L35_3, L36_3)
    L31_3 = Tooltip
    L32_3 = L31_3
    L31_3 = L31_3.BeginMethod
    L33_3 = "SET_DATA_SLOT"
    L34_3 = 4
    L35_3 = GetControlInstructionalButton
    L36_3 = 2
    L37_3 = L4_3
    L38_3 = true
    L35_3 = L35_3(L36_3, L37_3, L38_3)
    L36_3 = L14_3 or L36_3
    if not L24_3 or not L14_3 then
      L36_3 = L15_3
    end
    L31_3(L32_3, L33_3, L34_3, L35_3, L36_3)
    L31_3 = A2_2
    if nil ~= L31_3 then
      L31_3 = Tooltip
      L32_3 = L31_3
      L31_3 = L31_3.BeginMethod
      L33_3 = "SET_DATA_SLOT"
      L34_3 = 5
      L35_3 = GetControlInstructionalButton
      L36_3 = 2
      L37_3 = L2_3
      L38_3 = true
      L35_3 = L35_3(L36_3, L37_3, L38_3)
      L36_3 = L18_3
      L31_3(L32_3, L33_3, L34_3, L35_3, L36_3)
      L31_3 = Tooltip
      L32_3 = L31_3
      L31_3 = L31_3.BeginMethod
      L33_3 = "SET_DATA_SLOT"
      L34_3 = 6
      L35_3 = GetControlInstructionalButton
      L36_3 = 2
      L37_3 = L1_3
      L38_3 = true
      L35_3 = L35_3(L36_3, L37_3, L38_3)
      L36_3 = L19_3
      L31_3(L32_3, L33_3, L34_3, L35_3, L36_3)
      L31_3 = GetSurfaceNormalFromRelativeCoords
      L32_3 = A2_2.rFrom
      L33_3 = A2_2.rTo
      L34_3 = A3_2
      L31_3, L32_3 = L31_3(L32_3, L33_3, L34_3)
      L22_3 = L32_3
      L21_3 = L31_3
      L23_3 = A3_2
    else
      L31_3 = Tooltip
      L32_3 = L31_3
      L31_3 = L31_3.BeginMethod
      L33_3 = "SET_DATA_SLOT"
      L34_3 = 5
      L35_3 = GetControlInstructionalButton
      L36_3 = 2
      L37_3 = L5_3
      L38_3 = true
      L35_3 = L35_3(L36_3, L37_3, L38_3)
      L36_3 = L17_3
      L31_3(L32_3, L33_3, L34_3, L35_3, L36_3)
      L31_3 = Tooltip
      L32_3 = L31_3
      L31_3 = L31_3.BeginMethod
      L33_3 = "SET_DATA_SLOT"
      L34_3 = 6
      L35_3 = GetControlInstructionalButton
      L36_3 = 2
      L37_3 = L1_3
      L38_3 = true
      L35_3 = L35_3(L36_3, L37_3, L38_3)
      L36_3 = L19_3
      L31_3(L32_3, L33_3, L34_3, L35_3, L36_3)
    end
    L31_3 = L20_3.flip
    if L31_3 then
      L31_3 = GetUsableIdentifier
      L31_3 = L31_3()
      if nil == L31_3 then
        L32_3 = FreeIdentifier
        L33_3 = A3_2
        L32_3 = L32_3(L33_3)
        L31_3 = L32_3
      end
      L32_3 = L20_3.name2
      L27_3.name = L32_3
      L27_3.mapId = L31_3
      L32_3 = ActiveIdentifiers
      L33_3 = L27_3.mapId
      L32_3[L33_3] = true
    end
    L31_3 = PatchDecalDiffuseMap
    L32_3 = L25_3.mapId
    L33_3 = L25_3.dict
    L34_3 = L25_3.name
    L31_3(L32_3, L33_3, L34_3)
    L31_3 = PatchDecalDiffuseMap
    L32_3 = L27_3.mapId
    L33_3 = L27_3.dict
    L34_3 = L27_3.name
    L31_3(L32_3, L33_3, L34_3)
    while true do
      L31_3 = Wait
      L32_3 = 0
      L31_3(L32_3)
      L31_3 = Tooltip
      L32_3 = L31_3
      L31_3 = L31_3.Draw
      L31_3(L32_3)
      L31_3 = ShapeTestFromGameplayCam
      L31_3, L32_3, L33_3, L34_3, L35_3 = L31_3()
      L36_3 = 0
      L37_3 = 0
      L38_3 = 0
      L39_3 = 0
      L40_3 = 0
      L41_3 = GetEntityCoords
      L42_3 = PlayerPedId
      L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L42_3()
      L41_3 = L41_3(L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
      L42_3 = GetEntityCoords
      L43_3 = A3_2
      L42_3 = L42_3(L43_3)
      if L24_3 then
        L43_3 = L21_3
        L44_3 = L22_3
        L35_3 = L23_3
        L34_3 = L44_3
        L33_3 = L43_3
      end
      L43_3 = Config
      L43_3 = L43_3.EnableDebug
      if L43_3 then
        L43_3 = DrawLine
        L44_3 = L33_3.x
        L45_3 = L33_3.y
        L46_3 = L33_3.z
        L47_3 = L41_3.x
        L48_3 = L41_3.y
        L49_3 = L41_3.z
        L50_3 = 255
        L51_3 = 0
        L52_3 = 0
        L53_3 = 255.0
        L43_3(L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3)
      end
      L43_3 = A3_2
      if L43_3 == L35_3 then
        L43_3 = GetEntityCoords
        L44_3 = L35_3
        L43_3 = L43_3(L44_3)
        L44_3 = GetEntityForwardVector
        L45_3 = L35_3
        L44_3 = L44_3(L45_3)
        L45_3 = norm
        L46_3 = L33_3 - L43_3
        L45_3 = L45_3(L46_3)
        if L26_3 then
          L46_3 = math
          L46_3 = L46_3.abs
          L47_3 = L44_3.x
          L48_3 = L45_3.x
          L47_3 = L47_3 * L48_3
          L48_3 = L44_3.y
          L49_3 = L45_3.y
          L48_3 = L48_3 * L49_3
          L47_3 = L47_3 + L48_3
          L48_3 = L44_3.z
          L49_3 = L45_3.z
          L48_3 = L48_3 * L49_3
          L47_3 = L47_3 + L48_3
          L46_3 = L46_3(L47_3)
          L47_3 = 0.95
          if L46_3 <= L47_3 then
            L46_3 = 0
            L47_3 = L44_3.y
            L48_3 = L45_3.x
            L47_3 = L47_3 * L48_3
            L48_3 = L44_3.x
            L49_3 = L45_3.y
            L48_3 = L48_3 * L49_3
            if L47_3 < L48_3 then
              L47_3 = _ENV
              L48_3 = "StartExpensiveSynchronousShapeTestLosProbe"
              L47_3 = L47_3[L48_3]
              L48_3 = L33_3.x
              L49_3 = L44_3.y
              L50_3 = L30_3.x
              L49_3 = L49_3 * L50_3
              L48_3 = L48_3 + L49_3
              L49_3 = L33_3.y
              L50_3 = L44_3.x
              L51_3 = L30_3.x
              L50_3 = L50_3 * L51_3
              L49_3 = L49_3 - L50_3
              L50_3 = L33_3.z
              L51_3 = L33_3.x
              L52_3 = L33_3.y
              L53_3 = L33_3.z
              L54_3 = 2
              L55_3 = nil
              L56_3 = 4
              L47_3 = L47_3(L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
              L46_3 = L47_3
            else
              L47_3 = _ENV
              L48_3 = "StartExpensiveSynchronousShapeTestLosProbe"
              L47_3 = L47_3[L48_3]
              L48_3 = L33_3.x
              L49_3 = L44_3.y
              L50_3 = L30_3.x
              L49_3 = L49_3 * L50_3
              L48_3 = L48_3 - L49_3
              L49_3 = L33_3.y
              L50_3 = L44_3.x
              L51_3 = L30_3.x
              L50_3 = L50_3 * L51_3
              L49_3 = L49_3 + L50_3
              L50_3 = L33_3.z
              L51_3 = L33_3.x
              L52_3 = L33_3.y
              L53_3 = L33_3.z
              L54_3 = 2
              L55_3 = nil
              L56_3 = 4
              L47_3 = L47_3(L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
              L46_3 = L47_3
            end
            L47_3 = GetShapeTestResult
            L48_3 = L46_3
            L47_3, L48_3, L49_3, L50_3, L51_3 = L47_3(L48_3)
            L40_3 = L51_3
            L39_3 = L50_3
            L38_3 = L49_3
            L37_3 = L48_3
            L36_3 = L47_3
          elseif false == L24_3 then
            L26_3 = false
            L46_3 = Tooltip
            L47_3 = L46_3
            L46_3 = L46_3.BeginMethod
            L48_3 = "SET_DATA_SLOT"
            L49_3 = 5
            L50_3 = GetControlInstructionalButton
            L51_3 = 2
            L52_3 = L5_3
            L53_3 = true
            L50_3 = L50_3(L51_3, L52_3, L53_3)
            L51_3 = L17_3
            L46_3(L47_3, L48_3, L49_3, L50_3, L51_3)
            L46_3 = RemoveSticker
            L47_3 = L27_3
            L46_3(L47_3)
          end
        end
        L46_3 = L20_3.flip
        if L46_3 and false == L24_3 then
          L46_3 = L44_3.y
          L47_3 = L45_3.x
          L46_3 = L46_3 * L47_3
          L47_3 = L44_3.x
          L48_3 = L45_3.y
          L47_3 = L47_3 * L48_3
          if L46_3 < L47_3 then
            if L26_3 then
              L46_3 = L20_3.name
              L25_3.name = L46_3
              L46_3 = L20_3.name2
              L27_3.name = L46_3
              L46_3 = PatchDecalDiffuseMap
              L47_3 = L25_3.mapId
              L48_3 = L25_3.dict
              L49_3 = L25_3.name
              L46_3(L47_3, L48_3, L49_3)
              L46_3 = PatchDecalDiffuseMap
              L47_3 = L27_3.mapId
              L48_3 = L27_3.dict
              L49_3 = L27_3.name
              L46_3(L47_3, L48_3, L49_3)
            else
              L46_3 = L20_3.name
              L25_3.name = L46_3
              L46_3 = PatchDecalDiffuseMap
              L47_3 = L25_3.mapId
              L48_3 = L25_3.dict
              L49_3 = L25_3.name
              L46_3(L47_3, L48_3, L49_3)
            end
          elseif L26_3 then
            L46_3 = L20_3.name2
            L25_3.name = L46_3
            L46_3 = L20_3.name
            L27_3.name = L46_3
            L46_3 = PatchDecalDiffuseMap
            L47_3 = L25_3.mapId
            L48_3 = L25_3.dict
            L49_3 = L25_3.name
            L46_3(L47_3, L48_3, L49_3)
            L46_3 = PatchDecalDiffuseMap
            L47_3 = L27_3.mapId
            L48_3 = L27_3.dict
            L49_3 = L27_3.name
            L46_3(L47_3, L48_3, L49_3)
          else
            L46_3 = L20_3.name2
            L25_3.name = L46_3
            L46_3 = PatchDecalDiffuseMap
            L47_3 = L25_3.mapId
            L48_3 = L25_3.dict
            L49_3 = L25_3.name
            L46_3(L47_3, L48_3, L49_3)
          end
        end
        if 0 ~= L37_3 then
          L46_3 = IsDecalAlive
          L47_3 = L27_3.handle
          L46_3 = L46_3(L47_3)
          if false == L46_3 then
            L46_3 = GetStickerResolution
            L47_3 = L27_3.name
            L48_3 = L27_3.dict
            L49_3 = L25_3.scale
            L46_3, L47_3 = L46_3(L47_3, L48_3, L49_3)
            L48_3 = AddSticker
            L49_3 = L38_3
            L50_3 = -L39_3
            L51_3 = L25_3.rot
            L52_3 = 180.0
            if L51_3 >= L52_3 then
              L51_3 = L25_3.rot
              L52_3 = 540.0
              L51_3 = L52_3 - L51_3
              if L51_3 then
                goto lbl_690
              end
            end
            L51_3 = L25_3.rot
            L52_3 = 180.0
            L51_3 = L52_3 - L51_3
            ::lbl_690::
            L52_3 = L46_3
            L53_3 = L47_3
            L54_3 = 1.0
            L55_3 = L27_3.mapId
            L56_3 = L40_3
            L48_3 = L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
            L27_3.handle = L48_3
          end
        end
        if false == L24_3 then
          L46_3 = L21_3 - L33_3
          L46_3 = #L46_3
          L47_3 = 0.001
          if L46_3 > L47_3 then
            L46_3 = GetStickerResolution
            L47_3 = L25_3.name
            L48_3 = L25_3.dict
            L49_3 = L25_3.scale
            L46_3, L47_3 = L46_3(L47_3, L48_3, L49_3)
            if 0 ~= L37_3 then
              L48_3 = GetStickerResolution
              L49_3 = L27_3.name
              L50_3 = L27_3.dict
              L51_3 = L25_3.scale
              L48_3, L49_3 = L48_3(L49_3, L50_3, L51_3)
              L50_3 = RemoveSticker
              L51_3 = L27_3
              L50_3(L51_3)
              L50_3 = AddSticker
              L51_3 = L38_3
              L52_3 = -L39_3
              L53_3 = L25_3.rot
              L54_3 = 180.0
              if L53_3 >= L54_3 then
                L53_3 = L25_3.rot
                L54_3 = 540.0
                L53_3 = L54_3 - L53_3
                if L53_3 then
                  goto lbl_737
                end
              end
              L53_3 = L25_3.rot
              L54_3 = 180.0
              L53_3 = L54_3 - L53_3
              ::lbl_737::
              L54_3 = L48_3
              L55_3 = L49_3
              L56_3 = 1.0
              L57_3 = L27_3.mapId
              L58_3 = L40_3
              L50_3 = L50_3(L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
              L27_3.handle = L50_3
            end
            L48_3 = RemoveSticker
            L49_3 = L25_3
            L48_3(L49_3)
            L48_3 = AddSticker
            L49_3 = L33_3
            L50_3 = -L34_3
            L51_3 = L25_3.rot
            L52_3 = L46_3
            L53_3 = L47_3
            L54_3 = 1.0
            L55_3 = L25_3.mapId
            L56_3 = L35_3
            L48_3 = L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
            L25_3.handle = L48_3
          end
        end
        L46_3 = IsControlJustPressed
        L47_3 = 2
        L48_3 = L0_3
        L46_3 = L46_3(L47_3, L48_3)
        if L46_3 then
          L46_3 = Tooltip
          L47_3 = L46_3
          L46_3 = L46_3.Release
          L46_3(L47_3)
          L46_3 = RemoveSticker
          L47_3 = L27_3
          L46_3(L47_3)
          L46_3 = RemoveSticker
          L47_3 = L25_3
          L46_3(L47_3)
          L46_3 = GetOffsetFromEntityGivenWorldCoords
          L47_3 = L35_3
          L48_3 = L33_3.x
          L49_3 = L34_3.x
          L48_3 = L48_3 + L49_3
          L49_3 = L33_3.y
          L50_3 = L34_3.y
          L49_3 = L49_3 + L50_3
          L50_3 = L33_3.z
          L51_3 = L34_3.z
          L50_3 = L50_3 + L51_3
          L46_3 = L46_3(L47_3, L48_3, L49_3, L50_3)
          L25_3.rFrom = L46_3
          L46_3 = GetOffsetFromEntityGivenWorldCoords
          L47_3 = L35_3
          L48_3 = L33_3.x
          L49_3 = L34_3.x
          L48_3 = L48_3 - L49_3
          L49_3 = L33_3.y
          L50_3 = L34_3.y
          L49_3 = L49_3 - L50_3
          L50_3 = L33_3.z
          L51_3 = L34_3.z
          L50_3 = L50_3 - L51_3
          L46_3 = L46_3(L47_3, L48_3, L49_3, L50_3)
          L25_3.rTo = L46_3
          if L26_3 and 0 ~= L37_3 then
            L46_3 = L25_3.scale
            L27_3.scale = L46_3
            L46_3 = L25_3.rot
            L47_3 = 180.0
            if L46_3 >= L47_3 then
              L46_3 = L25_3.rot
              L47_3 = 540.0
              L46_3 = L47_3 - L46_3
              if L46_3 then
                goto lbl_825
              end
            end
            L46_3 = L25_3.rot
            L47_3 = 180.0
            L46_3 = L47_3 - L46_3
            ::lbl_825::
            L27_3.rot = L46_3
            L46_3 = GetOffsetFromEntityGivenWorldCoords
            L47_3 = L40_3
            L48_3 = L38_3.x
            L49_3 = L39_3.x
            L48_3 = L48_3 + L49_3
            L49_3 = L38_3.y
            L50_3 = L39_3.y
            L49_3 = L49_3 + L50_3
            L50_3 = L38_3.z
            L51_3 = L39_3.z
            L50_3 = L50_3 + L51_3
            L46_3 = L46_3(L47_3, L48_3, L49_3, L50_3)
            L27_3.rFrom = L46_3
            L46_3 = GetOffsetFromEntityGivenWorldCoords
            L47_3 = L40_3
            L48_3 = L38_3.x
            L49_3 = L39_3.x
            L48_3 = L48_3 - L49_3
            L49_3 = L38_3.y
            L50_3 = L39_3.y
            L49_3 = L49_3 - L50_3
            L50_3 = L38_3.z
            L51_3 = L39_3.z
            L50_3 = L50_3 - L51_3
            L46_3 = L46_3(L47_3, L48_3, L49_3, L50_3)
            L27_3.rTo = L46_3
            L46_3 = A4_2
            L47_3 = {}
            L48_3 = L25_3
            L49_3 = L27_3
            L47_3[1] = L48_3
            L47_3[2] = L49_3
            return L46_3(L47_3)
          else
            L46_3 = A4_2
            L47_3 = {}
            L48_3 = L25_3
            L47_3[1] = L48_3
            return L46_3(L47_3)
          end
        end
        L46_3 = IsControlPressed
        L47_3 = 2
        L48_3 = L6_3
        L46_3 = L46_3(L47_3, L48_3)
        if L46_3 then
          L46_3 = IsControlPressed
          L47_3 = 2
          L48_3 = L3_3
          L46_3 = L46_3(L47_3, L48_3)
          if L46_3 then
            L46_3 = L25_3.scale
            L47_3 = Config
            L47_3 = L47_3.EditorOptions
            L47_3 = L47_3.maxScale
            if not L47_3 then
              L47_3 = 6.0
            end
            L47_3 = L47_3 - 0.01
            if L46_3 >= L47_3 then
              L46_3 = Config
              L46_3 = L46_3.EditorOptions
              L46_3 = L46_3.minScale
              if not L46_3 then
                L46_3 = 0.1
              end
              L25_3.scale = L46_3
            else
              L46_3 = L25_3.scale
              L46_3 = L46_3 + 0.01
              L25_3.scale = L46_3
            end
          else
            L46_3 = L25_3.scale
            L47_3 = Config
            L47_3 = L47_3.EditorOptions
            L47_3 = L47_3.maxScale
            if not L47_3 then
              L47_3 = 6.0
            end
            L47_3 = L47_3 - 0.1
            if L46_3 >= L47_3 then
              L46_3 = Config
              L46_3 = L46_3.EditorOptions
              L46_3 = L46_3.minScale
              if not L46_3 then
                L46_3 = 0.1
              end
              L25_3.scale = L46_3
            else
              L46_3 = L25_3.scale
              L46_3 = L46_3 + 0.1
              L25_3.scale = L46_3
            end
          end
          L46_3 = GetStickerResolution
          L47_3 = L25_3.name
          L48_3 = L25_3.dict
          L49_3 = L25_3.scale
          L46_3, L47_3 = L46_3(L47_3, L48_3, L49_3)
          L48_3 = Tooltip
          L49_3 = L48_3
          L48_3 = L48_3.BeginMethod
          L50_3 = "SET_DATA_SLOT"
          L51_3 = 1
          L52_3 = GetControlInstructionalButton
          L53_3 = 2
          L54_3 = L7_3
          L55_3 = true
          L52_3 = L52_3(L53_3, L54_3, L55_3)
          L53_3 = GetControlInstructionalButton
          L54_3 = 2
          L55_3 = L6_3
          L56_3 = true
          L53_3 = L53_3(L54_3, L55_3, L56_3)
          L55_3 = L11_3
          L54_3 = L11_3.format
          L56_3 = math
          L56_3 = L56_3.floor
          L57_3 = L25_3.scale
          L57_3 = L57_3 * 100
          L56_3 = L56_3(L57_3)
          L56_3 = L56_3 / 100
          L54_3, L55_3, L56_3, L57_3, L58_3 = L54_3(L55_3, L56_3)
          L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
          if 0 ~= L37_3 then
            L48_3 = GetStickerResolution
            L49_3 = L27_3.name
            L50_3 = L27_3.dict
            L51_3 = L25_3.scale
            L48_3, L49_3 = L48_3(L49_3, L50_3, L51_3)
            L50_3 = RemoveSticker
            L51_3 = L27_3
            L50_3(L51_3)
            L50_3 = AddSticker
            L51_3 = L38_3
            L52_3 = -L39_3
            L53_3 = L25_3.rot
            L54_3 = 180.0
            if L53_3 >= L54_3 then
              L53_3 = L25_3.rot
              L54_3 = 540.0
              L53_3 = L54_3 - L53_3
              if L53_3 then
                goto lbl_990
              end
            end
            L53_3 = L25_3.rot
            L54_3 = 180.0
            L53_3 = L54_3 - L53_3
            ::lbl_990::
            L54_3 = L48_3
            L55_3 = L49_3
            L56_3 = 1.0
            L57_3 = L27_3.mapId
            L58_3 = L40_3
            L50_3 = L50_3(L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
            L27_3.handle = L50_3
          end
          L48_3 = RemoveSticker
          L49_3 = L25_3
          L48_3(L49_3)
          L48_3 = AddSticker
          L49_3 = L33_3
          L50_3 = -L34_3
          L51_3 = L25_3.rot
          L52_3 = L46_3
          L53_3 = L47_3
          L54_3 = 1.0
          L55_3 = L25_3.mapId
          L56_3 = L35_3
          L48_3 = L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
          L25_3.handle = L48_3
        end
        L46_3 = IsControlPressed
        L47_3 = 2
        L48_3 = L7_3
        L46_3 = L46_3(L47_3, L48_3)
        if L46_3 then
          L46_3 = IsControlPressed
          L47_3 = 2
          L48_3 = L3_3
          L46_3 = L46_3(L47_3, L48_3)
          if L46_3 then
            L46_3 = L25_3.scale
            L47_3 = Config
            L47_3 = L47_3.EditorOptions
            L47_3 = L47_3.minScale
            if not L47_3 then
              L47_3 = 0.1
            end
            L47_3 = L47_3 + 0.01
            if L46_3 <= L47_3 then
              L46_3 = Config
              L46_3 = L46_3.EditorOptions
              L46_3 = L46_3.maxScale
              if not L46_3 then
                L46_3 = 6.0
              end
              L25_3.scale = L46_3
            else
              L46_3 = L25_3.scale
              L46_3 = L46_3 - 0.01
              L25_3.scale = L46_3
            end
          else
            L46_3 = L25_3.scale
            L47_3 = Config
            L47_3 = L47_3.EditorOptions
            L47_3 = L47_3.minScale
            if not L47_3 then
              L47_3 = 0.1
            end
            L47_3 = L47_3 + 0.1
            if L46_3 <= L47_3 then
              L46_3 = Config
              L46_3 = L46_3.EditorOptions
              L46_3 = L46_3.maxScale
              if not L46_3 then
                L46_3 = 6.0
              end
              L25_3.scale = L46_3
            else
              L46_3 = L25_3.scale
              L46_3 = L46_3 - 0.1
              L25_3.scale = L46_3
            end
          end
          L46_3 = GetStickerResolution
          L47_3 = L25_3.name
          L48_3 = L25_3.dict
          L49_3 = L25_3.scale
          L46_3, L47_3 = L46_3(L47_3, L48_3, L49_3)
          L48_3 = Tooltip
          L49_3 = L48_3
          L48_3 = L48_3.BeginMethod
          L50_3 = "SET_DATA_SLOT"
          L51_3 = 1
          L52_3 = GetControlInstructionalButton
          L53_3 = 2
          L54_3 = L7_3
          L55_3 = true
          L52_3 = L52_3(L53_3, L54_3, L55_3)
          L53_3 = GetControlInstructionalButton
          L54_3 = 2
          L55_3 = L6_3
          L56_3 = true
          L53_3 = L53_3(L54_3, L55_3, L56_3)
          L55_3 = L11_3
          L54_3 = L11_3.format
          L56_3 = math
          L56_3 = L56_3.floor
          L57_3 = L25_3.scale
          L57_3 = L57_3 * 100
          L56_3 = L56_3(L57_3)
          L56_3 = L56_3 / 100
          L54_3, L55_3, L56_3, L57_3, L58_3 = L54_3(L55_3, L56_3)
          L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
          if 0 ~= L37_3 then
            L48_3 = GetStickerResolution
            L49_3 = L27_3.name
            L50_3 = L27_3.dict
            L51_3 = L25_3.scale
            L48_3, L49_3 = L48_3(L49_3, L50_3, L51_3)
            L50_3 = RemoveSticker
            L51_3 = L27_3
            L50_3(L51_3)
            L50_3 = AddSticker
            L51_3 = L38_3
            L52_3 = -L39_3
            L53_3 = L25_3.rot
            L54_3 = 180.0
            if L53_3 >= L54_3 then
              L53_3 = L25_3.rot
              L54_3 = 540.0
              L53_3 = L54_3 - L53_3
              if L53_3 then
                goto lbl_1127
              end
            end
            L53_3 = L25_3.rot
            L54_3 = 180.0
            L53_3 = L54_3 - L53_3
            ::lbl_1127::
            L54_3 = L48_3
            L55_3 = L49_3
            L56_3 = 1.0
            L57_3 = L27_3.mapId
            L58_3 = L40_3
            L50_3 = L50_3(L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
            L27_3.handle = L50_3
          end
          L48_3 = RemoveSticker
          L49_3 = L25_3
          L48_3(L49_3)
          L48_3 = AddSticker
          L49_3 = L33_3
          L50_3 = -L34_3
          L51_3 = L25_3.rot
          L52_3 = L46_3
          L53_3 = L47_3
          L54_3 = 1.0
          L55_3 = L25_3.mapId
          L56_3 = L35_3
          L48_3 = L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
          L25_3.handle = L48_3
        end
        L46_3 = IsControlPressed
        L47_3 = 2
        L48_3 = L9_3
        L46_3 = L46_3(L47_3, L48_3)
        if L46_3 then
          L46_3 = IsControlPressed
          L47_3 = 2
          L48_3 = L3_3
          L46_3 = L46_3(L47_3, L48_3)
          if L46_3 then
            L46_3 = L25_3.rot
            L47_3 = 359.9
            if L46_3 >= L47_3 then
              L25_3.rot = 0.0
            else
              L46_3 = L25_3.rot
              L46_3 = L46_3 + 0.1
              L25_3.rot = L46_3
            end
          else
            L46_3 = L25_3.rot
            L47_3 = 359.0
            if L46_3 >= L47_3 then
              L25_3.rot = 0.0
            else
              L46_3 = L25_3.rot
              L46_3 = L46_3 + 1.0
              L25_3.rot = L46_3
            end
          end
          L46_3 = GetStickerResolution
          L47_3 = L25_3.name
          L48_3 = L25_3.dict
          L49_3 = L25_3.scale
          L46_3, L47_3 = L46_3(L47_3, L48_3, L49_3)
          L48_3 = Tooltip
          L49_3 = L48_3
          L48_3 = L48_3.BeginMethod
          L50_3 = "SET_DATA_SLOT"
          L51_3 = 2
          L52_3 = GetControlInstructionalButton
          L53_3 = 2
          L54_3 = L9_3
          L55_3 = true
          L52_3 = L52_3(L53_3, L54_3, L55_3)
          L53_3 = GetControlInstructionalButton
          L54_3 = 2
          L55_3 = L8_3
          L56_3 = true
          L53_3 = L53_3(L54_3, L55_3, L56_3)
          L55_3 = L12_3
          L54_3 = L12_3.format
          L56_3 = math
          L56_3 = L56_3.floor
          L57_3 = L25_3.rot
          L57_3 = L57_3 * 10
          L56_3 = L56_3(L57_3)
          L56_3 = L56_3 / 10
          L54_3, L55_3, L56_3, L57_3, L58_3 = L54_3(L55_3, L56_3)
          L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
          if 0 ~= L37_3 then
            L48_3 = GetStickerResolution
            L49_3 = L27_3.name
            L50_3 = L27_3.dict
            L51_3 = L25_3.scale
            L48_3, L49_3 = L48_3(L49_3, L50_3, L51_3)
            L50_3 = RemoveSticker
            L51_3 = L27_3
            L50_3(L51_3)
            L50_3 = AddSticker
            L51_3 = L38_3
            L52_3 = -L39_3
            L53_3 = L25_3.rot
            L54_3 = 180.0
            if L53_3 >= L54_3 then
              L53_3 = L25_3.rot
              L54_3 = 540.0
              L53_3 = L54_3 - L53_3
              if L53_3 then
                goto lbl_1238
              end
            end
            L53_3 = L25_3.rot
            L54_3 = 180.0
            L53_3 = L54_3 - L53_3
            ::lbl_1238::
            L54_3 = L48_3
            L55_3 = L49_3
            L56_3 = 1.0
            L57_3 = L27_3.mapId
            L58_3 = L40_3
            L50_3 = L50_3(L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
            L27_3.handle = L50_3
          end
          L48_3 = RemoveSticker
          L49_3 = L25_3
          L48_3(L49_3)
          L48_3 = AddSticker
          L49_3 = L33_3
          L50_3 = -L34_3
          L51_3 = L25_3.rot
          L52_3 = L46_3
          L53_3 = L47_3
          L54_3 = 1.0
          L55_3 = L25_3.mapId
          L56_3 = L35_3
          L48_3 = L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
          L25_3.handle = L48_3
        end
        L46_3 = IsControlPressed
        L47_3 = 2
        L48_3 = L8_3
        L46_3 = L46_3(L47_3, L48_3)
        if L46_3 then
          L46_3 = IsControlPressed
          L47_3 = 2
          L48_3 = L3_3
          L46_3 = L46_3(L47_3, L48_3)
          if L46_3 then
            L46_3 = L25_3.rot
            L47_3 = 0.1
            if L46_3 <= L47_3 then
              L25_3.rot = 360.0
            else
              L46_3 = L25_3.rot
              L46_3 = L46_3 - 0.1
              L25_3.rot = L46_3
            end
          else
            L46_3 = L25_3.rot
            if L46_3 <= 1.0 then
              L25_3.rot = 360.0
            else
              L46_3 = L25_3.rot
              L46_3 = L46_3 - 1.0
              L25_3.rot = L46_3
            end
          end
          L46_3 = GetStickerResolution
          L47_3 = L25_3.name
          L48_3 = L25_3.dict
          L49_3 = L25_3.scale
          L46_3, L47_3 = L46_3(L47_3, L48_3, L49_3)
          L48_3 = Tooltip
          L49_3 = L48_3
          L48_3 = L48_3.BeginMethod
          L50_3 = "SET_DATA_SLOT"
          L51_3 = 2
          L52_3 = GetControlInstructionalButton
          L53_3 = 2
          L54_3 = L9_3
          L55_3 = true
          L52_3 = L52_3(L53_3, L54_3, L55_3)
          L53_3 = GetControlInstructionalButton
          L54_3 = 2
          L55_3 = L8_3
          L56_3 = true
          L53_3 = L53_3(L54_3, L55_3, L56_3)
          L55_3 = L12_3
          L54_3 = L12_3.format
          L56_3 = math
          L56_3 = L56_3.floor
          L57_3 = L25_3.rot
          L57_3 = L57_3 * 10
          L56_3 = L56_3(L57_3)
          L56_3 = L56_3 / 10
          L54_3, L55_3, L56_3, L57_3, L58_3 = L54_3(L55_3, L56_3)
          L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
          if 0 ~= L37_3 then
            L48_3 = GetStickerResolution
            L49_3 = L27_3.name
            L50_3 = L27_3.dict
            L51_3 = L25_3.scale
            L48_3, L49_3 = L48_3(L49_3, L50_3, L51_3)
            L50_3 = RemoveSticker
            L51_3 = L27_3
            L50_3(L51_3)
            L50_3 = AddSticker
            L51_3 = L38_3
            L52_3 = -L39_3
            L53_3 = L25_3.rot
            L54_3 = 180.0
            if L53_3 >= L54_3 then
              L53_3 = L25_3.rot
              L54_3 = 540.0
              L53_3 = L54_3 - L53_3
              if L53_3 then
                goto lbl_1348
              end
            end
            L53_3 = L25_3.rot
            L54_3 = 180.0
            L53_3 = L54_3 - L53_3
            ::lbl_1348::
            L54_3 = L48_3
            L55_3 = L49_3
            L56_3 = 1.0
            L57_3 = L27_3.mapId
            L58_3 = L40_3
            L50_3 = L50_3(L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
            L27_3.handle = L50_3
          end
          L48_3 = RemoveSticker
          L49_3 = L25_3
          L48_3(L49_3)
          L48_3 = AddSticker
          L49_3 = L33_3
          L50_3 = -L34_3
          L51_3 = L25_3.rot
          L52_3 = L46_3
          L53_3 = L47_3
          L54_3 = 1.0
          L55_3 = L25_3.mapId
          L56_3 = L35_3
          L48_3 = L48_3(L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3)
          L25_3.handle = L48_3
        end
        L46_3 = L33_3
        L47_3 = L34_3
        L23_3 = L35_3
        L22_3 = L47_3
        L21_3 = L46_3
      else
        L43_3 = IsControlJustPressed
        L44_3 = 2
        L45_3 = L0_3
        L43_3 = L43_3(L44_3, L45_3)
        if L43_3 then
          if 0 == L32_3 then
            L43_3 = ShowNotification
            L44_3 = Config
            L44_3 = L44_3.Text
            L44_3 = L44_3.ERROR_WRONG_ENTITY
            if not L44_3 then
              L44_3 = "You can place stickers on vehicles only."
            end
            L43_3(L44_3)
          else
            L43_3 = ShowNotification
            L44_3 = Config
            L44_3 = L44_3.Text
            L44_3 = L44_3.ERROR_NO_ACCESS_PLACE
            if not L44_3 then
              L44_3 = "You cannot place stickers on this vehicle."
            end
            L43_3(L44_3)
          end
        end
        L43_3 = RemoveSticker
        L44_3 = L27_3
        L43_3(L44_3)
        L43_3 = RemoveSticker
        L44_3 = L25_3
        L43_3(L44_3)
      end
      L43_3 = IsControlJustPressed
      L44_3 = 2
      L45_3 = L4_3
      L43_3 = L43_3(L44_3, L45_3)
      if L43_3 then
        L24_3 = not L24_3
        L43_3 = Tooltip
        L44_3 = L43_3
        L43_3 = L43_3.BeginMethod
        L45_3 = "SET_DATA_SLOT"
        L46_3 = 4
        L47_3 = GetControlInstructionalButton
        L48_3 = 2
        L49_3 = L4_3
        L50_3 = true
        L47_3 = L47_3(L48_3, L49_3, L50_3)
        L48_3 = L14_3 or L48_3
        if not L24_3 or not L14_3 then
          L48_3 = L15_3
        end
        L43_3(L44_3, L45_3, L46_3, L47_3, L48_3)
      end
      L43_3 = IsControlJustPressed
      L44_3 = 2
      L45_3 = L5_3
      L43_3 = L43_3(L44_3, L45_3)
      if L43_3 then
        L43_3 = A2_2
        if nil == L43_3 then
          L26_3 = not L26_3
          if L26_3 then
            L43_3 = Tooltip
            L44_3 = L43_3
            L43_3 = L43_3.BeginMethod
            L45_3 = "SET_DATA_SLOT"
            L46_3 = 0
            L47_3 = GetControlInstructionalButton
            L48_3 = 2
            L49_3 = L0_3
            L50_3 = true
            L47_3 = L47_3(L48_3, L49_3, L50_3)
            L49_3 = L10_3
            L48_3 = L10_3.format
            L50_3 = L20_3.price
            L50_3 = L50_3 * 2
            L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L48_3(L49_3, L50_3)
            L43_3(L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
            L43_3 = Tooltip
            L44_3 = L43_3
            L43_3 = L43_3.BeginMethod
            L45_3 = "SET_DATA_SLOT"
            L46_3 = 5
            L47_3 = GetControlInstructionalButton
            L48_3 = 2
            L49_3 = L5_3
            L50_3 = true
            L47_3 = L47_3(L48_3, L49_3, L50_3)
            L48_3 = L16_3
            L43_3(L44_3, L45_3, L46_3, L47_3, L48_3)
          else
            L43_3 = Tooltip
            L44_3 = L43_3
            L43_3 = L43_3.BeginMethod
            L45_3 = "SET_DATA_SLOT"
            L46_3 = 0
            L47_3 = GetControlInstructionalButton
            L48_3 = 2
            L49_3 = L0_3
            L50_3 = true
            L47_3 = L47_3(L48_3, L49_3, L50_3)
            L49_3 = L10_3
            L48_3 = L10_3.format
            L50_3 = L20_3.price
            L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3 = L48_3(L49_3, L50_3)
            L43_3(L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3)
            L43_3 = Tooltip
            L44_3 = L43_3
            L43_3 = L43_3.BeginMethod
            L45_3 = "SET_DATA_SLOT"
            L46_3 = 5
            L47_3 = GetControlInstructionalButton
            L48_3 = 2
            L49_3 = L5_3
            L50_3 = true
            L47_3 = L47_3(L48_3, L49_3, L50_3)
            L48_3 = L17_3
            L43_3(L44_3, L45_3, L46_3, L47_3, L48_3)
            L43_3 = RemoveSticker
            L44_3 = L27_3
            L43_3(L44_3)
          end
        end
      end
      L43_3 = IsControlJustPressed
      L44_3 = 2
      L45_3 = L1_3
      L43_3 = L43_3(L44_3, L45_3)
      if L43_3 then
        L43_3 = Tooltip
        L44_3 = L43_3
        L43_3 = L43_3.Release
        L43_3(L44_3)
        L43_3 = RemoveSticker
        L44_3 = L27_3
        L43_3(L44_3)
        L43_3 = RemoveSticker
        L44_3 = L25_3
        L43_3(L44_3)
        L43_3 = A2_2
        if nil ~= L43_3 then
          L43_3 = ApplySticker
          L44_3 = A2_2
          L45_3 = 1.0
          L43_3(L44_3, L45_3)
        end
        L43_3 = A4_2
        L44_3 = nil
        return L43_3(L44_3)
      end
      L43_3 = IsControlJustPressed
      L44_3 = 2
      L45_3 = L2_3
      L43_3 = L43_3(L44_3, L45_3)
      if L43_3 then
        L43_3 = A2_2
        if nil ~= L43_3 then
          L43_3 = Tooltip
          L44_3 = L43_3
          L43_3 = L43_3.Release
          L43_3(L44_3)
          L43_3 = RemoveSticker
          L44_3 = L25_3
          L43_3(L44_3)
          L43_3 = A4_2
          L44_3 = {}
          return L43_3(L44_3)
        end
      end
      L43_3 = L42_3 - L41_3
      L43_3 = #L43_3
      L44_3 = Config
      L44_3 = L44_3.EditorOptions
      L44_3 = L44_3.maxDistance
      if L43_3 > L44_3 then
        L43_3 = Tooltip
        L44_3 = L43_3
        L43_3 = L43_3.Release
        L43_3(L44_3)
        L43_3 = RemoveSticker
        L44_3 = L27_3
        L43_3(L44_3)
        L43_3 = RemoveSticker
        L44_3 = L25_3
        L43_3(L44_3)
        L43_3 = ShowNotification
        L44_3 = Config
        L44_3 = L44_3.Text
        L44_3 = L44_3.ERROR_OUT_OF_RANGE
        if not L44_3 then
          L44_3 = "You went too far from the vehicle."
        end
        L43_3(L44_3)
        L43_3 = A2_2
        if nil ~= L43_3 then
          L43_3 = ApplySticker
          L44_3 = A2_2
          L45_3 = 1.0
          L43_3(L44_3, L45_3)
        end
        L43_3 = A4_2
        L44_3 = nil
        return L43_3(L44_3)
      end
    end
  end
  L5_2(L6_2)
end
StartEditor = L0_1
