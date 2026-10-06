local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local LP=Players.LocalPlayer

local C={
	Enabled=true,

	AimAssist=true,
	AimStrength=.35,
	Accuracy=85,
	ThrowPower=85,
	AutoTarget=true,
	MaxDistance=150,

	AutoCatch=true,
	CatchRadius=35,
	CatchDelay=.15,
	HighPriority=true,

	Speed=16,
	JumpBoost=false,
	JumpPower=50,
	Gravity=196.2,
	FOV=70,

	FPS=true,
	Visuals=true,
	UIScale=1,

	Preset="Legit",
	CustomQB=false,
	CustomBall=false,
	CustomAnimations=false
}

local Purple=Color3.fromRGB(130,40,255)
local BG=Color3.fromRGB(7,6,15)
local Card=Color3.fromRGB(13,11,27)
local Dark=Color3.fromRGB(20,15,38)
local Text=Color3.fromRGB(240,235,255)
local Muted=Color3.fromRGB(140,130,170)

local function N(c,p)
	local x=Instance.new(c)

	for k,v in pairs(p or {}) do
		x[k]=v
	end

	return x
end

local G=N("ScreenGui",{
	Name="ThunderHubFF3",
	ResetOnSpawn=false,
	Parent=LP:WaitForChild("PlayerGui")
})

local Main=N("Frame",{
	Parent=G,
	Size=UDim2.fromOffset(900,520),
	Position=UDim2.new(.5,-450,.5,-260),
	BackgroundColor3=BG,
	BorderSizePixel=0
})

N("UICorner",{
	Parent=Main,
	CornerRadius=UDim.new(0,18)
})

N("UIStroke",{
	Parent=Main,
	Color=Purple,
	Transparency=.35,
	Thickness=1
})

local Top=N("Frame",{
	Parent=Main,
	Size=UDim2.new(1,0,0,72),
	BackgroundColor3=Color3.fromRGB(10,8,20),
	BorderSizePixel=0
})

N("UICorner",{
	Parent=Top,
	CornerRadius=UDim.new(0,18)
})

-- THUNDER HUB BRAND

N("TextLabel",{
	Parent=Top,
	Position=UDim2.fromOffset(24,11),
	Size=UDim2.fromOffset(190,27),
	BackgroundTransparency=1,
	Text="⚡ THUNDER HUB",
	TextColor3=Text,
	Font=Enum.Font.GothamBold,
	TextSize=17,
	TextXAlignment=Enum.TextXAlignment.Left
})

N("TextLabel",{
	Parent=Top,
	Position=UDim2.fromOffset(27,39),
	Size=UDim2.fromOffset(100,18),
	BackgroundTransparency=1,
	Text="FF3",
	TextColor3=Purple,
	Font=Enum.Font.GothamBold,
	TextSize=11,
	TextXAlignment=Enum.TextXAlignment.Left
})

-- CONTENT

local Content=N("Frame",{
	Parent=Main,
	Position=UDim2.fromOffset(245,90),
	Size=UDim2.new(1,-270,1,-110),
	BackgroundTransparency=1
})

local Pages={}

local function Page(name)
	local p=N("Frame",{
		Parent=Content,
		Size=UDim2.fromScale(1,1),
		BackgroundTransparency=1,
		Visible=false
	})

	Pages[name]=p
	return p
end

local QB=Page("QB")
local Catch=Page("Catching")
local Physics=Page("Physics")
local Settings=Page("Settings")
local Customs=Page("Customs")

local function Show(name)
	for n,p in pairs(Pages) do
		p.Visible=n==name
	end
end

-- TABS

local Tabs={
	{"QB",225},
	{"Catching",355},
	{"Physics",485},
	{"Settings",615},
	{"Customs",745}
}

for _,data in ipairs(Tabs) do
	local name=data[1]
	local x=data[2]

	local b=N("TextButton",{
		Parent=Top,
		Position=UDim2.fromOffset(x,12),
		Size=UDim2.fromOffset(120,48),
		BackgroundColor3=Dark,
		Text=name,
		TextColor3=Muted,
		Font=Enum.Font.GothamSemibold,
		TextSize=12,
		AutoButtonColor=false
	})

	N("UICorner",{
		Parent=b,
		CornerRadius=UDim.new(0,12)
	})

	b.MouseButton1Click:Connect(function()
		Show(name)

		for _,v in ipairs(Top:GetChildren()) do
			if v:IsA("TextButton") then
				v.BackgroundColor3=Dark
				v.TextColor3=Muted
			end
		end

		b.BackgroundColor3=Color3.fromRGB(48,16,90)
		b.TextColor3=Text
	end)
