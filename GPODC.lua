-- requirements: have the following
--[[
local userID = "" -- your Discord ID
local Webhook = "" -- your Discord Webhook link
local sendTest = true -- sends a webhook for test
]]
local userVal = function()
    local val = game.Players.LocalPlayer.Name;
    if hideUser then val = "Censored" end;
    return val;
end

if type(isfile) ~= "function" or type(writefile) ~= "function" or type(readfile) ~= "function" or type(appendfile) ~= "function" then
   error("Filesystem functions required don't exist.", 1);
end;

if type(syn) ~= "table" then
    if type(http_request) ~= "function" then
       error("HTTP request function don't exist.", 1);
    end;
end;

if isfile("testedAlready.txt") then
    sendTest = false
else
    writefile("testedAlready.txt", 'pro')
end

local http = http_request;
if syn.request then
    http = syn.request;
end;

local Players = game.Players;

if not isfile("dungCounter.txt") then
    writefile("dungCounter.txt", 1);
end;

Players.PlayerAdded:Connect(function(plr)
    if plr == Players.LocalPlayer then
        local Data = plr:GetJoinData();
    print(Data.SourcePlaceId)
        warn('wow')
        if Data.SourcePlaceId == 6360478118 then
            warn('joined')
            local num;
            local formula;
            if isfile("dungCounter.txt") then
                num = tonumber(readfile("dungCounter.txt"));
                formula = num + 1;
                appendfile("dungCounter.txt", formula);
            end;

            local data = {
                ["content"] = "<@" .. userID .. ">",
                ["embeds"] = {
                    {
                        ["title"] = "**Dungeon Counter**",
                        ["description"] = "**Username**\n||" .. userVal() .. "||\n**Dungeon Count**\n" .. formula,
                        ["type"] = "rich",
                        ["color"] = Color3.fromHex("28282B"),
                        ["thumbnail"] = {
                            ["url"] = "https://avatars.githubusercontent.com/u/103271126?s=150&v=4";
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

if sendTest then
    local data = {
        ["content"] = "<@" .. userID .. ">",
        ["embeds"] = {
            {
                ["title"] = "**Dungeon Counter**",
                ["description"] = "**Username**\n||" .. userVal() .. "||\n**Testing**\ntesting helloooooo",
                ["type"] = "rich",
                ["color"] = Color3.fromHex("28282B"),
                ["thumbnail"] = {
                    ["url"] = "https://avatars.githubusercontent.com/u/103271126?s=150&v=4";
                };
            };
        };
    };

    local newdata = game:GetService("HttpService"):JSONEncode(data);

    local abcdef = {Url = Webhook, Body = newdata, Method = "POST", Headers = {["content-type"] = "application/json"}};

    http(abcdef);
end;
