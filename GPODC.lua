-- requirements: have the following
--[[
local userID = "" -- your Discord ID
local Webhook = "" -- your Discord Webhook link
]]

assert(isfile == nil or writefile == nil or readfile == nil or appendfile == nil, "Filesystem functions required don't exist.");
assert(http_request == nil or syn == nil or syn.request == nil, "HTTP request functions don't exist.");

local http = http_request or syn.request;

local Players = game.Players;

if not isfile("dungCounter.txt") then
    writefile("dungCounter.txt", 1);
end

Players.PlayerAdded:Connect(function(plr)
    if plr.Name == Players.LocalPlayer then
        local Data = plr:GetJoinData();
        
        if Data.SourcePlaceId == 3978370137 then
            local num;
            local formula;
            if isfile("dungCounter.txt") then
                num = tonumber(readfile("dungCounter.txt"));
                formula = num + 1;
                appendFile("dungCounter.txt", formula);
            end

            local data = {
                ["content"] = "<@" .. userID .. ">",
                ["embeds"] = {
                    {
                        ["title"] = "**Dungeon Counter**",
                        ["description"] = "Dungeon Count: " .. tonumber(formula),
                        ["type"] = "rich",
                        ["color"] = Color3.fromHex("28282B"),
                        ["image"] = {
                            ["url"] = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username=" ..
                                tostring(game:GetService("Players").LocalPlayer.Name);
                        };
                    };
                };
             };
             local newdata = game:GetService("HttpService"):JSONEncode(data);

             local abcdef = {Url = webhook, Body = newdata, Method = "POST", Headers = {["content-type"] = "application/json"}};

             http(abcdef);
        end
    end
end)
