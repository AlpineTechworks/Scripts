-- requirements: have the following
--[[
local userID = "" -- your Discord ID
local Webhook = "" -- your Discord Webhook link
]]

if type(isfile) ~= "function" or type(writefile) ~= "function" or type(readfile) ~= "function" or type(appendfile) ~= "function" then
   error("Filesystem functions required don't exist.", 1);
end;

if type(syn) ~= "table" then
	if type(http_request) ~= "function" then
	   error("HTTP request function don't exist.", 1);
	end;
end;

local http = http_request;
if syn.request then
    http = syn.request;
end;

local Players = game.Players;

if not isfile("dungCounter.txt") then
    writefile("dungCounter.txt", 1);
end;

Players.PlayerAdded:Connect(function(plr)
    if plr.Name == Players.LocalPlayer then
        local Data = plr:GetJoinData();
        warn('wow')
        if Data.SourcePlaceId == 3978370137 then
            warn('joined')
            local num;
            local formula;
            if isfile("dungCounter.txt") then
                num = tonumber(readfile("dungCounter.txt"));
                formula = num + 1;
                appendFile("dungCounter.txt", formula);
            end;

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

            local abcdef = {Url = Webhook, Body = newdata, Method = "POST", Headers = {["content-type"] = "application/json"}};

            http(abcdef);
        end;
    end;
end);
