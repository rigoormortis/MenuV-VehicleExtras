local menuLocation = 'topright'

local menu = MenuV:CreateMenu(false, 'Vehicle Customization', menuLocation, 0, 0, 0, "size-100", 'none', 'menuv', 'veh_customization', 'native')
local menu2 = MenuV:CreateMenu(false, 'Extras Customization', menuLocation, 0, 0, 0, "size-100", 'none', 'menuv', 'extra_customization', 'native')
local menu3 = MenuV:CreateMenu(false, 'Livery Customization', menuLocation, 0, 0, 0, "size-100", 'none', 'menuv', 'livery_customization', 'native')

RegisterNetEvent('openVehMenu', function()
  MenuV:OpenMenu(menu)
end)

menu:On('open', function(m)
  m:ClearItems(m)

  local menu_button = menu:AddButton({
    label = 'Extras',
    value = menu2,
    description = 'Change the extras on your vehicle.'
  })

  local veh = GetVehiclePedIsIn(PlayerPedId(), false)
  local liveryCount = GetVehicleLiveryCount(veh)

  if liveryCount > 1 then
    local liveryItems = {}
    local s = 1
    
    for i = 1, liveryCount do
      table.insert(liveryItems, s, i)
    end

    local liveries = menu:AddRange({
      label = 'Livery',
      min = 1,
      max = GetVehicleLiveryCount(veh),
      value = GetVehicleLivery(veh),
      saveOnUpdate = true
    })
    
    liveries:On('change', function(item , newValue, oldValue)
      SetVehicleLivery(veh, newValue)
    end)
  elseif liveryCount == 1 then
    local liveries = menu:AddButton({
      label = 'No available liveries for vehicle.',
      disabled = true
    })
  end
end)
  
menu2:On('open', function(m)
  m:ClearItems()
  local veh = GetVehiclePedIsIn(PlayerPedId(), false)
  local fuel = GetVehicleFuelLevel(veh)
  local availableExtras = {}
  local items = {}
  local extrasExist = false

  for extra = 0, 20 do
    if DoesExtraExist(veh, extra) then
      availableExtras[extra] = extra
      extrasExist = true
    end
  end

  if extrasExist then
    for k, v in pairs(availableExtras) do
      if IsVehicleExtraTurnedOn(veh, k) then
        local extraItem = menu2:AddCheckbox({
          label = 'Extra ' .. k,
          value = 'y'
        })
        items[k] = extraItem
      else
        local extraItem = menu2:AddCheckbox({
          label = 'Extra ' .. k,
          value = 'n'
        })
        items[k] = extraItem
      end
      
      -- Event
      items[k]:On('change', function(item, value)
        for k, v in pairs(items) do
          if item == v then
            availableExtras[k] = value
            if availableExtras[k] then
              SetVehicleExtra(veh, k, 0)
            else
              SetVehicleExtra(veh, k, 1)
            end
          end
        end
      end)
    end
  end
end)
