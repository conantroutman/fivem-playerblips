local isRadarExtended = false
local isBlipRotating = true

local colors = {28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- show blips
		for _, player in ipairs(GetActivePlayers()) do
			if PlayerPedId() ~= GetPlayerPed(player) then
				ped = GetPlayerPed(player)
				blip = GetBlipFromEntity(ped)

				-- HEAD DISPLAY STUFF --
				-- Create head display (this is safe to be spammed)
				headId = CreateFakeMpGamerTag(ped, GetPlayerName(player), false, false, "", false)
				wantedLvl = GetPlayerWantedLevel(player)

				-- Wanted level display
				if wantedLvl > 0 then
					SetMpGamerTagVisibility(headId, 7, true)
					SetMpGamerTagWantedLevel(headId, wantedLvl)
				else
					SetMpGamerTagVisibility(headId, 7, false)
				end

				-- Speaking display
				if NetworkIsPlayerTalking(player) then
					SetMpGamerTagVisibility(headId, 9, true)
				else
					SetMpGamerTagVisibility(headId, 9, false) -- Remove speaking sprite
				end

				-- Driving
				if IsPedInAnyVehicle(ped, false) then
					SetMpGamerTagVisibility(headId, 8, true)
				else
					SetMpGamerTagVisibility(headId, 8, false)
				end

				-- BLIP STUFF --
				if not DoesBlipExist(blip) then -- Add blip and create head display on player
					blip = AddBlipForEntity(ped)
					SetBlipSprite(blip, 1)
					ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
				else -- update blip
					veh = GetVehiclePedIsIn(ped, false)
					blipSprite = GetBlipSprite(blip)
					if not GetEntityHealth(ped) then -- dead
						if blipSprite ~= 274 then
							SetBlipSprite(blip, 274)
							ShowHeadingIndicatorOnBlip(blip, false) -- Player Blip indicator
						end
					elseif veh then
						vehClass = GetVehicleClass(veh)
						vehModel = GetEntityModel(veh)						
						if vehClass == 15 then -- helicopter
							if vehModel == GetHashKey("hunter") then
								SetBlip(blip, 576, false, false)
							elseif vehModel == GetHashKey("akula") then
								SetBlip(blip, 602, false, false)
							elseif vehModel == GetHashKey("seasparrow") then
								SetBlip(blip, 612, false, false)
							else
								SetBlip(blip, 422, false, true)
							end
						elseif vehClass == 16 then -- plane
							if vehModel == GetHashKey("besra") or vehModel == GetHashKey("hydra") or vehModel == GetHashKey("lazer") then -- jet
								SetBlip(blip, 424, false, true)
							elseif vehModel == GetHashKey("alphaz1") then -- Alpha Z1
								SetBlip(blip, 572, false, true)
							elseif vehModel == GetHashKey("bombushka") then -- Bombushka
								SetBlip(blip, 573, false, true)
							elseif vehModel == GetHashKey("howard") then -- Howard
								SetBlip(blip, 575, false, true)
							elseif vehModel == GetHashKey("ultralight") then -- Ultralight
								SetBlip(blip, 577, false, true)
							elseif vehModel == GetHashKey("mogul") then -- Mogul
								SetBlip(blip, 578, false, true)
							elseif vehModel == GetHashKey("molotok") then -- Molotok
								SetBlip(blip, 579, false, true)
							elseif vehModel == GetHashKey("nokota") then -- Nokota
								SetBlip(blip, 580, false, true)
							elseif vehModel == GetHashKey("pyro") then -- Pyro
								SetBlip(blip, 581, false, true)
							elseif vehModel == GetHashKey("rogue") then -- Rogue
								SetBlip(blip, 582, false, true)
							elseif vehModel == GetHashKey("starling") then -- Starling
								SetBlip(blip, 583, false, true)
							elseif vehModel == GetHashKey("seabreeze") then -- Seabreeze
								SetBlip(blip, 584, false, true)
							elseif vehModel == GetHashKey("tula") then -- Tula
								SetBlip(blip, 585, false, true)
							elseif vehModel == GetHashKey("avenger") then -- Avenger
								SetBlip(blip, 589, false, false)
							elseif vehModel == GetHashKey("volatol") then -- Volatol
								SetBlip(blip, 600, false, true)
							elseif vehModel == GetHashKey("strikeforce") then -- Strikeforce
								SetBlip(blip, 640, false, true)
							else
								SetBlip(blip, 423, false, true)
							end
						elseif vehClass == 14 then -- boat
							SetBlip(blip, 427, false, true)
						elseif vehModel == GetHashKey( "insurgent" ) or vehModel == GetHashKey( "insurgent2" ) or vehModel == GetHashKey( "insurgent3" )
						or vehModel == GetHashKey("technical") or vehModel == GetHashKey("technical3") then -- Insurgent and Technical
							SetBlip(blip, 426, false, true)
						elseif vehModel == GetHashKey("limo2") then -- Turreted Limo
							SetBlip(blip, 460, false, true)
						elseif vehModel == GetHashKey("rhino") then -- Rhino (tank)
							SetBlip(blip, 421, false, true)
						elseif vehModel == GetHashKey("khanjali") then -- Khanjali
							SetBlip(blip, 598, false, true)
						elseif vehModel == GetHashKey("oppressor") then -- Oppressor
							SetBlip(blip, 559, false, false)
						elseif vehModel == GetHashKey("oppressor2") then -- Oppressor 2
							SetBlip(blip, 639, false, false)
						elseif vehModel == GetHashKey("apc") then -- APC
							SetBlip(blip, 558, false, true)
						elseif vehModel == GetHashKey("halftrack") then -- Half-track
							SetBlip(blip, 560, false, false)
						elseif vehModel == GetHashKey("dune3") then -- Dune FAV
							SetBlip(blip, 561, false, false)
						elseif vehModel == GetHashKey("chernobog") then -- Chernobog
							SetBlip(blip, 603, false, false)
						elseif vehModel == GetHashKey("dune4") or vehModel == GetHashKey("dune5") then -- Ramp Buggy
							SetBlip(blip, 531, false, false)
						elseif vehModel == GetHashKey("wastelander") then -- Wastelander
							SetBlip(blip, 532, false, false)
						elseif vehModel == GetHashKey("technical2") then -- Technical Aqua
							SetBlip(blip, 534, false, true)
						elseif vehModel == GetHashKey("boxville5") then -- Armored Boxville
							SetBlip(blip, 529, false, true)
						elseif vehModel == GetHashKey("phantom2") then -- Phantom Wedge
							SetBlip(blip, 528, false, false)
						elseif vehModel == GetHashKey("stromberg") then -- Stromberg
							SetBlip(blip, 595, false, false)
						elseif vehModel == GetHashKey("deluxo") then -- Deluxo
							SetBlip(blip, 596, false, false)
						elseif vehModel == GetHashKey("ruiner2") then -- Ruiner 2000
							SetBlip(blip, 530, false, false)
						elseif vehModel == GetHashKey("caracara") then -- Caracara
							SetBlip(blip, 613, false, true)
						elseif vehModel == GetHashKey("menacer") then -- Menacer
							SetBlip(blip, 633, false, true)
						elseif vehModel == GetHashKey("scramjet") then -- Scramjet
							SetBlip(blip, 634, false, true)
						elseif vehModel == GetHashKey("voltic2") then -- Rocket Voltic
							SetBlip(blip, 533, false, true)
						elseif vehModel == GetHashKey("riot2") then -- RCV
							SetBlip(blip, 599, false, false)
						elseif vehModel == GetHashKey("bruiser") or vehModel == GetHashKey("bruiser2") or vehModel == GetHashKey("bruiser3") then -- Bruiser
							SetBlip(blip, 658, false, false)
						elseif vehModel == GetHashKey("brutus") or vehModel == GetHashKey("brutus2") or vehModel == GetHashKey("brutus3") then -- Brutus
							SetBlip(blip, 659, false, false)
						elseif vehModel == GetHashKey("cerberus") or vehModel == GetHashKey("cerberus2") or vehModel == GetHashKey("cerberus3") then -- Cerberus
							SetBlip(blip, 660, false, false)
						elseif vehModel == GetHashKey("deathbike") or vehModel == GetHashKey("deathbike2") or vehModel == GetHashKey("deathbike3") then -- Deathbike
							SetBlip(blip, 661, false, false)
						elseif vehModel == GetHashKey("dominator4") or vehModel == GetHashKey("dominator5") or vehModel == GetHashKey("dominator6") then -- Dominator
							SetBlip(blip, 662, false, false)
						elseif vehModel == GetHashKey("impaler2") or vehModel == GetHashKey("impaler3") or vehModel == GetHashKey("impaler4") then -- Impaler
							SetBlip(blip, 663, false, false)
						elseif vehModel == GetHashKey("imperator") or vehModel == GetHashKey("imperator2") or vehModel == GetHashKey("imperator3") then -- Imperator
							SetBlip(blip, 664, false, false)
						elseif vehModel == GetHashKey("issi3") or vehModel == GetHashKey("issi4") or vehModel == GetHashKey("issi5") then -- Issi
							SetBlip(blip, 665, false, false)
						elseif vehModel == GetHashKey("sasquatch") or vehModel == GetHashKey("sasquatch2") or vehModel == GetHashKey("sasquatch3") then -- Sasquatch
							SetBlip(blip, 666, false, false)
						elseif vehModel == GetHashKey("scarab") or vehModel == GetHashKey("scarab") or vehModel == GetHashKey("scarab") then -- Scarab
							SetBlip(blip, 667, false, false)
						elseif vehModel == GetHashKey("slamvan4") or vehModel == GetHashKey("slamvan5") or vehModel == GetHashKey("slamvan6") then -- Slamvan
							SetBlip(blip, 668, false, false)
						elseif vehModel == GetHashKey("zr380") or vehModel == GetHashKey("zr3802") or vehModel == GetHashKey("zr3803") then -- ZR380
							SetBlip(blip, 669, false, false)
						elseif blipSprite ~= 1 then -- default blip
							SetBlip(blip, 1, true, true)
						end

						-- Show number in case of passangers
						passengers = GetVehicleNumberOfPassengers(veh)
						if passengers > 1 then
							if not IsVehicleSeatFree(veh, -1) then
								passengers = passengers + 1
							end
							ShowNumberOnBlip(blip, passengers)
						else
							HideNumberOnBlip(blip)
						end
					else
						-- Remove leftover number
						HideNumberOnBlip(blip)
						if blipSprite ~= 1 then -- default blip
							SetBlipSprite(blip, 1)
							ShowHeadingIndicatorOnBlip(blip, false) -- Player Blip indicator
						end
					end

					if isBlipRotating then
						SetBlipRotation(blip, math.ceil(GetEntityHeading(veh))) -- update rotation
					end
					SetBlipNameToPlayerName(blip, player) -- update blip name
					--SetBlipScale( blip,  0.85 ) -- set scale

					-- set player alpha
					if IsPauseMenuActive() then
						SetBlipAlpha(blip, 255)
					else

						x1, y1 = table.unpack( GetEntityCoords( GetPlayerPed(-1), true ) )
						x2, y2 = table.unpack( GetEntityCoords( GetPlayerPed(player), true ) )
						distance = ( math.floor( math.abs( math.sqrt( ( x1 - x2 ) * ( x1 - x2 ) + ( y1 - y2 ) * ( y1 - y2 ) ) ) / -1 ) ) + 900
						-- Probably a way easier way to do this but whatever im an idiot

						if distance < 0 then
							distance = 0
						elseif distance > 255 then
							distance = 255
						end
						--SetBlipAlpha(blip, distance)
					end
				end

				-- Set the blip color based on server ID
				SetBlipColour(blip, colors[GetPlayerServerId(player)]-22)
				SetMpGamerTagColour(headId, 0, colors[GetPlayerServerId(player)])
				--print(GetPlayerServerId(player))
			end	
		end
	end
end)

Citizen.CreateThread(function()
	local isPaused = false
	while true do
		Citizen.Wait(0)
		
		if IsPauseMenuActive() and not isPaused then
			TriggerServerEvent('playerIsPaused', PlayerId())
			isPaused = true
		elseif not IsPauseMenuActive() and isPaused then
			isPaused = false
		end

	end
end)

function SetBlip(blip, sprite, showHeading, isRotating)
	if GetBlipSprite(blip) ~= sprite then
		SetBlipSprite(blip, sprite)
		ShowHeadingIndicatorOnBlip(blip, showHeading)
	end
	isBlipRotating = isRotating
end

function IsPlayerPauseMenuActive(player)

end

AddEventHandler("GetPlayerColor", function(player, color)
	color = colors[GetPlayerServerId(player)]
end)

AddEventHandler("FlashBlip", function(playerId, toggle)
	local blip = GetBlipFromEntity(GetPlayerPed(playerId))
	SetBlipFlashes(blip, toggle)
end)