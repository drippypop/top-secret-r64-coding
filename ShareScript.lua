local share = workspace.share
dss = game:GetService("DataStoreService"):GetDataStore("savedata")

share.givedata.OnServerEvent:connect(function(plr)
	local plam
	if workspace.plam:FindFirstChild(plr.Name)then
		plam = workspace.plam[plr.Name]
	else
		plam = script.plam:Clone()
		plam.Parent = workspace.plam
		plam.Name = plr.Name
	end
	local savedata
	repeat wait()
		local e = pcall(function()
			savedata = dss:GetAsync(plr.UserId)
		end)
	until e
	--savedata=nil
	local beepack = game.BadgeService:UserHasBadge(plr.userId, 1210167680) or plr.UserId == 171369101 or plr.UserId == 455816580
	local passes = {game:GetService("MarketplaceService"):UserOwnsGamePassAsync(plr.UserId, 3376023)--gime money pass
		,beepack--beesmas
		,false
		,false
		,false
		,false
		,game:GetService("MarketplaceService"):PlayerOwnsAsset(plr,939138794) or plr.UserId == 455816580--pukashell (nerd badge to comic)
		,game:GetService("MarketplaceService"):PlayerOwnsAsset(plr,1665484712)--mixtapes
		,game:GetService("MarketplaceService"):PlayerOwnsAsset(plr,2535464301)--beebo jetpack
		}
		
	if savedata then
	if #savedata[3]	< share.skins.Value then
		repeat savedata[3]= savedata[3].."0" until  #savedata[3] == share.skins.Value
	end
	end
	
	if savedata and savedata[3] and string.sub(savedata[3],1,1) == "0" then
		savedata[3] = "1"..string.sub(savedata[3],2)
	end
	
	
	share.givedata:FireClient(plr, plam, savedata, passes)
end)

share.save.OnServerEvent:connect(function(plr, savedata)
	dss:SetAsync(plr.UserId, savedata)
	share.save:FireClient(plr)
end)

share.replicate.OnServerEvent:connect(function(plr, plam, lst) --edited 10/1/2021 to fix the personalization exploit (hilarious)

	local newplam

	if workspace.plam:FindFirstChild(plr.Name) then
		newplam = workspace.plam:FindFirstChild(plr.Name)
	end

	if not newplam then return end

	for i,v in pairs(lst)do
		newplam[i].Value = v
	end
end)

game.Players.ChildRemoved:connect(function(nm)
	local plam = workspace.plam:FindFirstChild(nm.Name)
	wait(1)
	if plam then plam:Destroy()end
end)


share.removeplam.OnServerEvent:Connect(function(plr)
	
	workspace.plam:FindFirstChild(plr.Name):Destroy()
	
end)