end

-- TITLE

local function Title(p,t,d)
	N("TextLabel",{
		Parent=p,
		Position=UDim2.fromOffset(5,0),
		Size=UDim2.new(1,-10,0,30),
		BackgroundTransparency=1,
		Text=t,
		TextColor3=Text,
		Font=Enum.Font.GothamBold,
		TextSize=19,
		TextXAlignment=Enum.TextXAlignment.Left
	})

	N("TextLabel",{
		Parent=p,
		Position=UDim2.fromOffset(5,32),
		Size=UDim2.new(1,-10,0,22),
		BackgroundTransparency=1,
		Text=d,
		TextColor3=Muted,
		Font=Enum.Font.Gotham,
		TextSize=10,
		TextXAlignment=Enum.TextXAlignment.Left
	})
end

-- CARD

local function Card(p,x,y,w,h)
	local f=N("Frame",{
		Parent=p,
		Position=UDim2.fromOffset(x,y),
		Size=UDim2.fromOffset(w,h),
		BackgroundColor3=Card,
		BorderSizePixel=0
	})

	N("UICorner",{
		Parent=f,
		CornerRadius=UDim.new(0,12)
	})

	N("UIStroke",{
		Parent=f,
		Color=Color3.fromRGB(50,25,85),
		Transparency=.4
	})

	return f
end

-- TOGGLE

local function Toggle(p,y,name,desc,key,callback)
	N("TextLabel",{
		Parent=p,
		Position=UDim2.fromOffset(18,y),
		Size=UDim2.new(1,-90,0,20),
		BackgroundTransparency=1,
		Text=name,
		TextColor3=Text,
		Font=Enum.Font.GothamMedium,
		TextSize=12,
		TextXAlignment=Enum.TextXAlignment.Left
	})

	N("TextLabel",{
		Parent=p,
		Position=UDim2.fromOffset(18,y+20),
		Size=UDim2.new(1,-90,0,18),
		BackgroundTransparency=1,
		Text=desc,
		TextColor3=Muted,
		Font=Enum.Font.Gotham,
		TextSize=9,
		TextXAlignment=Enum.TextXAlignment.Left
	})

	local b=N("TextButton",{
		Parent=p,
		Position=UDim2.new(1,-62,0,y+4),
		Size=UDim2.fromOffset(45,26),
		Text="",
		AutoButtonColor=false,
		BackgroundColor3=C[key] and Purple or Color3.fromRGB(55,50,80)
	})

	N("UICorner",{
		Parent=b,
		CornerRadius=UDim.new(1,0)
	})

	local dot=N("Frame",{
		Parent=b,
		Size=UDim2.fromOffset(20,20),
		Position=UDim2.new(
			C[key] and 1 or 0,
			C[key] and -23 or 3,
			.5,
			-10
		),
		BackgroundColor3=Color3.new(1,1,1)
	})

	N("UICorner",{
		Parent=dot,
		CornerRadius=UDim.new(1,0)
	})

	b.MouseButton1Click:Connect(function()
		C[key]=not C[key]

		b.BackgroundColor3=C[key]
			and Purple
			or Color3.fromRGB(55,50,80)

		dot.Position=UDim2.new(
			C[key] and 1 or 0,
			C[key] and -23 or 3,
			.5,
			-10
		)

		if callback then
			callback(C[key])
		end
	end)
end

-- SLIDER

local function Slider(p,y,name,key,min,max,callback)
	N("TextLabel",{
		Parent=p,
		Position=UDim2.fromOffset(18,y),
		Size=UDim2.fromOffset(160,20),
		BackgroundTransparency=1,
		Text=name,
		TextColor3=Text,
		Font=Enum.Font.GothamMedium,
		TextSize=11,
		TextXAlignment=Enum.TextXAlignment.Left
	})

	local bar=N("Frame",{
		Parent=p,
		Position=UDim2.new(0,175,0,y+7),
		Size=UDim2.new(1,-240,0,6),
		BackgroundColor3=Color3.fromRGB(40,30,65)
	})

	N("UICorner",{
		Parent=bar,
		CornerRadius=UDim.new(1,0)
	})

	local fill=N("Frame",{
		Parent=bar,
		Size=UDim2.new(
			math.clamp((C[key]-min)/(max-min),0,1),
			0,1,0
		),
		BackgroundColor3=Purple
	})

	N("UICorner",{
		Parent=fill,
		CornerRadius=UDim.new(1,0)
	})

	local val=N("TextLabel",{
		Parent=p,
		Position=UDim2.new(1,-58,0,y-3),
		Size=UDim2.fromOffset(48,25),
		BackgroundColor3=Dark,
		Text=tostring(C[key]),
		TextColor3=Text,
		Font=Enum.Font.Gotham,
		TextSize=10
	})

	N("UICorner",{
		Parent=val,
		CornerRadius=UDim.new(0,6)
	})

	local dragging=false

	local function Set(x)
		local a=math.clamp(
			(x-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,
			0,
			1
		)

		C[key]=math.floor((min+(max-min)*a)*100)/100

		fill.Size=UDim2.new(a,0,1,0)
		val.Text=tostring(C[key])

		if callback then
			callback(C[key])
		end
	end

	bar.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=true
			Set(i.Position.X)
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
			Set(i.Position.X)
		end
	end)

	UIS.InputEnded:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 then
			dragging=false
		end
	end)
