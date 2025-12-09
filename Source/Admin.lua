local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
WindUI.Services.Luache = {
  Name = "Luache",
  Icon = "shield",
  Args = {"API"},
  New = function(API)
    function validateKey(key)
      if not key then return false, "Key is missing!" end
      print("Key enviada:", key)
      print("API:", API)
      
      -- Checks the api key
      local httrest = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
      local response = httrest({
          Url = "https://luache.squareweb.app/api/settings",
          Method = "GET",
          Headers = {
            ["api"] = tostring(key),
            ["action"] = "webhook",
          }
        })
      if table.find({400, 401, 404}, tonumber(response.StatusCode)) then return false, "Invalid API!" end
      
      return true, "Amazing key!"
    end
    
    function copyLink()
      return setclipboard("https://luache.squareweb.app/signup")
    end
    
    return {
      Verify = validateKey,
      Copy = copyLink,
    }
  end
  
}

-- Window Settings
local Window = WindUI:CreateWindow({
  Title = "Luache In-Game Dashboard",
  Icon = "shield",
  Author = "https://luache.squareweb.app/dashboard",
  Folder = "Luache",
  Size = UDim2.fromOffset(580, 400),
  Transparent = true,
  Theme = "Dark",
  User = {
    Enabled = true
  }, --
  SideBarWidth = 200,
  HasOutline = true,

  KeySystem = {
    Note = "Your API key",
    SaveKey = false,
    API = {
      {
        Type = "Luache",
        API = "dunno"
      }
    }
  }
})
Window:EditOpenButton({
  Title = "Luache Dashboard",
  Draggable = true,
  Color = ColorSequence.new(Color3.fromRGB(255, 125, 0), Color3.fromRGB(0, 255, 120))
})

-- Toggle Key
Window:SetToggleKey(Enum.KeyCode.H)
if game:GetService("UserInputService").KeyboardEnabled then
  WindUI:Notify({
    Title = "We detected your keyboard!",
    Content = "Use the 'H' key to toggle the window visibility.",
    Icon = "keyboard",
    Duration = 7
  })
end

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Dashboard = {
    API = ""
  },
  Players = {
    Players = {"jose", "fulano", "beltrano", "ciclano", "All Players [RISKY]"},
    Selected = "Select a Player"
  }
}

-- Almost
local function ConfirmDialog(context, func)
  Window:Dialog({
    Icon = "circle-question-mark",
    Title = "Are you sure?",
    Content = context,
    Buttons = {
      {
        Title = "Confirm",
        Icon = "check",
        Callback = func
      },
      {
        Title = "Cancel",
        Icon = "x",
        Callback = function() end
      }
    }
  })
end
local function IsSelected()
  if Settings.Players.Selected == "Select a Player" then
    return false, WindUI:Notify({
      Title = "No player selected!",
      Content = "You need to select a player.",
      Icon = "x",
      Duration = 3
    })
  end
  return true
end

-- Tabs
local Tabs = {
  Players = Window:Tab({ Title = "Players", Icon = "users-round"}),
  Window:Divider(),
  Credits = Window:Tab({ Title = "Credits", Icon = "info"})
}
Window:SelectTab(1)

-- Tabs
Tabs.Players:Section({ Title = #Settings.Players.Players - 1 .. " Active Players", Icon = "users-round" })
local PlayersDrop = Tabs.Players:Dropdown({
  Title = "Selected Player",
  Values = Settings.Players.Players,
  Value = Settings.Players.Selected,
  Desc = "List of all users using your service.",
  Callback = function(option)
    Settings.Players.Selected = option
  end
})
Tabs.Players:Button({
  Icon = "refresh-ccw",
  Title = "Refresh List",
  Desc = "Refreshs the list of active players.",
  Callback = function()
    print("Player list refreshed!")
  end
})
Tabs.Players:Section({ Title = "Action", Icon = "user-round-cog" })
Tabs.Players:Button({
  Icon = "map-pin",
  Title = "Bring Player",
  Desc = "Brings the player to your server.",
  Callback = function()
    ConfirmDialog(
      "Are you sure? This may cause the player to loose progress.",
      function()
        if IsSelected() then
          print("beleza, traz")
        end
      end
    )
  end
})
Tabs.Players:Button({
  Icon = "skull",
  Title = "Kill Player",
  Desc = "Kills the player, does not guarantee revive.",
  Callback = function()
    ConfirmDialog(
      "Are you sure? This may cause the player to loose progress.",
      function()
        if IsSelected() then
          eu.Character.Humanoid.Health = 0
          print("qm morre eh tu trouxa hahah")
        end
      end
    )
  end
})

-- Credits
Tabs.Credits:Section({ Title = "Developers" })
Tabs.Credits:Paragraph({
  Title = "Founder Developer",
  Desc = "Discord: @moligrafi",
})
Tabs.Credits:Section({ Title = "Discord Server" })
Tabs.Credits:Paragraph({
  Title = "Discord Server",
  Desc = "https://discord.gg/HBzXzscHyp",
  Buttons = {
    {
      Title = "Copy Server Link",
      Variant = "Primary",
      Callback = function()
        setclipboard("https://discord.gg/HBzXzscHyp")
      end,
      Icon = "link"
    }
  }
})

-- dev only
task.spawn(function()
  while task.wait(0.1) do
    if getgenv().DestroyPlease then
      Window:Destroy()
    end
  end
end)