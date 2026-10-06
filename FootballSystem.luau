local UIS=game:GetService("UserInputService")
local Players=game:GetService("Players")
local LP=Players.LocalPlayer

local C={
	Preset="Legit",Enabled=true,
	AimAssist=true,AimStrength=.35,Accuracy=85,ThrowPower=85,AutoTarget=true,MaxDistance=150,
	CatchAssist=true,CatchRadius=4,CatchWindow=.2,
	Prediction=.2,Gravity=196.2,BallVelocity=100,AirResistance=.98
}

local Presets={
	Legit={.35,85,85,4,.2,.2},
	Advanced={.7,95,100,6,.35,.32},
	Blatant={1,100,120,10,.6,.5}
}

local function apply(p)
	local x=Presets[p]
	C.Preset=p
	C.AimStrength=x[1]
	C.Accuracy=x[2]
	C.ThrowPower=x[3]
	C.CatchRadius=x[4]
	C.CatchWindow=x[5]
	C.Prediction=x[6]
end

local G=Instance.new("ScreenGui")
G.Name="FootballSystem"
G.ResetOnSpawn=false
G.Parent=LP:WaitForChild("PlayerGui")

local F=Instance.new("Frame",G)
F.Size=UDim2.fromOffset(600,400)
F.Position=UDim2.new(.5,-300,.5,-200)
F.BackgroundColor3=Color3.fromRGB(18,18,22)
Instance.new("UICorner",F).CornerRadius=UDim.new(0,10)

local Title=Instance.new("TextLabel",F)
Title.Size=UDim2.new(1,0,0,45)
Title.BackgroundTransparency=1
Title.Text="FOOTBALL SYSTEM"
Title.TextColor3=Color3.new(1,1,1)
Title.Font=Enum.Font.GothamBold
Title.TextSize=16

local Side=Instance.new("Frame",F)
Side.Size=UDim2.new(0,140,1,-45)
Side.Position=UDim2.fromOffset(0,45)
Side.BackgroundColor3=Color3.fromRGB(13,13,16)

local Page=Instance.new("Frame",F)
Page.Size=UDim2.new(1,-155,1,-55)
Page.Position=UDim2.fromOffset(150,50)
Page.BackgroundTransparency=1

local function clear()
	for _,v in Page:GetChildren() do v:Destroy() end
end

local function label(t,y)
	local l=Instance.new("TextLabel",Page)
	l.Size=UDim2.new(1,-10,0,30)
	l.Position=UDim2.fromOffset(5,y)
	l.BackgroundTransparency=1
	l.Text=t
	l.TextXAlignment=Enum.TextXAlignment.Left
	l.TextColor3=Color3.new(1,1,1)
	l.Font=Enum.Font.Gotham
	l.TextSize=13
	return l
end

local function button(parent,text,y,fn)
	local b=Instance.new("TextButton",parent)
	b.Size=UDim2.new(1,-10,0,38)
	b.Position=UDim2.fromOffset(5,y)
	b.BackgroundColor3=Color3.fromRGB(28,28,34)
	b.Text=text
	b.TextColor3=Color3.new(1,1,1)
	b.Font=Enum.Font.GothamMedium
	b.TextSize=12
	Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
	b.MouseButton1Click:Connect(fn)
	return b
end

local function toggle(name,key,y)
	local b=button(Page,name..": "..tostring(C[key]),y,function()
		C[key]=not C[key]
		b.Text=name..": "..tostring(C[key])
	end)
end

local function tab(name,y,fn)
	button(Side,name,y,fn)
end

local function qb()
	clear()
	label("QUARTERBACK",5)
	toggle("Aim Assist","AimAssist",45)
	toggle("Auto Target","AutoTarget",90)
	label("Aim Strength: "..C.AimStrength,135)
	label("Accuracy: "..C.Accuracy.."%",170)
	label("Throw Power: "..C.ThrowPower,205)
	label("Max Distance: "..C.MaxDistance,240)
end

local function catch()
	clear()
	label("CATCHING",5)
	toggle("Catch Assist","CatchAssist",45)
	label("Catch Radius: "..C.CatchRadius,90)
	label("Catch Window: "..C.CatchWindow,125)
end

local function physics()
	clear()
	label("PHYSICS",5)
	label("Prediction: "..C.Prediction,45)
	label("Gravity: "..C.Gravity,80)
	label("Ball Velocity: "..C.BallVelocity,115)
	label("Air Resistance: "..C.AirResistance,150)
end

local function settings()
	clear()
	label("SETTINGS",5)
	toggle("System Enabled","Enabled",45)
	button(Page,"Preset: "..C.Preset,90,function()
		local p={Legit="Advanced",Advanced="Blatant",Blatant="Legit"}
		apply(p[C.Preset])
		settings()
	end)
	local kill=button(Page,"KILL CLIENT",145,function()
		G:Destroy()
		_G.FootballSystem=nil
	end)
	kill.BackgroundColor3=Color3.fromRGB(90,35,40)
end

tab("Quarterback",10,qb)
tab("Catching",55,catch)
tab("Physics",100,physics)
tab("Settings",145,settings)

qb()

local dragging,dragStart,startPos
Title.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=true
		dragStart=i.Position
		startPos=F.Position
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
		local d=i.Position-dragStart
		F.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
end)

UIS.InputBegan:Connect(function(i,gp)
	if not gp and i.KeyCode==Enum.KeyCode.LeftControl and G.Parent then
		G.Enabled=not G.Enabled
	end
end)
