local L0_1, L1_1, L2_1
L0_1 = Config
L0_1 = L0_1.Framework
if L0_1 then
  L0_1 = string
  L0_1 = L0_1.len
  L1_1 = Config
  L1_1 = L1_1.Framework
  L0_1 = L0_1(L1_1)
  if 0 ~= L0_1 then
    L0_1 = string
    L0_1 = L0_1.strtrim
    L1_1 = string
    L1_1 = L1_1.lower
    L2_1 = Config
    L2_1 = L2_1.Framework
    L1_1, L2_1 = L1_1(L2_1)
    L0_1 = L0_1(L1_1, L2_1)
    if "esx" == L0_1 then
      L0_1 = Config
      L0_1 = L0_1.FrameworkTriggers
      L1_1 = string
      L1_1 = L1_1.len
      L2_1 = Config
      L2_1 = L2_1.FrameworkTriggers
      L2_1 = L2_1.object
      L1_1 = L1_1(L2_1)
      if L1_1 > 0 then
        L1_1 = Config
        L1_1 = L1_1.FrameworkTriggers
        L1_1 = L1_1.object
        if L1_1 then
          goto lbl_39
        end
      end
      L1_1 = "esx:getSharedObject"
      ::lbl_39::
      L0_1.object = L1_1
      L0_1 = Config
      L0_1 = L0_1.FrameworkTriggers
      L1_1 = string
      L1_1 = L1_1.len
      L2_1 = Config
      L2_1 = L2_1.FrameworkTriggers
      L2_1 = L2_1.notify
      L1_1 = L1_1(L2_1)
      if L1_1 > 0 then
        L1_1 = Config
        L1_1 = L1_1.FrameworkTriggers
        L1_1 = L1_1.notify
        if L1_1 then
          goto lbl_56
        end
      end
      L1_1 = "esx:showNotification"
      ::lbl_56::
      L0_1.notify = L1_1
      L0_1 = Config
      L0_1 = L0_1.FrameworkTriggers
      L1_1 = string
      L1_1 = L1_1.len
      L2_1 = Config
      L2_1 = L2_1.FrameworkTriggers
      L2_1 = L2_1.resourceName
      L1_1 = L1_1(L2_1)
      if L1_1 > 0 then
        L1_1 = Config
        L1_1 = L1_1.FrameworkTriggers
        L1_1 = L1_1.resourceName
        if L1_1 then
          goto lbl_73
        end
      end
      L1_1 = "es_extended"
      ::lbl_73::
      L0_1.resourceName = L1_1
      L0_1 = Config
      L0_1 = L0_1.FrameworkSQLTables
      L1_1 = string
      L1_1 = L1_1.len
      L2_1 = Config
      L2_1 = L2_1.FrameworkSQLTables
      L2_1 = L2_1.table
      L1_1 = L1_1(L2_1)
      if L1_1 > 0 then
        L1_1 = Config
        L1_1 = L1_1.FrameworkSQLTables
        L1_1 = L1_1.table
        if L1_1 then
          goto lbl_90
        end
      end
      L1_1 = "owned_vehicles"
      ::lbl_90::
      L0_1.table = L1_1
      L0_1 = Config
      L0_1 = L0_1.FrameworkSQLTables
      L1_1 = string
      L1_1 = L1_1.len
      L2_1 = Config
      L2_1 = L2_1.FrameworkSQLTables
      L2_1 = L2_1.identifier
      L1_1 = L1_1(L2_1)
      if L1_1 > 0 then
        L1_1 = Config
        L1_1 = L1_1.FrameworkSQLTables
        L1_1 = L1_1.identifier
        if L1_1 then
          goto lbl_107
        end
      end
      L1_1 = "owner"
      ::lbl_107::
      L0_1.identifier = L1_1
    else
      L0_1 = string
      L0_1 = L0_1.strtrim
      L1_1 = string
      L1_1 = L1_1.lower
      L2_1 = Config
      L2_1 = L2_1.Framework
      L1_1, L2_1 = L1_1(L2_1)
      L0_1 = L0_1(L1_1, L2_1)
      if "qbcore" == L0_1 then
        L0_1 = Config
        L0_1 = L0_1.FrameworkTriggers
        L1_1 = string
        L1_1 = L1_1.len
        L2_1 = Config
        L2_1 = L2_1.FrameworkTriggers
        L2_1 = L2_1.object
        L1_1 = L1_1(L2_1)
        if L1_1 > 0 then
          L1_1 = Config
          L1_1 = L1_1.FrameworkTriggers
          L1_1 = L1_1.object
          if L1_1 then
            goto lbl_135
          end
        end
        L1_1 = "QBCore:GetObject"
        ::lbl_135::
        L0_1.object = L1_1
        L0_1 = Config
        L0_1 = L0_1.FrameworkTriggers
        L1_1 = string
        L1_1 = L1_1.len
        L2_1 = Config
        L2_1 = L2_1.FrameworkTriggers
        L2_1 = L2_1.notify
        L1_1 = L1_1(L2_1)
        if L1_1 > 0 then
          L1_1 = Config
          L1_1 = L1_1.FrameworkTriggers
          L1_1 = L1_1.notify
          if L1_1 then
            goto lbl_152
          end
        end
        L1_1 = "QBCore:Notify"
        ::lbl_152::
        L0_1.notify = L1_1
        L0_1 = Config
        L0_1 = L0_1.FrameworkTriggers
        L1_1 = string
        L1_1 = L1_1.len
        L2_1 = Config
        L2_1 = L2_1.FrameworkTriggers
        L2_1 = L2_1.resourceName
        L1_1 = L1_1(L2_1)
        if L1_1 > 0 then
          L1_1 = Config
          L1_1 = L1_1.FrameworkTriggers
          L1_1 = L1_1.resourceName
          if L1_1 then
            goto lbl_169
          end
        end
        L1_1 = "qb-core"
        ::lbl_169::
        L0_1.resourceName = L1_1
        L0_1 = Config
        L0_1 = L0_1.FrameworkSQLTables
        L1_1 = string
        L1_1 = L1_1.len
        L2_1 = Config
        L2_1 = L2_1.FrameworkSQLTables
        L2_1 = L2_1.table
        L1_1 = L1_1(L2_1)
        if L1_1 > 0 then
          L1_1 = Config
          L1_1 = L1_1.FrameworkSQLTables
          L1_1 = L1_1.table
          if L1_1 then
            goto lbl_186
          end
        end
        L1_1 = "player_vehicles"
        ::lbl_186::
        L0_1.table = L1_1
        L0_1 = Config
        L0_1 = L0_1.FrameworkSQLTables
        L1_1 = string
        L1_1 = L1_1.len
        L2_1 = Config
        L2_1 = L2_1.FrameworkSQLTables
        L2_1 = L2_1.identifier
        L1_1 = L1_1(L2_1)
        if L1_1 > 0 then
          L1_1 = Config
          L1_1 = L1_1.FrameworkSQLTables
          L1_1 = L1_1.identifier
          if L1_1 then
            goto lbl_203
          end
        end
        L1_1 = "citizenid"
        ::lbl_203::
        L0_1.identifier = L1_1
      else
        L0_1 = string
        L0_1 = L0_1.strtrim
        L1_1 = string
        L1_1 = L1_1.lower
        L2_1 = Config
        L2_1 = L2_1.Framework
        L1_1, L2_1 = L1_1(L2_1)
        L0_1 = L0_1(L1_1, L2_1)
        if "other" == L0_1 then
          L0_1 = Config
          L0_1 = L0_1.FrameworkTriggers
          L1_1 = Config
          L1_1 = L1_1.FrameworkTriggers
          L1_1 = L1_1.object
          if not L1_1 then
            L1_1 = ""
          end
          L0_1.object = L1_1
          L0_1 = Config
          L0_1 = L0_1.FrameworkTriggers
          L1_1 = Config
          L1_1 = L1_1.FrameworkTriggers
          L1_1 = L1_1.notify
          if not L1_1 then
            L1_1 = ""
          end
          L0_1.notify = L1_1
          L0_1 = Config
          L0_1 = L0_1.FrameworkTriggers
          L1_1 = Config
          L1_1 = L1_1.FrameworkTriggers
          L1_1 = L1_1.resourceName
          if not L1_1 then
            L1_1 = ""
          end
          L0_1.resourceName = L1_1
          L0_1 = Config
          L0_1 = L0_1.FrameworkSQLTables
          L1_1 = Config
          L1_1 = L1_1.FrameworkSQLTables
          L1_1 = L1_1.table
          if not L1_1 then
            L1_1 = ""
          end
          L0_1.table = L1_1
          L0_1 = Config
          L0_1 = L0_1.FrameworkSQLTables
          L1_1 = Config
          L1_1 = L1_1.FrameworkSQLTables
          L1_1 = L1_1.identifier
          if not L1_1 then
            L1_1 = ""
          end
          L0_1.identifier = L1_1
        else
          L0_1 = print
          L1_1 = "^1================ WARNING ================^7"
          L0_1(L1_1)
          L0_1 = print
          L1_1 = "^7Choose your ^2framework^7 in the config!^7"
          L0_1(L1_1)
          L0_1 = print
          L1_1 = "^1================ WARNING ================^7"
          L0_1(L1_1)
        end
      end
    end
  end
