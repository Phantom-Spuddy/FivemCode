local Zone = nil
local seconds = 1000
local player = PlayerPedId()
local playerInZone = false
local invehicle = GetVehiclePedIsIn(player, false)

CreateThread(function ()
    Zone = BoxZone:Create(vector3(218.5, -1041.0, 29.37), 50, 50, {
        name = "Zone",
        debugPoly = "True"
    })

    Zone:onPlayerInOut(function (isPointInside)
        if isPointInside then
            PlayerEnterZone()
            -- Checks For Mask Presense
            invehicle = GetVehiclePedIsIn(player, false)
            local maskIndex = GetPedDrawableVariation(player, 1)
            if maskIndex == 46 or maskIndex == 38 or maskIndex == 129 then
                -- Do this if mask is present:
                -- print("Mask On")
                -- Wait(math.random((seconds * 1), (seconds * 3))) -- Wait Set Seconds
                SetEntityMaxSpeed(player, 2.00) -- Set's the specific PEDs speed (Player in this case)
                SetVehicleMaxSpeed(invehicle, 5.0) -- Set's the specific PEDs vehicle Speed, get's currentVehicle (Player in this case)   
            else
                -- Whilst Mask is off - Do:
                invehicle = GetVehiclePedIsIn(player, false)
                -- print("Mask Off - In Zone")
                -- Wait(math.random((seconds * 1), (seconds * 3))) -- Wait Set Seconds
                SetEntityMaxSpeed(player, 2.00) -- Set's the specific PEDs speed (Player in this case)
                SetVehicleMaxSpeed(invehicle, 5.0) -- Set's the specific PEDs vehicle Speed, get's currentVehicle (Player in this case)
            end
        else
            PlayerLeftZone()
            print("Speed Changed Back Due to Zone leave")
            SetEntityMaxSpeed(player, 10.00)
            SetVehicleMaxSpeed(invehicle, 0.0)
        end
    end)
    Zone:onPlayerInOut(function (isPointInside)
        while playerInZone do

            local maskIndex = GetPedDrawableVariation(player, 1)
            if maskIndex == 46 or maskIndex == 38 or maskIndex == 129 then
                print("Mask on Resulting in no health decrease")
                Wait(math.random(1000, 3000))
            else
                print("Removing Health due to no mask")
                Wait(math.random(1000, 3000))
                local pHealth = SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1)) -1)
            end
        end
    end)
end)


function PlayerEnterZone()
    print("Entered PolyZone")
    playerInZone = true
end

function PlayerLeftZone()
    print("Left PolyZone")
    playerInZone = false
end

function MaskTrue()
    print("Mask On")
end

function MaskFalse()
    print("Mask Not on")
end
