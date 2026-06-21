local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1
L0_1 = {}
function L1_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Config
  L1_2 = L1_2.ErrorDebug
  if L1_2 then
    L1_2 = L0_1
    L2_2 = {}
    L2_2.stepCount = 0
    L3_2 = {}
    L2_2.stepData = L3_2
    L1_2[A0_2] = L2_2
  end
end
StartDebugSession = L1_1
function L1_1(A0_2)
  local L1_2
  L1_2 = Config
  L1_2 = L1_2.ErrorDebug
  if L1_2 then
    L1_2 = L0_1
    L1_2[A0_2] = nil
  end
end
DestoryDebugSession = L1_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = Config
  L2_2 = L2_2.ErrorDebug
  if L2_2 then
    L2_2 = L0_1
    L2_2 = L2_2[A0_2]
    if L2_2 then
      L3_2 = L2_2.stepCount
      L3_2 = L3_2 + 1
      L2_2.stepCount = L3_2
      L3_2 = L2_2.stepData
      L4_2 = L2_2.stepCount
      L3_2[L4_2] = A1_2
    end
  end
end
DebugRecordStep = L1_1
function L1_1(A0_2, ...)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Config
  L1_2 = L1_2.EnableDebug
  if L1_2 then
    L1_2 = print
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = A0_2
    L4_2 = ...
    L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2)
    L1_2(L2_2, L3_2, L4_2)
  end
end
DebugLog = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = L0_1
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L2_2 = ipairs
    L3_2 = L1_2.stepData
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = print
      L9_2 = "^0Step name: ^1"
      L10_2 = tostring
      L11_2 = L7_2
      L10_2 = L10_2(L11_2)
      L9_2 = L9_2 .. L10_2
      L8_2(L9_2)
    end
    L2_2 = print
    L3_2 = "^5=====^0"
    L2_2(L3_2)
    L2_2 = print
    L3_2 = "^0Last step before the error: ^1"
    L4_2 = tostring
    L5_2 = L1_2.stepData
    L6_2 = L1_2.stepData
    L6_2 = #L6_2
    L5_2 = L5_2[L6_2]
    L4_2 = L4_2(L5_2)
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
  end
