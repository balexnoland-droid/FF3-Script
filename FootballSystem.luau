local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local P=Players.LocalPlayer

local C={
	Enabled=true,AutoCatch=true,CatchRadius=35,CatchDelay=.15,HighPriority=true,
	BallPhysics=true,Gravity=1,Wind=.25,Collision=true,
	FPS=true,Visuals=true,UIScale=1,
	Preset="Legit",CustomQB=false,CustomBall=false,CustomAnimations=false
}

local Purple=Color3.fromRGB(125,35,255)
local BG=Color3.fromRGB(7,6,15)
local Card=Color3.fromRGB(13,11,27)
local Dark=Color3.fromRGB(18,15,38)
local Text=Color3.fromRGB(235,230,255)
local Muted=Color3.fromRGB(135,125,165)

local function new(c,p)
	local x=Instance.new(c)
	for k,v in pairs(p or {}) do x[k]=v end
	return x
end

local G=new("ScreenGui",{Name="ThunderUI",ResetOnSpawn=false,Parent=P.PlayerGui})

local Main=new("Frame",{
	Parent=G,Size=UDim2.fromOffset(900,520),
	Position=UDim2.new(.5,-450,.5,-260),
	BackgroundColor3=BG,BorderSizePixel=0
})
new("UICorner",{Parent=Main,CornerRadius=UDim.new(0,18)})
new("UIStroke",{Parent=Main,Color=Purple,Transparency=.35,Thickness=1})

local Top=new("Frame",{
	Parent=Main,Size=UDim2.new(1,0,0,75),
	BackgroundColor3=Color3.fromRGB(10,8,20),BorderSizePixel=0
})
new("UICorner",{Parent=Top,CornerRadius=UDim.new(0,18)})

local Brand=new("TextLabel",{
	Parent=Main,Position=UDim2.fromOffset(30,105),
	Size=UDim2.fromOffset(210,45),
	BackgroundTransparency=1,
	Text="⚡  T H U N D E R",
	TextColor3=Text,Font=Enum.Font.GothamBold,TextSize=22,
	TextXAlignment=Enum.TextXAlignment.Left
})

local Sub=new("TextLabel",{
	Parent=Main,Position=UDim2.fromOffset(32,155),
	Size=UDim2.fromOffset(180,100),
	BackgroundTransparency=1,
	Text="Q B   C A T C H I N G\nP H Y S I C S\nS E T T I N G S\nC U S T O M S",
	TextColor3=Muted,Font=Enum.Font.GothamMedium,TextSize=11,
	TextXAlignment=Enum.TextXAlignment.Left,
	TextYAlignment=Enum.TextYAlignment.Top,
	LineHeight=1.7
})

local Content=new("Frame",{
	Parent=Main,Position=UDim2.fromOffset(250,90),
	Size=UDim2.new(1,-275,1,-110),
	BackgroundTransparency=1
})

local Pages={}

local function page(name)
	local f=new("Frame",{Parent=Content,Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false})
	Pages[name]=f
	return f
end

local QB=page("QB Catching")
local PHY=page("Physics")
local SET=page("Settings")
local CUS=page("Customs")

local function show(name)
	for n,f in pairs(Pages) do f.Visible=n==name end
end

local Tabs={"QB Catching","Physics","Settings","Customs"}

for i,name in ipairs(Tabs) do
	local b=new("TextButton",{
		Parent=Top,Position=UDim2.fromOffset(265+(i-1)*155,12),
		Size=UDim2.fromOffset(145,50),
		BackgroundColor3=Dark,Text=name,
		TextColor3=Muted,Font=Enum.Font.GothamSemibold,TextSize=14,
		AutoButtonColor=false
	})
	new("UICorner",{Parent=b,CornerRadius=UDim.new(0,14)})
	b.MouseButton1Click:Connect(function()
		show(name)
		for _,v in ipairs(Top:GetChildren()) do
			if v:IsA("TextButton") then
				v.TextColor3=Muted
				v.BackgroundColor3=Dark
			end
		end
		b.TextColor3=Text
		b.BackgroundColor3=Color3.fromRGB(43,15,80)
	end)
end

