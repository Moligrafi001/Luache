## Luache Library: `Vitae 0.2`

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
local Luache = loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Luache/main/Source/Library.lua"))() -- Load the Library

Luache:Settings({ -- Load your settings
  Service = "yourservice", -- Your service identificator
  DebugMode = true -- Debug things in console
})

if not Luache:Implement("Check Banned") then return end -- Will stop the script if the user is banned

-- Key System Functions
local function ValidateKey(key) -- Your own custom function to check the key
  local success, message = Luache:Check(key) -- Checks the key and store the results
  
  if success then -- success is a boolean: true / false
    print("Valid!")
  else
    print("Invalid!")
  end
  
  print(message) -- message is a 2nd arg sent from the check function telling you the reason for the result
  
  result success, message -- Returns the same as the Luache check function
end
local function GetKey() -- Your own custom function to get key
  setclipboard(Luache:GetKey()) -- Will copy the get key url returned by Luache
end

if ValidateKey("YOUR-KEY-HERE") then
  Luache:Implement("Everything") -- Send webhook embed
  
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() -- Will execute infiniteyield
else
  GetKey() -- Will copy the getkey link if the key wasn't valid
end
```

> Is your responsability to integrate the code in your script
