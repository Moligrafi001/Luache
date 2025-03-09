## Luache Library: `Vitae 0.1`

Welcome! This tutorial explains how to use the **Luche Vitae Library**. This powerful library is designed for authentication and implementing functionalities within your script, adding more server side to your client. Each section below breaks down how to load, configure, and utilize the library's key features.

---

## 1. Loading the Library

First, load the library directly from GitHub using `loadstring` combined with `game:HttpGet`, which retrieves and executes the remote code.

```lua
local Luache = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luche-Vitae/refs/heads/main/Auth.lua"))() -- Load the Library
```

## 2. Initializing Settings

After you set up the the library you'll have to set your settings below. Don't forget to add a valid service in the `Service` section.

```lua
Luache:Settings({ -- Load your settings
  Service = "hallowhub", -- Your service identificator
  DebugMode = true, -- Debug things in console
})
```

## 3. Implementation Functions

These are the codes to implement and connect your functions to your service, you can `Log Statistic`, `Check Banned`, `Send Webhook` and use `Everything` to do the same as the 3 other ones.

```lua
-- Implementation Functions
Luache:Implement("Log Statistic") -- Log this execution statistics
Luache:Implement("Check Banned") -- Check if the user is banned
Luache:Implement("Send Webhook") -- Send webhook embed
Luache:Implement("Everything") -- Will do the same as the 3 above
```

> Every implementation has a 30s cooldown to avoid spammers, it means that: For example, you execute:

```lua
Luache:Implement("Log Statistic") -- Log this execution statistics
Luache:Implement("Check Banned") -- Check if the user is banned
```

The server will only execute the Log Statistic and then it won't check the banned, because it has a 30s cooldown for every implementation, that's why we have `Luache:Implement("Everything")`, it will check if the user is banned, if it's not then it will proceed to the log and send webhook.

## Final Example Code

This is a exemple code, you can customize it the way you want, fell free to add and customize your own functions.

```lua
local Luache = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luche-Vitae/refs/heads/main/Source/Library.lua"))() -- Load the Library

Luache:Settings({ -- Load your settings
  Service = "yourservice", -- Your service identificator
  DebugMode = true, -- Debug things in console
  
  KeySystem = { -- Delete this if you're not using the key system
    GuiMode = true, -- Simple GUI to the key
    SaveKey = true -- Save valid key
  }
})

if not Luache:Implement("Check Banned") then return end -- Will stop the script if the user is banned

-- Key System Functions
local function ValidateKey(key) -- Your own custom function to check the key
  if Luache:AuthKey(key) == "valid" then -- If key is valid
    print("Key is valid, loading...") -- Valid notification
    -- If the user isn't banned and the key is valid
    return true
  elseif Luache:AuthKey(key) == "expired" then -- If key expired
    print("Key expired!") -- Expired notification
  elseif Luache:AuthKey(key) == "invalid" then -- If key is invalid
    print("Key is invalid!") -- Invalid notification
  else -- If authentication failed
    print("Failed to check the key.") -- Failed to check key notification
  end -- Add your own actions
  return false
end
local function GetKey() -- Your own custom function to get key
  setclipboard(Luache:GetKey()) -- Will copy the get key url
end

if ValidateKey("YOUR-KEY-HERE") then
  Luache:Implement("Send Webhook") -- Send webhook embed
  Luache:Implement("Log Statistic") -- Log this execution Statistic
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() -- Will execute infiniteyield
else
  GetKey()
end
```

> Is your responsability to integrate the code in your script
