local f = CreateFrame("Frame")
local announced = false

f:RegisterEvent("PLAYER_CONTROL_LOST")  -- flight starts
f:RegisterEvent("PLAYER_CONTROL_GAINED") -- flight ends

f:SetScript("OnEvent", function(self, event)
    if not InFlight then return end

    if event == "PLAYER_CONTROL_LOST" then
        if not announced then
            announced = true
            local dst = InFlight:GetDestination()
            local time = InFlight:GetFlightTime() or 0

            if dst and time > 0 and IsInGroup() then
                local minutes = math.floor(time / 60)
                local seconds = time % 60
                local msg = string.format(
                    "In flight to %s. Will arrive in %d:%02d.",
                    dst,
                    minutes,
                    seconds
                )
                SendChatMessage(msg, "PARTY")
            end
        end
    elseif event == "PLAYER_CONTROL_GAINED" then
        announced = false  -- reset for next flight
    end
end)