end
DisplayCurrentRecordSteps = L1_1
L1_1 = Config
L1_1 = L1_1.ErrorDebug
if L1_1 then
  L1_1 = AddEventHandler
  L2_1 = RegisterNetEvent
  L3_1 = CreateThread
  L4_1 = RegisterCommand
  L5_1 = RegisterNUICallback
  function L6_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = L4_1
    L3_2 = A0_2
    function L4_2(A0_3, A1_3, A2_3)
      local L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
      L3_3 = xpcall
      function L4_3()
        local L0_4, L1_4, L2_4, L3_4
        L0_4 = A1_2
        L1_4 = A0_3
        L2_4 = A1_3
        L3_4 = A2_3
        L0_4(L1_4, L2_4, L3_4)
      end
      L5_3 = debug
      L5_3 = L5_3.traceback
      L3_3, L4_3 = L3_3(L4_3, L5_3)
      if not L3_3 then
        L5_3 = {}
        L5_3[1] = A0_3
        L5_3[2] = A1_3
        L5_3[3] = A2_3
        L6_3 = print
        L7_3 = "^5=========================^0"
        L6_3(L7_3)
        L6_3 = print
        L7_3 = "^2Error in: ^1RegisterCommand^0"
        L6_3(L7_3)
        L6_3 = print
        L7_3 = "^2Event name: ^1"
        L8_3 = A0_2
        L9_3 = "^0"
        L7_3 = L7_3 .. L8_3 .. L9_3
        L6_3(L7_3)
        L6_3 = print
        L7_3 = "^5=========================^0"
        L6_3(L7_3)
        L6_3 = DisplayCurrentRecordSteps
        L7_3 = A0_2
        L6_3(L7_3)
        L6_3 = print
        L7_3 = "^5=========================^0"
        L6_3(L7_3)
        L6_3 = pairs
        L7_3 = L5_3
        L6_3, L7_3, L8_3, L9_3 = L6_3(L7_3)
        for L10_3, L11_3 in L6_3, L7_3, L8_3, L9_3 do
          L12_3 = print
          L13_3 = "^0Argument key: ^1"
          L14_3 = L10_3
          L13_3 = L13_3 .. L14_3
          L12_3(L13_3)
          L12_3 = print
          L13_3 = "^0Argument value type: ^1"
          L14_3 = type
          L15_3 = L11_3
          L14_3 = L14_3(L15_3)
          L13_3 = L13_3 .. L14_3
          L12_3(L13_3)
          L12_3 = print
          L13_3 = " "
          L12_3(L13_3)
          L12_3 = type
          L13_3 = L11_3
          L12_3 = L12_3(L13_3)
          if "table" == L12_3 then
            L12_3 = print
            L13_3 = "^0Argument value: ^1"
            L14_3 = tostring
            L15_3 = L11_3
            L14_3 = L14_3(L15_3)
            L13_3 = L13_3 .. L14_3
            L12_3(L13_3)
            L12_3 = Dump
            L13_3 = L11_3
            L12_3(L13_3)
          else
            L12_3 = print
            L13_3 = "^0Argument value: ^1"
            L14_3 = tostring
            L15_3 = L11_3
            L14_3 = L14_3(L15_3)
            L13_3 = L13_3 .. L14_3
            L12_3(L13_3)
          end
          L12_3 = print
          L13_3 = "^5=====^0"
          L12_3(L13_3)
        end
        L6_3 = print
        L7_3 = "^5=========================^0"
        L6_3(L7_3)
        L6_3 = print
        L7_3 = L4_3
        L6_3(L7_3)
        L6_3 = print
        L7_3 = "^5=========================^0"
        L6_3(L7_3)
      end
    end
    L2_2(L3_2, L4_2)
  end
  RegisterCommand = L6_1
  function L6_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    if not A1_2 then
      L2_2 = L2_1
      L3_2 = A0_2
      L2_2(L3_2)
      return
    end
    L2_2 = L2_1
    L3_2 = A0_2
    function L4_2(A0_3, A1_3, A2_3, A3_3, A4_3, A5_3, A6_3, A7_3, A8_3, A9_3, A10_3, A11_3)
      local L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3
      L12_3 = xpcall
      function L13_3()
        local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
        L0_4 = A1_2
        L1_4 = A0_3
        L2_4 = A1_3
        L3_4 = A2_3
        L4_4 = A3_3
        L5_4 = A4_3
        L6_4 = A5_3
        L7_4 = A6_3
        L8_4 = A7_3
        L9_4 = A8_3
        L10_4 = A9_3
        L11_4 = A10_3
        L12_4 = A11_3
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
      end
      L14_3 = debug
      L14_3 = L14_3.traceback
      L12_3, L13_3 = L12_3(L13_3, L14_3)
      if not L12_3 then
        L14_3 = {}
        L14_3[1] = A0_3
        L14_3[2] = A1_3
        L14_3[3] = A2_3
        L14_3[4] = A3_3
        L14_3[5] = A4_3
        L14_3[6] = A5_3
        L14_3[7] = A6_3
        L14_3[8] = A7_3
        L14_3[9] = A8_3
        L14_3[10] = A9_3
        L14_3[11] = A10_3
        L14_3[12] = A11_3
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^2Error in: ^1RegisterNetEvent^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^2Event name: ^1"
        L17_3 = A0_2
        L18_3 = "^0"
        L16_3 = L16_3 .. L17_3 .. L18_3
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = DisplayCurrentRecordSteps
        L16_3 = A0_2
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = pairs
        L16_3 = L14_3
        L15_3, L16_3, L17_3, L18_3 = L15_3(L16_3)
        for L19_3, L20_3 in L15_3, L16_3, L17_3, L18_3 do
          L21_3 = print
          L22_3 = "^0Argument key: ^1"
          L23_3 = L19_3
          L22_3 = L22_3 .. L23_3
          L21_3(L22_3)
          L21_3 = print
          L22_3 = "^0Argument value type: ^1"
          L23_3 = type
          L24_3 = L20_3
          L23_3 = L23_3(L24_3)
          L22_3 = L22_3 .. L23_3
          L21_3(L22_3)
          L21_3 = print
          L22_3 = " "
          L21_3(L22_3)
          L21_3 = type
          L22_3 = L20_3
          L21_3 = L21_3(L22_3)
          if "table" == L21_3 then
            L21_3 = print
            L22_3 = "^0Argument value: ^1"
            L23_3 = tostring
            L24_3 = L20_3
            L23_3 = L23_3(L24_3)
            L22_3 = L22_3 .. L23_3
            L21_3(L22_3)
            L21_3 = Dump
            L22_3 = L20_3
            L21_3(L22_3)
          else
            L21_3 = print
            L22_3 = "^0Argument value: ^1"
            L23_3 = tostring
            L24_3 = L20_3
            L23_3 = L23_3(L24_3)
            L22_3 = L22_3 .. L23_3
            L21_3(L22_3)
          end
          L21_3 = print
          L22_3 = "^5=====^0"
          L21_3(L22_3)
        end
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = L13_3
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = ""
        L16_3 = 1
        L17_3 = 12
        L18_3 = 1
        for L19_3 = L16_3, L17_3, L18_3 do
          L20_3 = L14_3[L19_3]
          L21_3 = type
          L22_3 = L20_3
          L21_3 = L21_3(L22_3)
          if "table" == L21_3 then
            L21_3 = L15_3
            L22_3 = Dump
            L23_3 = L20_3
            L24_3 = true
            L22_3 = L22_3(L23_3, L24_3)
            L23_3 = ","
            L21_3 = L21_3 .. L22_3 .. L23_3
            L15_3 = L21_3
          else
            L21_3 = type
            L22_3 = L20_3
            L21_3 = L21_3(L22_3)
            if "string" == L21_3 then
              L21_3 = L15_3
              L22_3 = "'"
              L23_3 = L20_3
              L24_3 = "',"
              L21_3 = L21_3 .. L22_3 .. L23_3 .. L24_3
              L15_3 = L21_3
            else
              L21_3 = L15_3
              L22_3 = tostring
              L23_3 = L20_3
              L22_3 = L22_3(L23_3)
              L23_3 = ","
              L21_3 = L21_3 .. L22_3 .. L23_3
              L15_3 = L21_3
            end
          end
        end
        L16_3 = print
        L17_3 = "^0Replication trigger event:"
        L16_3(L17_3)
        L16_3 = print
        L17_3 = "^1TriggerEvent('"
        L18_3 = A0_2
        L19_3 = "', "
        L21_3 = L15_3
        L20_3 = L15_3.gsub
        L22_3 = "\n"
        L23_3 = ""
        L20_3 = L20_3(L21_3, L22_3, L23_3)
        L21_3 = L20_3
        L20_3 = L20_3.sub
        L22_3 = 1
        L23_3 = -2
        L20_3 = L20_3(L21_3, L22_3, L23_3)
        L21_3 = ")"
        L17_3 = L17_3 .. L18_3 .. L19_3 .. L20_3 .. L21_3
        L16_3(L17_3)
        L16_3 = print
        L17_3 = "^5=========================^0"
        L16_3(L17_3)
      end
    end
    L2_2(L3_2, L4_2)
  end
  RegisterNetEvent = L6_1
  function L6_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = L5_1
    L3_2 = A0_2
    function L4_2(A0_3, A1_3, A2_3, A3_3, A4_3, A5_3, A6_3, A7_3, A8_3, A9_3, A10_3, A11_3)
      local L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3
      L12_3 = xpcall
      function L13_3()
        local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
        L0_4 = A1_2
        L1_4 = A0_3
        L2_4 = A1_3
        L3_4 = A2_3
        L4_4 = A3_3
        L5_4 = A4_3
        L6_4 = A5_3
        L7_4 = A6_3
        L8_4 = A7_3
        L9_4 = A8_3
        L10_4 = A9_3
        L11_4 = A10_3
        L12_4 = A11_3
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
      end
      L14_3 = debug
      L14_3 = L14_3.traceback
      L12_3, L13_3 = L12_3(L13_3, L14_3)
      if not L12_3 then
        L14_3 = {}
        L14_3[1] = A0_3
        L14_3[2] = A1_3
        L14_3[3] = A2_3
        L14_3[4] = A3_3
        L14_3[5] = A4_3
        L14_3[6] = A5_3
        L14_3[7] = A6_3
        L14_3[8] = A7_3
        L14_3[9] = A8_3
        L14_3[10] = A9_3
        L14_3[11] = A10_3
        L14_3[12] = A11_3
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^2Error in: ^1RegisterNUICallback^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^2Event name: ^1"
        L17_3 = A0_2
        L18_3 = "^0"
        L16_3 = L16_3 .. L17_3 .. L18_3
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = DisplayCurrentRecordSteps
        L16_3 = A0_2
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = pairs
        L16_3 = L14_3
        L15_3, L16_3, L17_3, L18_3 = L15_3(L16_3)
        for L19_3, L20_3 in L15_3, L16_3, L17_3, L18_3 do
          L21_3 = print
          L22_3 = "^0Argument key: ^1"
          L23_3 = L19_3
          L22_3 = L22_3 .. L23_3
          L21_3(L22_3)
          L21_3 = print
          L22_3 = "^0Argument value type: ^1"
          L23_3 = type
          L24_3 = L20_3
          L23_3 = L23_3(L24_3)
          L22_3 = L22_3 .. L23_3
          L21_3(L22_3)
          L21_3 = print
          L22_3 = " "
          L21_3(L22_3)
          L21_3 = type
          L22_3 = L20_3
          L21_3 = L21_3(L22_3)
          if "table" == L21_3 then
            L21_3 = print
            L22_3 = "^0Argument value: ^1"
            L23_3 = tostring
            L24_3 = L20_3
            L23_3 = L23_3(L24_3)
            L22_3 = L22_3 .. L23_3
            L21_3(L22_3)
            L21_3 = Dump
            L22_3 = L20_3
            L21_3(L22_3)
          else
            L21_3 = print
            L22_3 = "^0Argument value: ^1"
            L23_3 = tostring
            L24_3 = L20_3
            L23_3 = L23_3(L24_3)
            L22_3 = L22_3 .. L23_3
            L21_3(L22_3)
          end
          L21_3 = print
          L22_3 = "^5=====^0"
          L21_3(L22_3)
        end
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = L13_3
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = ""
        L16_3 = 1
        L17_3 = 12
        L18_3 = 1
        for L19_3 = L16_3, L17_3, L18_3 do
          L20_3 = L14_3[L19_3]
          L21_3 = type
          L22_3 = L20_3
          L21_3 = L21_3(L22_3)
          if "table" == L21_3 then
            L21_3 = L15_3
            L22_3 = Dump
            L23_3 = L20_3
            L24_3 = true
            L22_3 = L22_3(L23_3, L24_3)
            L23_3 = ","
            L21_3 = L21_3 .. L22_3 .. L23_3
            L15_3 = L21_3
          else
            L21_3 = type
            L22_3 = L20_3
            L21_3 = L21_3(L22_3)
            if "string" == L21_3 then
              L21_3 = L15_3
              L22_3 = "'"
              L23_3 = L20_3
              L24_3 = "',"
              L21_3 = L21_3 .. L22_3 .. L23_3 .. L24_3
              L15_3 = L21_3
            else
              L21_3 = L15_3
              L22_3 = tostring
              L23_3 = L20_3
              L22_3 = L22_3(L23_3)
              L23_3 = ","
              L21_3 = L21_3 .. L22_3 .. L23_3
              L15_3 = L21_3
            end
          end
        end
        L16_3 = print
        L17_3 = "^0Replication trigger event:"
        L16_3(L17_3)
        L16_3 = print
        L17_3 = "^1TriggerEvent('__cfx_nui:"
        L18_3 = A0_2
        L19_3 = "', "
        L21_3 = L15_3
        L20_3 = L15_3.gsub
        L22_3 = "\n"
        L23_3 = ""
        L20_3 = L20_3(L21_3, L22_3, L23_3)
        L21_3 = L20_3
        L20_3 = L20_3.sub
        L22_3 = 1
        L23_3 = -2
        L20_3 = L20_3(L21_3, L22_3, L23_3)
        L21_3 = ")"
        L17_3 = L17_3 .. L18_3 .. L19_3 .. L20_3 .. L21_3
        L16_3(L17_3)
        L16_3 = print
        L17_3 = "^5=========================^0"
        L16_3(L17_3)
      end
    end
    L2_2(L3_2, L4_2)
  end
  RegisterNUICallback = L6_1
  function L6_1(A0_2, A1_2)
    local L2_2, L3_2
    L2_2 = L3_1
    function L3_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = xpcall
      L1_3 = A0_2
      L2_3 = debug
      L2_3 = L2_3.traceback
      L0_3, L1_3 = L0_3(L1_3, L2_3)
      if not L0_3 then
        L2_3 = print
        L3_3 = "========================="
        L2_3(L3_3)
        L2_3 = print
        L3_3 = "^2Error in: ^1CreateThread^0"
        L2_3(L3_3)
        L2_3 = print
        L3_3 = "^1"
        L4_3 = A1_2
        if not L4_3 then
          L4_3 = "non defined"
        end
        L5_3 = "^0"
        L3_3 = L3_3 .. L4_3 .. L5_3
        L2_3(L3_3)
        L2_3 = print
        L3_3 = "========================="
        L2_3(L3_3)
        L2_3 = DisplayCurrentRecordSteps
        L3_3 = A1_2
        L2_3(L3_3)
        L2_3 = print
        L3_3 = "^5=========================^0"
        L2_3(L3_3)
        L2_3 = print
        L3_3 = L1_3
        L2_3(L3_3)
        L2_3 = print
        L3_3 = "========================="
        L2_3(L3_3)
      end
    end
    L2_2(L3_2)
  end
  CreateThread = L6_1
  function L6_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = L1_1
    L3_2 = A0_2
    function L4_2(A0_3, A1_3, A2_3, A3_3, A4_3, A5_3, A6_3, A7_3, A8_3, A9_3, A10_3, A11_3)
      local L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3
      L12_3 = xpcall
      function L13_3()
        local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
        L0_4 = A1_2
        L1_4 = A0_3
        L2_4 = A1_3
        L3_4 = A2_3
        L4_4 = A3_3
        L5_4 = A4_3
        L6_4 = A5_3
        L7_4 = A6_3
        L8_4 = A7_3
        L9_4 = A8_3
        L10_4 = A9_3
        L11_4 = A10_3
        L12_4 = A11_3
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
      end
      L14_3 = debug
      L14_3 = L14_3.traceback
      L12_3, L13_3 = L12_3(L13_3, L14_3)
      if not L12_3 then
        L14_3 = {}
        L14_3[1] = A0_3
        L14_3[2] = A1_3
        L14_3[3] = A2_3
        L14_3[4] = A3_3
        L14_3[5] = A4_3
        L14_3[6] = A5_3
        L14_3[7] = A6_3
        L14_3[8] = A7_3
        L14_3[9] = A8_3
        L14_3[10] = A9_3
        L14_3[11] = A10_3
        L14_3[12] = A11_3
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^2Error in: ^1AddEventHandler^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^2Event name: ^1"
        L17_3 = A0_2
        L18_3 = "^0"
        L16_3 = L16_3 .. L17_3 .. L18_3
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = DisplayCurrentRecordSteps
        L16_3 = A0_2
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = pairs
        L16_3 = L14_3
        L15_3, L16_3, L17_3, L18_3 = L15_3(L16_3)
        for L19_3, L20_3 in L15_3, L16_3, L17_3, L18_3 do
          L21_3 = print
          L22_3 = "^0Argument key: ^1"
          L23_3 = L19_3
          L22_3 = L22_3 .. L23_3
          L21_3(L22_3)
          L21_3 = print
          L22_3 = "^0Argument value type: ^1"
          L23_3 = type
          L24_3 = L20_3
          L23_3 = L23_3(L24_3)
          L22_3 = L22_3 .. L23_3
          L21_3(L22_3)
          L21_3 = print
          L22_3 = " "
          L21_3(L22_3)
          L21_3 = type
          L22_3 = L20_3
          L21_3 = L21_3(L22_3)
          if "table" == L21_3 then
            L21_3 = print
            L22_3 = "^0Argument value: ^1"
            L23_3 = tostring
            L24_3 = L20_3
            L23_3 = L23_3(L24_3)
            L22_3 = L22_3 .. L23_3
            L21_3(L22_3)
            L21_3 = Dump
            L22_3 = L20_3
            L21_3(L22_3)
          else
            L21_3 = print
            L22_3 = "^0Argument value: ^1"
            L23_3 = tostring
            L24_3 = L20_3
            L23_3 = L23_3(L24_3)
            L22_3 = L22_3 .. L23_3
            L21_3(L22_3)
          end
          L21_3 = print
          L22_3 = "^5=====^0"
          L21_3(L22_3)
        end
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = print
        L16_3 = L13_3
        L15_3(L16_3)
        L15_3 = print
        L16_3 = "^5=========================^0"
        L15_3(L16_3)
        L15_3 = ""
        L16_3 = 1
        L17_3 = 12
        L18_3 = 1
        for L19_3 = L16_3, L17_3, L18_3 do
          L20_3 = L14_3[L19_3]
          L21_3 = type
          L22_3 = L20_3
          L21_3 = L21_3(L22_3)
          if "table" == L21_3 then
            L21_3 = L15_3
            L22_3 = Dump
            L23_3 = L20_3
            L24_3 = true
            L22_3 = L22_3(L23_3, L24_3)
            L23_3 = ","
            L21_3 = L21_3 .. L22_3 .. L23_3
            L15_3 = L21_3
          else
            L21_3 = type
            L22_3 = L20_3
            L21_3 = L21_3(L22_3)
            if "string" == L21_3 then
              L21_3 = L15_3
              L22_3 = "'"
              L23_3 = L20_3
              L24_3 = "',"
              L21_3 = L21_3 .. L22_3 .. L23_3 .. L24_3
              L15_3 = L21_3
            else
              L21_3 = L15_3
              L22_3 = tostring
              L23_3 = L20_3
              L22_3 = L22_3(L23_3)
              L23_3 = ","
              L21_3 = L21_3 .. L22_3 .. L23_3
              L15_3 = L21_3
            end
          end
        end
        L16_3 = print
        L17_3 = "^0Replication trigger event:"
        L16_3(L17_3)
        L16_3 = print
        L17_3 = "^1TriggerEvent('"
        L18_3 = A0_2
        L19_3 = "', "
        L21_3 = L15_3
        L20_3 = L15_3.gsub
        L22_3 = "\n"
        L23_3 = ""
        L20_3 = L20_3(L21_3, L22_3, L23_3)
        L21_3 = L20_3
        L20_3 = L20_3.sub
        L22_3 = 1
        L23_3 = -2
        L20_3 = L20_3(L21_3, L22_3, L23_3)
        L21_3 = ")"
        L17_3 = L17_3 .. L18_3 .. L19_3 .. L20_3 .. L21_3
        L16_3(L17_3)
        L16_3 = print
        L17_3 = "^5=========================^0"
        L16_3(L17_3)
      end
    end
    L2_2(L3_2, L4_2)
  end
  AddEventHandler = L6_1