local function title(parent,t,desc)
	new("TextLabel",{
		Parent=parent,Position=UDim2.fromOffset(5,0),
		Size=UDim2.new(1,-10,0,32),BackgroundTransparency=1,
		Text=t,TextColor3=Text,Font=Enum.Font.GothamBold,TextSize=19,
		TextXAlignment=Enum.TextXAlignment.Left
	})
	new("TextLabel",{
		Parent=parent,Position=UDim2.fromOffset(5,31),
		Size=UDim2.new(1,-10,0,25),BackgroundTransparency=1,
		Text=desc,TextColor3=Muted,Font=Enum.Font.Gotham,TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left
	})
end

local function card(parent,x,y,w,h)
	local f=new("Frame",{
		Parent=parent,Position=UDim2.fromOffset(x,y),
		Size=UDim2.fromOffset(w,h),BackgroundColor3=Card,BorderSizePixel=0
	})
	new("UICorner",{Parent=f,CornerRadius=UDim.new(0,12)})
	new("UIStroke",{Parent=f,Color=Color3.fromRGB(45,25,80),Transparency=.35})
	return f
end

local function toggle(parent,y,name,desc,key)
	new("TextLabel",{
		Parent=parent,Position=UDim2.fromOffset(18,y),
		Size=UDim2.new(1,-85,0,20),BackgroundTransparency=1,
		Text=name,TextColor3=Text,Font=Enum.Font.GothamMedium,TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left
	})
	new("TextLabel",{
		Parent=parent,Position=UDim2.fromOffset(18,y+20),
		Size=UDim2.new(1,-85,0,20),BackgroundTransparency=1,
		Text=desc,TextColor3=Muted,Font=Enum.Font.Gotham,TextSize=10,
		TextXAlignment=Enum.TextXAlignment.Left
	})
	local b=new("TextButton",{
		Parent=parent,Position=UDim2.new(1,-62,0,y+4),
		Size=UDim2.fromOffset(45,26),Text="",AutoButtonColor=false,
		BackgroundColor3=C[key] and Purple or Color3.fromRGB(55,50,80)
	})
	new("UICorner",{Parent=b,CornerRadius=UDim.new(1,0)})
	local dot=new("Frame",{Parent=b,Size=UDim2.fromOffset(20,20),Position=UDim2.new(C[key] and 1 or 0, C[key] and -23 or 3,.5,-10),BackgroundColor3=Color3.new(1,1,1)})
	new("UICorner",{Parent=dot,CornerRadius=UDim.new(1,0)})
	b.MouseButton1Click:Connect(function()
		C[key]=not C[key]
		b.BackgroundColor3=C[key] and Purple or Color3.fromRGB(55,50,80)
		dot.Position=UDim2.new(C[key] and 1 or 0,C[key] and -23 or 3,.5,-10)
	end)
end

local function slider(parent,y,name,key,min,max)
	new("TextLabel",{
		Parent=parent,Position=UDim2.fromOffset(18,y),
		Size=UDim2.fromOffset(180,20),BackgroundTransparency=1,
		Text=name,TextColor3=Text,Font=Enum.Font.GothamMedium,TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left
	})
	local bar=new("Frame",{
		Parent=parent,Position=UDim2.new(0,190,0,y+7),
		Size=UDim2.new(1,-255,0,6),BackgroundColor3=Color3.fromRGB(40,30,65)
	})
	new("UICorner",{Parent=bar,CornerRadius=UDim.new(1,0)})
	local fill=new("Frame",{Parent=bar,Size=UDim2.new((C[key]-min)/(max-min),0,1,0),BackgroundColor3=Purple})
	new("UICorner",{Parent=fill,CornerRadius=UDim.new(1,0)})
	local val=new("TextLabel",{
		Parent=parent,Position=UDim2.new(1,-58,0,y-2),
		Size=UDim2.fromOffset(48,25),BackgroundColor3=Dark,
		Text=tostring(C[key]),TextColor3=Text,Font=Enum.Font.Gotham,TextSize=11
	})
	new("UICorner",{Parent=val,CornerRadius=UDim.new(0,6)})

	local function set(x)
		local a=math.clamp((x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
		C[key]=math.floor((min+(max-min)*a)*100)/100
		fill.Size=UDim2.new(a,0,1,0)
		val.Text=tostring(C[key])
	end
	bar.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then set(i.Position.X) end
	end)
	UIS.InputChanged:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseMovement and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
			if i.Position.X>=bar.AbsolutePosition.X and i.Position.X<=bar.AbsolutePosition.X+bar.AbsoluteSize.X then set(i.Position.X) end
		end
	end)
