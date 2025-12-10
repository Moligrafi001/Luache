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
  
  return success, message -- Returns the same as the Luache check function
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