end

-- CHARACTER FUNCTIONS

local function GetCharacter()
	return LP.Character or LP.CharacterAdded:Wait()
end

local function GetHumanoid()
	return GetCharacter():FindFirstChildOfClass("Humanoid")
end

-- ACTUAL PHYSICS

local function ApplySpeed()
	local h=GetHumanoid()

	if h then
		h.WalkSpeed=C.Speed
	end
end

local function ApplyJump()
	local h=GetHumanoid()

	if h then
		h.UseJumpPower=true
		h.JumpPower=C.JumpBoost and C.JumpPower or 50
	end
end

local function ApplyGravity()
	workspace.Gravity=C.Gravity
end

local function ApplyFOV()
	local cam=workspace.CurrentCamera

	if cam then
		cam.FieldOfView=C.FOV
	end
end

LP.CharacterAdded:Connect(function()
	task.wait(.5)

	if C.Enabled then
		ApplySpeed()
		ApplyJump()
	end
end)

-- QB PAGE

Title(
	QB,
	"⚡ QB",
	"Quarterback controls and throwing settings."
)

local q=Card(QB,0,65,615,330)

Toggle(
	q,
	18,
	"Aim Assist",
	"Assist with QB aiming.",
	"AimAssist"
)

Slider(
	q,
	75,
	"Aim Strength",
	"AimStrength",
	0,
	1
)

Slider(
	q,
	133,
	"Accuracy",
	"Accuracy",
	0,
	100
)

Slider(
	q,
	191,
	"Throw Power",
	"ThrowPower",
	0,
	120
)

Toggle(
	q,
	249,
	"Auto Target",
	"Automatically select a receiver.",
	"AutoTarget"
)

-- CATCHING PAGE

Title(
	Catch,
	"⚡ Catching",
	"Configure catching assistance and catch timing."
)

local ca=Card(Catch,0,65,615,330)

Toggle(
	ca,
	18,
	"Auto Catch",
	"Automatically catch the ball when in range.",
	"AutoCatch"
)

Slider(
	ca,
	75,
	"Catch Radius",
	"CatchRadius",
	5,
	100
)

Slider(
	ca,
	133,
	"Catch Delay",
	"CatchDelay",
	0,
	.5
)

Toggle(
	ca,
	191,
	"High Priority (QB)",
	"Prioritize QB catches.",
	"HighPriority"
)

-- PHYSICS PAGE

Title(
	Physics,
	"⚙ Physics",
	"Movement and gameplay physics."
)

local ph=Card(Physics,0,65,615,370)

Slider(
	ph,
	18,
	"Speed",
	"Speed",
	16,
	100,
	ApplySpeed
)

Toggle(
	ph,
	76,
	"Jump Boost",
	"Increase your jump power.",
	"JumpBoost",
	ApplyJump
)

Slider(
	ph,
	134,
	"Jump Power",
	"JumpPower",
	50,
	150,
	ApplyJump
)

Slider(
	ph,
	192,
	"Gravity",
	"Gravity",
	50,
	250,
	ApplyGravity
)

Slider(
	ph,
	250,
	"FOV",
	"FOV",
	50,
	120,
	ApplyFOV
)

local reset=N("TextButton",{
	Parent=ph,
	Position=UDim2.fromOffset(18,310),
	Size=UDim2.fromOffset(180,38),
	BackgroundColor3=Dark,
	Text="RESET PHYSICS",
	TextColor3=Text,
	Font=Enum.Font.GothamBold,
	TextSize=11
})