end

title(QB,"⚡  QB Catching","Configure catching assistance and QB priority.")
local q1=card(QB,0,65,300,285)
toggle(q1,15,"Auto Catch","Automatically catch the ball when in range.","AutoCatch")
slider(q1,72,"Catch Radius","CatchRadius",5,100)
slider(q1,130,"Catch Delay","CatchDelay",0,.5)
toggle(q1,195,"High Priority (QB)","Prioritize QB catches over others.","HighPriority")

local q2=card(QB,315,65,300,285)
toggle(q2,15,"Ball Physics","Improve ball movement and realism.","BallPhysics")
slider(q2,72,"Gravity Control","Gravity",.1,2)
slider(q2,130,"Wind Effect","Wind",0,1)
toggle(q2,195,"Collision Quality","Improve player and ball collisions.","Collision")

title(PHY,"⚙  Physics","Adjust ball movement and physics behavior.")
local p1=card(PHY,0,65,615,285)
toggle(p1,15,"Ball Physics","Improve ball movement and realism.","BallPhysics")
slider(p1,72,"Gravity","Gravity",.1,2)
slider(p1,130,"Wind","Wind",0,1)
slider(p1,188,"UI Scale","UIScale",.7,1.3)
toggle(p1,245,"Collision Quality","Improve collisions.","Collision")

title(SET,"⚙  Settings","General system settings.")
local s1=card(SET,0,65,615,285)
toggle(s1,15,"System Enabled","Enable the Thunder system.","Enabled")
toggle(s1,72,"FPS Boost","Optimize performance.","FPS")
toggle(s1,129,"Visuals","Enable visual improvements.","Visuals")

local kill=new("TextButton",{
	Parent=s1,Position=UDim2.fromOffset(18,200),Size=UDim2.fromOffset(180,42),
	BackgroundColor3=Color3.fromRGB(80,25,45),Text="KILL CLIENT",
	TextColor3=Text,Font=Enum.Font.GothamBold,TextSize=12
})
new("UICorner",{Parent=kill,CornerRadius=UDim.new(0,8)})
kill.MouseButton1Click:Connect(function() G:Destroy() end)

title(CUS,"☷  Customs","Presets and custom configuration.")
local c1=card(CUS,0,65,615,285)

for i,name in ipairs({"Legit","Advanced","Blatant"}) do
	local b=new("TextButton",{
		Parent=c1,Position=UDim2.fromOffset(18+(i-1)*195,25),
		Size=UDim2.fromOffset(175,45),
		BackgroundColor3=name==C.Preset and Purple or Dark,
		Text=name,TextColor3=Text,Font=Enum.Font.GothamBold,TextSize=13
	})
	new("UICorner",{Parent=b,CornerRadius=UDim.new(0,8)})
	b.MouseButton1Click:Connect(function()
		C.Preset=name
		for _,v in ipairs(c1:GetChildren()) do
			if v:IsA("TextButton") then v.BackgroundColor3=Dark end
		end
		b.BackgroundColor3=Purple
	end)
end

toggle(c1,100,"Custom QB Model","Use a custom QB model.","CustomQB")
toggle(c1,157,"Custom Ball","Use a custom football model.","CustomBall")
toggle(c1,214,"Custom Animations","Use custom animations.","CustomAnimations")

show("QB Catching")

-- Dragging
local drag,ds,sp
Top.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		drag=true;ds=i.Position;sp=Main.Position
	end
end)
UIS.InputChanged:Connect(function(i)
	if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
		local d=i.Position-ds
		Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
	end
end)
UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end
end)

-- CTRL = HIDE / SHOW
UIS.InputBegan:Connect(function(i,gp)
	if not gp and i.KeyCode==Enum.KeyCode.LeftControl and G.Parent then
		G.Enabled=not G.Enabled
	end
end)