end
L1_1 = Config
L1_1 = L1_1.EnableDebug
if L1_1 then
  L1_1 = AddDecal
  function L2_1(...)
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = L1_1
    L1_2, L2_2, L3_2 = ...
    L0_2 = L0_2(L1_2, L2_2, L3_2)
    L1_2 = print
    L2_2 = "Sticker ID:"
    L3_2 = L0_2
    L1_2(L2_2, L3_2)
    return L0_2
  end
  AddDecal = L2_1
  L2_1 = RegisterCommand
  L3_1 = "clearalldecals"
  function L4_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    L3_2 = PlayerPedId
    L3_2 = L3_2()
    L4_2 = GetEntityCoords
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = 50.0
    L6_2 = RemoveDecalsInRange
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L10_2 = L5_2
    L6_2(L7_2, L8_2, L9_2, L10_2)
    L6_2 = EnumerateObjects
    L6_2, L7_2, L8_2, L9_2 = L6_2()
    for L10_2 in L6_2, L7_2, L8_2, L9_2 do
      L11_2 = GetEntityCoords
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      L12_2 = L4_2 - L11_2
      L12_2 = #L12_2
      if L5_2 > L12_2 then
        L13_2 = RemoveDecalsFromObject
        L14_2 = L10_2
        L13_2(L14_2)
        L13_2 = RemoveDecalsFromObjectFacing
        L14_2 = L10_2
        L15_2 = 0.0
        L16_2 = 0.0
        L17_2 = 1.0
        L13_2(L14_2, L15_2, L16_2, L17_2)
      end
    end
    L6_2 = EnumerateVehicles
    L6_2, L7_2, L8_2, L9_2 = L6_2()
    for L10_2 in L6_2, L7_2, L8_2, L9_2 do
      L11_2 = GetEntityCoords
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      L12_2 = L4_2 - L11_2
      L12_2 = #L12_2
      if L5_2 > L12_2 then
        L13_2 = RemoveDecalsFromVehicle
        L14_2 = L10_2
        L13_2(L14_2)
      end
    end
  end
  L5_1 = false
  L2_1(L3_1, L4_1, L5_1)
  function L2_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2
    L3_2 = coroutine
    L3_2 = L3_2.wrap
    function L4_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
      L0_3 = A0_2
      L0_3, L1_3 = L0_3()
      if not L1_3 or 0 == L1_3 then
        L2_3 = A2_2
        L3_3 = L0_3
        L2_3(L3_3)
        return
      end
      L2_3 = {}
      L2_3.handle = L0_3
      L3_3 = A2_2
      L2_3.destructor = L3_3
      L3_3 = setmetatable
      L4_3 = L2_3
      L5_3 = {}
      function L6_3(A0_4)
        local L1_4, L2_4
        L1_4 = A0_4.destructor
        if L1_4 then
          L1_4 = A0_4.handle
          if L1_4 then
            L1_4 = A0_4.destructor
            L2_4 = A0_4.handle
            L1_4(L2_4)
          end
        end
        A0_4.destructor = nil
        A0_4.handle = nil
      end
      L5_3.__gc = L6_3
      L3_3(L4_3, L5_3)
      L3_3 = true
      repeat
        L4_3 = coroutine
        L4_3 = L4_3.yield
        L5_3 = L1_3
        L4_3(L5_3)
        L4_3 = A1_2
        L5_3 = L0_3
        L4_3, L5_3 = L4_3(L5_3)
        L1_3 = L5_3
        L3_3 = L4_3
      until not L3_3
      L4_3 = nil
      L2_3.handle = nil
      L2_3.destructor = L4_3
      L4_3 = A2_2
      L5_3 = L0_3
      L4_3(L5_3)
    end
    return L3_2(L4_2)
  end
  EnumerateEntities = L2_1
  function L2_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = EnumerateEntities
    L1_2 = FindFirstObject
    L2_2 = FindNextObject
    L3_2 = EndFindObject
    return L0_2(L1_2, L2_2, L3_2)
  end
  EnumerateObjects = L2_1
  function L2_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = EnumerateEntities
    L1_2 = FindFirstVehicle
    L2_2 = FindNextVehicle
    L3_2 = EndFindVehicle
    return L0_2(L1_2, L2_2, L3_2)
  end
  EnumerateVehicles = L2_1