N("UICorner",{
	Parent=reset,
	CornerRadius=UDim.new(0,8)
})

reset.MouseButton1Click:Connect(function()
	C.Speed=16
	C.JumpBoost=false
	C.JumpPower=50
	C.Gravity=196.2
	C.FOV=70

	ApplySpeed()
	ApplyJump()
	ApplyGravity()
	ApplyFOV()
end)

-- SETTINGS

Title(
	Settings,
	"⚙ Settings",
	"General Thunder Hub settings."
)

local se=Card(Settings,0,65,615,330)

Toggle(
	se,
	18,
	"System Enabled",
	"Enable the system.",
	"Enabled",
	function(v)
		if v then
			ApplySpeed()
			ApplyJump()
		else
			local h=GetHumanoid()

			if h then
				h.WalkSpeed=16
				h.JumpPower=50
			end
		end
	end
)

Toggle(
	se,
	75,
	"FPS Boost",
	"Performance mode.",
	"FPS"
)

Toggle(
	se,
	132,
	"Visuals",
	"Enable visual improvements.",
	"Visuals"
)

local kill=N("TextButton",{
	Parent=se,
	Position=UDim2.fromOffset(18,205),
	Size=UDim2.fromOffset(180,42),
	BackgroundColor3=Color3.fromRGB(80,25,45),
	Text="KILL CLIENT",
	TextColor3=Text,
	Font=Enum.Font.GothamBold,
	TextSize=11
})

N("UICorner",{
	Parent=kill,
	CornerRadius=UDim.new(0,8)
})

kill.MouseButton1Click:Connect(function()
	G:Destroy()
end)

-- CUSTOMS

Title(
	Customs,
	"☷ Customs",
	"Presets and custom configuration."
)

local cu=Card(Customs,0,65,615,330)

local Presets={
	Legit={
		AimStrength=.35,
		Accuracy=85,
		ThrowPower=85,
		CatchRadius=35,
		CatchDelay=.15
	},

	Advanced={
		AimStrength=.7,
		Accuracy=95,
		ThrowPower=100,
		CatchRadius=60,
		CatchDelay=.1
	},

	Blatant={
		AimStrength=1,
		Accuracy=100,
		ThrowPower=120,
		CatchRadius=100,
		CatchDelay=0
	}
}

local function ApplyPreset(name)
	local p=Presets[name]

	if not p then
		return
	end

	for k,v in pairs(p) do
		C[k]=v
	end

	C.Preset=name
end

for i,name in ipairs({"Legit","Advanced","Blatant"}) do
	local b=N("TextButton",{
		Parent=cu,
		Position=UDim2.fromOffset(18+(i-1)*195,20),
		Size=UDim2.fromOffset(175,42),
		BackgroundColor3=name==C.Preset and Purple or Dark,
		Text=name,
		TextColor3=Text,
		Font=Enum.Font.GothamBold,
		TextSize=12
	})

	N("UICorner",{
		Parent=b,
		CornerRadius=UDim.new(0,8)
	})

	b.MouseButton1Click:Connect(function()
		ApplyPreset(name)

		for _,v in ipairs(cu:GetChildren()) do
			if v:IsA("TextButton") then
				v.BackgroundColor3=Dark
			end
		end

		b.BackgroundColor3=Purple
	end)
end

Toggle(
	cu,
	90,
	"Custom QB Model",
	"Use a custom QB model.",
	"CustomQB"
)

Toggle(
	cu,
	147,
	"Custom Ball",
	"Use a custom football model.",
	"CustomBall"
)

Toggle(
	cu,
	204,
	"Custom Animations",
	"Use custom animations.",
	"CustomAnimations"
)

-- DEFAULT PAGE

Show("QB")

-- DRAGGING

local dragging=false
local startMouse
local startPos

Top.InputBegan:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=true
		startMouse=i.Position
		startPos=Main.Position
	end
end)

UIS.InputChanged:Connect(function(i)
	if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
		local d=i.Position-startMouse

		Main.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+d.X,
			startPos.Y.Scale,
			startPos.Y.Offset+d.Y
		)
	end
end)

UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=false
	end
end)

-- CTRL HIDE / SHOW

UIS.InputBegan:Connect(function(i,gp)
	if not gp
		and i.KeyCode==Enum.KeyCode.LeftControl
		and G.Parent
	then
		G.Enabled=not G.Enabled
	end
end)

-- INITIAL PHYSICS

task.defer(function()
	ApplySpeed()
	ApplyJump()
	ApplyGravity()
	ApplyFOV()
end)