end
L0_1 = AddEventHandler
L1_1 = "rcore_stickers:shared:getSharedObject"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = nil
  L2_2 = Config
  L2_2 = L2_2.Framework
  if L2_2 then
    L2_2 = string
    L2_2 = L2_2.strtrim
    L3_2 = string
    L3_2 = L3_2.lower
    L4_2 = Config
    L4_2 = L4_2.Framework
    L3_2, L4_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2)
    if "esx" == L2_2 then
      L2_2 = xpcall
      function L3_2()
        local L0_3, L1_3
        L0_3 = exports
        L1_3 = Config
        L1_3 = L1_3.FrameworkTriggers
        L1_3 = L1_3.resourceName
        L0_3 = L0_3[L1_3]
        L0_3 = L0_3.getSharedObject
        L0_3 = L0_3()
        L1_2 = L0_3
        L0_3 = A0_2
        L1_3 = L1_2
        L0_3(L1_3)
      end
      function L4_2()
        local L0_3, L1_3
        L0_3 = xpcall
        function L1_3()
          local L0_4, L1_4, L2_4
          L0_4 = TriggerEvent
          L1_4 = Config
          L1_4 = L1_4.FrameworkTriggers
          L1_4 = L1_4.load
          function L2_4(A0_5)
            local L1_5, L2_5
            L1_2 = A0_5
            L1_5 = A0_2
            L2_5 = L1_2
            L1_5(L2_5)
          end
          L0_4(L1_4, L2_4)
          L0_4 = SetTimeout
          L1_4 = 100
          function L2_4()
            local L0_5, L1_5
            L0_5 = L1_2
            if nil == L0_5 then
              L0_5 = print
              L1_5 = "^1================ WARNING ================^7"
              L0_5(L1_5)
              L0_5 = print
              L1_5 = "^7Could not ^2load^7 shared object!^7"
              L0_5(L1_5)
              L0_5 = print
              L1_5 = "^1================ WARNING ================^7"
              L0_5(L1_5)
            end
            L0_5 = A0_2
            L1_5 = L1_2
            L0_5(L1_5)
          end
          L0_4(L1_4, L2_4)
        end
        L0_3(L1_3)
      end
      L2_2(L3_2, L4_2)
  end
  else
    L2_2 = Config
    L2_2 = L2_2.Framework
    if L2_2 then
      L2_2 = string
      L2_2 = L2_2.strtrim
      L3_2 = string
      L3_2 = L3_2.lower
      L4_2 = Config
      L4_2 = L4_2.Framework
      L3_2, L4_2 = L3_2(L4_2)
      L2_2 = L2_2(L3_2, L4_2)
      if "qbcore" == L2_2 then
        L2_2 = xpcall
        function L3_2()
          local L0_3, L1_3
          L0_3 = exports
          L1_3 = Config
          L1_3 = L1_3.FrameworkTriggers
          L1_3 = L1_3.resourceName
          L0_3 = L0_3[L1_3]
          L0_3 = L0_3.GetCoreObject
          L0_3 = L0_3()
          L1_2 = L0_3
          L0_3 = A0_2
          L1_3 = L1_2
          L0_3(L1_3)
        end
        function L4_2()
          local L0_3, L1_3, L2_3
          L0_3 = xpcall
          function L1_3()
            local L0_4, L1_4
            L0_4 = exports
            L1_4 = Config
            L1_4 = L1_4.FrameworkTriggers
            L1_4 = L1_4.resourceName
            L0_4 = L0_4[L1_4]
            L0_4 = L0_4.GetSharedObject
            L0_4 = L0_4()
            L1_2 = L0_4
            L0_4 = A0_2
            L1_4 = L1_2
            L0_4(L1_4)
          end
          function L2_3()
            local L0_4, L1_4
            L0_4 = xpcall
            function L1_4()
              local L0_5, L1_5, L2_5
              L0_5 = TriggerEvent
              L1_5 = Config
              L1_5 = L1_5.FrameworkTriggers
              L1_5 = L1_5.load
              function L2_5(A0_6)
                local L1_6, L2_6
                L1_2 = A0_6
                L1_6 = A0_2
                L2_6 = L1_2
                L1_6(L2_6)
              end
              L0_5(L1_5, L2_5)
              L0_5 = SetTimeout
              L1_5 = 100
              function L2_5()
                local L0_6, L1_6
                L0_6 = L1_2
                if nil == L0_6 then
                  L0_6 = print
                  L1_6 = "^1================ WARNING ================^7"
                  L0_6(L1_6)
                  L0_6 = print
                  L1_6 = "^7Could not ^2load^7 shared object!^7"
                  L0_6(L1_6)
                  L0_6 = print
                  L1_6 = "^1================ WARNING ================^7"
                  L0_6(L1_6)
                end
                L0_6 = A0_2
                L1_6 = L1_2
                L0_6(L1_6)
              end
              L0_5(L1_5, L2_5)
            end
            L0_4(L1_4)
          end
          L0_3(L1_3, L2_3)
        end
        L2_2(L3_2, L4_2)
    end
    else
      L2_2 = print
      L3_2 = "^1================ WARNING ================^7"
      L2_2(L3_2)
      L2_2 = print
      L3_2 = "^7Could not ^2load^7 shared object!^7"
      L2_2(L3_2)
      L2_2 = print
      L3_2 = "^1================ WARNING ================^7"
      L2_2(L3_2)
    end
  end
end
L0_1(L1_1, L2_1)