end
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L2_2 = {}
  L3_2 = {}
  L4_2 = {}
  L5_2 = 1
  L6_2 = "{\n"
  while true do
    L7_2 = 0
    L8_2 = pairs
    L9_2 = A0_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L7_2 = L7_2 + 1
    end
    L8_2 = 1
    L9_2 = pairs
    L10_2 = A0_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      L15_2 = L2_2[A0_2]
      if nil ~= L15_2 then
        L15_2 = L2_2[A0_2]
        if not (L8_2 >= L15_2) then
          goto lbl_211
        end
      end
      L15_2 = string
      L15_2 = L15_2.find
      L16_2 = L6_2
      L17_2 = "}"
      L19_2 = L6_2
      L18_2 = L6_2.len
      L18_2, L19_2, L20_2, L21_2, L22_2 = L18_2(L19_2)
      L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      if L15_2 then
        L15_2 = L6_2
        L16_2 = ",\n"
        L15_2 = L15_2 .. L16_2
        L6_2 = L15_2
      else
        L15_2 = string
        L15_2 = L15_2.find
        L16_2 = L6_2
        L17_2 = "\n"
        L19_2 = L6_2
        L18_2 = L6_2.len
        L18_2, L19_2, L20_2, L21_2, L22_2 = L18_2(L19_2)
        L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
        if not L15_2 then
          L15_2 = L6_2
          L16_2 = "\n"
          L15_2 = L15_2 .. L16_2
          L6_2 = L15_2
        end
      end
      L15_2 = table
      L15_2 = L15_2.insert
      L16_2 = L4_2
      L17_2 = L6_2
      L15_2(L16_2, L17_2)
      L6_2 = ""
      L15_2 = nil
      L16_2 = type
      L17_2 = L13_2
      L16_2 = L16_2(L17_2)
      if "number" ~= L16_2 then
        L16_2 = type
        L17_2 = L13_2
        L16_2 = L16_2(L17_2)
        if "boolean" ~= L16_2 then
          goto lbl_82
        end
      end
      L16_2 = "["
      L17_2 = tostring
      L18_2 = L13_2
      L17_2 = L17_2(L18_2)
      L18_2 = "]"
      L16_2 = L16_2 .. L17_2 .. L18_2
      L15_2 = L16_2
      goto lbl_89
      ::lbl_82::
      L16_2 = "['"
      L17_2 = tostring
      L18_2 = L13_2
      L17_2 = L17_2(L18_2)
      L18_2 = "']"
      L16_2 = L16_2 .. L17_2 .. L18_2
      L15_2 = L16_2
      ::lbl_89::
      L16_2 = false
      L17_2 = type
      L18_2 = L14_2
      L17_2 = L17_2(L18_2)
      if "string" == L17_2 then
        L17_2 = string
        L17_2 = L17_2.match
        L18_2 = string
        L18_2 = L18_2.lower
        L19_2 = L14_2
        L18_2 = L18_2(L19_2)
        L19_2 = "gametype"
        L17_2 = L17_2(L18_2, L19_2)
        if L17_2 then
          L16_2 = true
        end
        L17_2 = string
        L17_2 = L17_2.match
        L18_2 = string
        L18_2 = L18_2.lower
        L19_2 = L14_2
        L18_2 = L18_2(L19_2)
        L19_2 = "balloontypes"
        L17_2 = L17_2(L18_2, L19_2)
        if L17_2 then
          L16_2 = true
        end
      end
      L17_2 = type
      L18_2 = L14_2
      L17_2 = L17_2(L18_2)
      if "number" ~= L17_2 then
        L17_2 = type
        L18_2 = L14_2
        L17_2 = L17_2(L18_2)
        if "boolean" ~= L17_2 then
          L17_2 = type
          L18_2 = L14_2
          L17_2 = L17_2(L18_2)
          if not ("vector3" == L17_2 or L16_2) then
            goto lbl_148
          end
        end
      end
      L17_2 = L6_2
      L18_2 = string
      L18_2 = L18_2.rep
      L19_2 = "\t"
      L20_2 = L5_2
      L18_2 = L18_2(L19_2, L20_2)
      L19_2 = L15_2
      L20_2 = " = "
      L21_2 = tostring
      L22_2 = L14_2
      L21_2 = L21_2(L22_2)
      L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2
      L6_2 = L17_2
      goto lbl_192
      ::lbl_148::
      L17_2 = type
      L18_2 = L14_2
      L17_2 = L17_2(L18_2)
      if "table" == L17_2 then
        L17_2 = L6_2
        L18_2 = string
        L18_2 = L18_2.rep
        L19_2 = "\t"
        L20_2 = L5_2
        L18_2 = L18_2(L19_2, L20_2)
        L19_2 = L15_2
        L20_2 = " = {\n"
        L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2
        L6_2 = L17_2
        L17_2 = table
        L17_2 = L17_2.insert
        L18_2 = L3_2
        L19_2 = A0_2
        L17_2(L18_2, L19_2)
        L17_2 = table
        L17_2 = L17_2.insert
        L18_2 = L3_2
        L19_2 = L14_2
        L17_2(L18_2, L19_2)
        L17_2 = L8_2 + 1
        L2_2[A0_2] = L17_2
        break
      else
        L17_2 = L6_2
        L18_2 = string
        L18_2 = L18_2.rep
        L19_2 = "\t"
        L20_2 = L5_2
        L18_2 = L18_2(L19_2, L20_2)
        L19_2 = L15_2
        L20_2 = " = '"
        L21_2 = tostring
        L22_2 = L14_2
        L21_2 = L21_2(L22_2)
        L22_2 = "'"
        L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2
        L6_2 = L17_2
      end
      ::lbl_192::
      if L8_2 == L7_2 then
        L17_2 = L6_2
        L18_2 = "\n"
        L19_2 = string
        L19_2 = L19_2.rep
        L20_2 = "\t"
        L21_2 = L5_2 - 1
        L19_2 = L19_2(L20_2, L21_2)
        L20_2 = "}"
        L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2
        L6_2 = L17_2
      else
        L17_2 = L6_2
        L18_2 = ","
        L17_2 = L17_2 .. L18_2
        L6_2 = L17_2
        goto lbl_224
        ::lbl_211::
        if L8_2 == L7_2 then
          L15_2 = L6_2
          L16_2 = "\n"
          L17_2 = string
          L17_2 = L17_2.rep
          L18_2 = "\t"
          L19_2 = L5_2 - 1
          L17_2 = L17_2(L18_2, L19_2)
          L18_2 = "}"
          L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
          L6_2 = L15_2
        end
      end
      ::lbl_224::
      L8_2 = L8_2 + 1
    end
    if 0 == L7_2 then
      L9_2 = L6_2
      L10_2 = "\n"
      L11_2 = string
      L11_2 = L11_2.rep
      L12_2 = "\t"
      L13_2 = L5_2 - 1
      L11_2 = L11_2(L12_2, L13_2)
      L12_2 = "}"
      L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
      L6_2 = L9_2
    end
    L9_2 = #L3_2
    if not (L9_2 > 0) then
      break
    end
    L9_2 = #L3_2
    A0_2 = L3_2[L9_2]
    L9_2 = #L3_2
    L3_2[L9_2] = nil
    L9_2 = L2_2[A0_2]
    if nil == L9_2 then
      L9_2 = L5_2 + 1
      if L9_2 then
        goto lbl_260
        L5_2 = L9_2 or L5_2
      end
    end
    L5_2 = L5_2 - 1
    goto lbl_260
    do break end
    ::lbl_260::
  end
  L7_2 = table
  L7_2 = L7_2.insert
  L8_2 = L4_2
  L9_2 = L6_2
  L7_2(L8_2, L9_2)
  L7_2 = table
  L7_2 = L7_2.concat
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L6_2 = L7_2
  if not A1_2 then
    L7_2 = print
    L8_2 = L6_2
    L7_2(L8_2)
  end
  return L6_2
end
Dump = L1_1
L1_1 = Dump
dump = L1_1
