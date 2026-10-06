local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local C = {
	Enabled = true,

	AimAssist = true,
	AimStrength = .35,
	Accuracy = 85,
	ThrowPower = 85,
	AutoTarget = true,

	AutoCatch = true,
	CatchRadius = 35,
	CatchDelay = .15,
	HighPriority = true,

	Speed = 16,
	JumpBoost = false,
	JumpPower = 50,
	Gravity = 196.2,
	FOV = 70,

	FPS = true,
	Visuals = true,

	Preset = "Legit",
	CustomQB = false,
	CustomBall = false,
	CustomAnimations = false
}

--==================================================
-- COLORS
--==================================================

local PURPLE = Color3.fromRGB(135, 40, 255)
local PURPLE2 = Color3.fromRGB(75, 20, 145)
local BG = Color3.fromRGB(6, 5, 13)
local CARD = Color3.fromRGB(13, 10, 26)
local DARK = Color3.fromRGB(22, 16, 40)
local TEXT = Color3.fromRGB(240, 235, 255)
local MUTED = Color3.fromRGB(145, 135, 170)

--==================================================
-- HELPERS
--==================================================

local function New(class, props)
	local obj = Instance.new(class)

	for k, v in pairs(props or {}) do
		obj[k] = v
	end

	return obj
end

local function Corner(obj, radius)
	New("UICorner", {
		Parent = obj,
		CornerRadius = UDim.new(0, radius)
	})
end

--==================================================
-- GUI
--==================================================

local GUI = New("ScreenGui", {
	Name = "ThunderHubFF3",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	Parent = PG
})

local Main = New("Frame", {
	Parent = GUI,
	Size = UDim2.fromOffset(900, 520),
	Position = UDim2.new(.5, -450, .5, -260),
	BackgroundColor3 = BG,
	BorderSizePixel = 0,
	ClipsDescendants = true
})

Corner(Main, 18)

New("UIStroke", {
	Parent = Main,
	Color = PURPLE,
	Transparency = .25,
	Thickness = 1
})

--==================================================
-- LIGHTNING BACKGROUND
--==================================================

local LightningLayer = New("Frame", {
	Parent = Main,
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
	ZIndex = 0
})

local function Lightning(x, y, length, angle)
	local bolt = New("Frame", {
		Parent = LightningLayer,
		AnchorPoint = Vector2.new(.5, 0),
		Position = UDim2.new(x, 0, y, 0),
		Size = UDim2.fromOffset(2, length),
		BackgroundColor3 = PURPLE,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Rotation = angle,
		ZIndex = 0
	})

	return bolt
end

local Bolts = {
	Lightning(.15, -.1, 210, 24),
	Lightning(.30, .0, 170, -18),
	Lightning(.55, -.1, 250, 16),
	Lightning(.76, -.05, 220, -25),
	Lightning(.92, .1, 190, 20)
}

task.spawn(function()
	while GUI.Parent do
		task.wait(math.random(25, 55) / 10)

		for _, bolt in ipairs(Bolts) do
			bolt.BackgroundTransparency = 0.55
		end

		task.wait(.05)

		for _, bolt in ipairs(Bolts) do
			bolt.BackgroundTransparency = 0.05
		end

		task.wait(.07)

		for _, bolt in ipairs(Bolts) do
			bolt.BackgroundTransparency = .75
		end

		task.wait(.08)

		for _, bolt in ipairs(Bolts) do
			bolt.BackgroundTransparency = 1
		end
	end
end)

--==================================================
-- TOP BAR
--==================================================

local Top = New("Frame", {
	Parent = Main,
	Size = UDim2.new(1, 0, 0, 72),
	BackgroundColor3 = Color3.fromRGB(10, 8, 20),
	BorderSizePixel = 0,
	ZIndex = 5
})

Corner(Top, 18)

New("TextLabel", {
	Parent = Top,
	Position = UDim2.fromOffset(25, 13),
	Size = UDim2.fromOffset(190, 24),
	BackgroundTransparency = 1,
	Text = "⚡ THUNDER HUB",
	TextColor3 = TEXT,
	Font = Enum.Font.GothamBold,
	TextSize = 17,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 6
})

New("TextLabel", {
	Parent = Top,
	Position = UDim2.fromOffset(27, 39),
	Size = UDim2.fromOffset(80, 18),
	BackgroundTransparency = 1,
	Text = "FF3",
	TextColor3 = PURPLE,
	Font = Enum.Font.GothamBold,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
	ZIndex = 6
})

--==================================================
-- CONTENT
--==================================================

local Content = New("Frame", {
	Parent = Main,
	Position = UDim2.fromOffset(235, 90),
	Size = UDim2.new(1, -260, 1, -105),
	BackgroundTransparency = 1,
	ZIndex = 2
})

local Pages = {}

local function MakePage(name)
	local page = New("Frame", {
		Parent = Content,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Visible = false,
		ZIndex = 2
	})

	Pages[name] = page

	return page
end

local QB = MakePage("QB")
local Catching = MakePage("Catching")
local Physics = MakePage("Physics")
local Settings = MakePage("Settings")
local Customs = MakePage("Customs")

local function ShowPage(name)
	for pageName, page in pairs(Pages) do
		page.Visible = pageName == name
	end
end

--==================================================
-- TABS
--==================================================

local TabNames = {
	"QB",
	"Catching",
	"Physics",
	"Settings",
	"Customs"
}

local TabButtons = {}

for i, name in ipairs(TabNames) do
	local button = New("TextButton", {
		Parent = Top,
		Position = UDim2.fromOffset(235 + ((i - 1) * 130), 12),
		Size = UDim2.fromOffset(120, 48),
		BackgroundColor3 = DARK,
		BorderSizePixel = 0,
		Text = name,
		TextColor3 = MUTED,
		Font = Enum.Font.GothamSemibold,
		TextSize = 12,
		AutoButtonColor = false,
		ZIndex = 7
	})

	Corner(button, 12)

	TabButtons[name] = button

	button.MouseButton1Click:Connect(function()
		ShowPage(name)

		for tabName, tab in pairs(TabButtons) do
			tab.BackgroundColor3 = DARK
			tab.TextColor3 = MUTED
		end

		button.BackgroundColor3 = Color3.fromRGB(50, 15, 95)
		button.TextColor3 = TEXT
	end)
end

--==================================================
-- PAGE TITLE
--==================================================

local function Title(page, title, desc)
	New("TextLabel", {
		Parent = page,
		Position = UDim2.fromOffset(5, 0),
		Size = UDim2.new(1, -10, 0, 30),
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = TEXT,
		Font = Enum.Font.GothamBold,
		TextSize = 19,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3
	})

	New("TextLabel", {
		Parent = page,
		Position = UDim2.fromOffset(5, 32),
		Size = UDim2.new(1, -10, 0, 20),
		BackgroundTransparency = 1,
		Text = desc,
		TextColor3 = MUTED,
		Font = Enum.Font.Gotham,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3
	})
end

--==================================================
-- CARD
--==================================================

local function MakeCard(page, x, y, w, h)
	local card = New("Frame", {
		Parent = page,
		Position = UDim2.fromOffset(x, y),
		Size = UDim2.fromOffset(w, h),
		BackgroundColor3 = CARD,
		BorderSizePixel = 0,
		ZIndex = 3
	})

	Corner(card, 12)

	New("UIStroke", {
		Parent = card,
		Color = Color3.fromRGB(65, 25, 105),
		Transparency = .35
	})

	return card
end

--==================================================
-- TOGGLE
--==================================================

local function Toggle(parent, y, name, desc, key, callback)
	New("TextLabel", {
		Parent = parent,
		Position = UDim2.fromOffset(18, y),
		Size = UDim2.new(1, -100, 0, 20),
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = TEXT,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4
	})

	New("TextLabel", {
		Parent = parent,
		Position = UDim2.fromOffset(18, y + 20),
		Size = UDim2.new(1, -100, 0, 18),
		BackgroundTransparency = 1,
		Text = desc,
		TextColor3 = MUTED,
		Font = Enum.Font.Gotham,
		TextSize = 9,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4
	})

	local button = New("TextButton", {
		Parent = parent,
		Position = UDim2.new(1, -62, 0, y + 3),
		Size = UDim2.fromOffset(45, 26),
		BackgroundColor3 = C[key] and PURPLE or Color3.fromRGB(55, 50, 80),
		Text = "",
		AutoButtonColor = false,
		ZIndex = 5
	})

	Corner(button, 20)

	local dot = New("Frame", {
		Parent = button,
		Size = UDim2.fromOffset(20, 20),
		Position = UDim2.new(
			C[key] and 1 or 0,
			C[key] and -23 or 3,
			.5,
			-10
		),
		BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0,
		ZIndex = 6
	})

	Corner(dot, 20)

	button.MouseButton1Click:Connect(function()
		C[key] = not C[key]

		button.BackgroundColor3 =
			C[key] and PURPLE or Color3.fromRGB(55, 50, 80)

		dot.Position = UDim2.new(
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

--==================================================
-- SLIDER
--==================================================

local function Slider(parent, y, name, key, min, max, callback)
	New("TextLabel", {
		Parent = parent,
		Position = UDim2.fromOffset(18, y),
		Size = UDim2.fromOffset(160, 20),
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = TEXT,
		Font = Enum.Font.GothamMedium,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 4
	})

	local bar = New("Frame", {
		Parent = parent,
		Position = UDim2.new(0, 175, 0, y + 7),
		Size = UDim2.new(1, -245, 0, 6),
		BackgroundColor3 = Color3.fromRGB(40, 30, 65),
		BorderSizePixel = 0,
		ZIndex = 4
	})

	Corner(bar, 10)

	local fill = New("Frame", {
		Parent = bar,
		Size = UDim2.new(
			math.clamp((C[key] - min) / (max - min), 0, 1),
			0,
			1,
			0
		),
		BackgroundColor3 = PURPLE,
		BorderSizePixel = 0,
		ZIndex = 5
	})

	Corner(fill, 10)

	local value = New("TextLabel", {
		Parent = parent,
		Position = UDim2.new(1, -60, 0, y - 4),
		Size = UDim2.fromOffset(48, 25),
		BackgroundColor3 = DARK,
		Text = tostring(C[key]),
		TextColor3 = TEXT,
		Font = Enum.Font.Gotham,
		TextSize = 10,
		ZIndex = 5
	})

	Corner(value, 6)

	local dragging = false

	local function Update(x)
		local percent = math.clamp(
			(x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X,
			0,
			1
		)

		local number = min + ((max - min) * percent)

		C[key] = math.floor(number * 100) / 100

		fill.Size = UDim2.new(percent, 0, 1, 0)
		value.Text = tostring(C[key])

		if callback then
			callback(C[key])
		end
	end

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			Update(input.Position.X)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			Update(input.Position.X)
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

--==================================================
-- CHARACTER / PHYSICS
--==================================================

local function GetHumanoid()
	local character = LP.Character

	if not character then
		return nil
	end

	return character:FindFirstChildOfClass("Humanoid")
end

local function ApplySpeed()
	local humanoid = GetHumanoid()

	if humanoid then
		humanoid.WalkSpeed = C.Speed
	end
end

local function ApplyJump()
	local humanoid = GetHumanoid()

	if humanoid then
		humanoid.UseJumpPower = true
		humanoid.JumpPower = C.JumpBoost and C.JumpPower or 50
	end
end

local function ApplyGravity()
	workspace.Gravity = C.Gravity
end

local function ApplyFOV()
	local camera = workspace.CurrentCamera

	if camera then
		camera.FieldOfView = C.FOV
	end
end

LP.CharacterAdded:Connect(function()
	task.wait(.5)

	if C.Enabled then
		ApplySpeed()
		ApplyJump()
	end
end)

--==================================================
-- QB
--==================================================

Title(
	QB,
	"⚡ QB",
	"Quarterback controls and throwing settings."
)

local QBCard = MakeCard(QB, 0, 65, 615, 330)

Toggle(
	QBCard,
	18,
	"Aim Assist",
	"Assist with QB aiming.",
	"AimAssist"
)

Slider(
	QBCard,
	75,
	"Aim Strength",
	"AimStrength",
	0,
	1
)

Slider(
	QBCard,
	133,
	"Accuracy",
	"Accuracy",
	0,
	100
)

Slider(
	QBCard,
	191,
	"Throw Power",
	"ThrowPower",
	0,
	120
)

Toggle(
	QBCard,
	249,
	"Auto Target",
	"Automatically select a receiver.",
	"AutoTarget"
)

--==================================================
-- CATCHING
--==================================================

Title(
	Catching,
	"⚡ Catching",
	"Configure catching assistance and timing."
)

local CatchCard = MakeCard(Catching, 0, 65, 615, 330)

Toggle(
	CatchCard,
	18,
	"Auto Catch",
	"Automatically catch when in range.",
	"AutoCatch"
)

Slider(
	CatchCard,
	75,
	"Catch Radius",
	"CatchRadius",
	5,
	100
)

Slider(
	CatchCard,
	133,
	"Catch Delay",
	"CatchDelay",
	0,
	.5
)

Toggle(
	CatchCard,
	191,
	"High Priority (QB)",
	"Prioritize QB catches.",
	"HighPriority"
)

--==================================================
-- PHYSICS
--==================================================

Title(
	Physics,
	"⚙ Physics",
	"Movement and gameplay physics."
)

local PhysicsCard = MakeCard(Physics, 0, 65, 615, 370)

Slider(
	PhysicsCard,
	18,
	"Speed",
	"Speed",
	16,
	100,
	ApplySpeed
)

Toggle(
	PhysicsCard,
	76,
	"Jump Boost",
	"Increase your jump power.",
	"JumpBoost",
	ApplyJump
)

Slider(
	PhysicsCard,
	134,
	"Jump Power",
	"JumpPower",
	50,
	150,
	ApplyJump
)

Slider(
	PhysicsCard,
	192,
	"Gravity",
	"Gravity strength.",
	50,
	250,
	ApplyGravity
)

Slider(
	PhysicsCard,
	250,
	"FOV",
	"FOV",
	50,
	120,
	ApplyFOV
)

local ResetPhysics = New("TextButton", {
	Parent = PhysicsCard,
	Position = UDim2.fromOffset(18, 310),
	Size = UDim2.fromOffset(180, 38),
	BackgroundColor3 = DARK,
	BorderSizePixel = 0,
	Text = "RESET PHYSICS",
	TextColor3 = TEXT,
	Font = Enum.Font.GothamBold,
	TextSize = 11,
	ZIndex = 5
})

Corner(ResetPhysics, 8)

ResetPhysics.MouseButton1Click:Connect(function()
	C.Speed = 16
	C.JumpBoost = false
	C.JumpPower = 50
	C.Gravity = 196.2
	C.FOV = 70

	ApplySpeed()
	ApplyJump()
	ApplyGravity()
	ApplyFOV()
end)

--==================================================
-- SETTINGS
--==================================================

Title(
	Settings,
	"⚙ Settings",
	"General Thunder Hub settings."
)

local SettingsCard = MakeCard(Settings, 0, 65, 615, 330)

Toggle(
	SettingsCard,
	18,
	"System Enabled",
	"Enable the system.",
	"Enabled",
	function(value)
		if value then
			ApplySpeed()
			ApplyJump()
		else
			local humanoid = GetHumanoid()

			if humanoid then
				humanoid.WalkSpeed = 16
				humanoid.JumpPower = 50
			end
		end
	end
)

Toggle(
	SettingsCard,
	75,
	"FPS Boost",
	"Enable performance mode.",
	"FPS"
)

Toggle(
	SettingsCard,
	132,
	"Visuals",
	"Enable visual effects.",
	"Visuals"
)

local Kill = New("TextButton", {
	Parent = SettingsCard,
	Position = UDim2.fromOffset(18, 205),
	Size = UDim2.fromOffset(180, 42),
	BackgroundColor3 = Color3.fromRGB(80, 25, 45),
	BorderSizePixel = 0,
	Text = "KILL CLIENT",
	TextColor3 = TEXT,
	Font = Enum.Font.GothamBold,
	TextSize = 11,
	ZIndex = 5
})

Corner(Kill, 8)

Kill.MouseButton1Click:Connect(function()
	GUI:Destroy()
end)

--==================================================
-- CUSTOMS
--==================================================

Title(
	Customs,
	"☷ Customs",
	"Presets and custom configuration."
)

local CustomCard = MakeCard(Customs, 0, 65, 615, 330)

local Presets = {
	Legit = {
		AimStrength = .35,
		Accuracy = 85,
		ThrowPower = 85,
		CatchRadius = 35,
		CatchDelay = .15
	},

	Advanced = {
		AimStrength = .70,
		Accuracy = 95,
		ThrowPower = 100,
		CatchRadius = 60,
		CatchDelay = .10
	},

	Blatant = {
		AimStrength = 1,
		Accuracy = 100,
		ThrowPower = 120,
		CatchRadius = 100,
		CatchDelay = 0
	}
}

local function ApplyPreset(name)
	local preset = Presets[name]

	if not preset then
		return
	end

	for key, value in pairs(preset) do
		C[key] = value
	end

	C.Preset = name
end

for i, name in ipairs({"Legit", "Advanced", "Blatant"}) do
	local button = New("TextButton", {
		Parent = CustomCard,
		Position = UDim2.fromOffset(18 + ((i - 1) * 195), 20),
		Size = UDim2.fromOffset(175, 42),
		BackgroundColor3 = name == C.Preset and PURPLE or DARK,
		BorderSizePixel = 0,
		Text = name,
		TextColor3 = TEXT,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		ZIndex = 5
	})

	Corner(button, 8)

	button.MouseButton1Click:Connect(function()
		ApplyPreset(name)

		for _, child in ipairs(CustomCard:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = DARK
			end
		end

		button.BackgroundColor3 = PURPLE
	end)
end

Toggle(
	CustomCard,
	90,
	"Custom QB Model",
	"Use a custom QB model.",
	"CustomQB"
)

Toggle(
	CustomCard,
	147,
	"Custom Ball",
	"Use a custom football model.",
	"CustomBall"
)

Toggle(
	CustomCard,
	204,
	"Custom Animations",
	"Use custom animations.",
	"CustomAnimations"
)

--==================================================
-- DEFAULT TAB
--==================================================

ShowPage("QB")

TabButtons.QB.BackgroundColor3 = Color3.fromRGB(50, 15, 95)
TabButtons.QB.TextColor3 = TEXT

--==================================================
-- DRAGGING
--==================================================

local dragging = false
local dragStart
local startPosition

Top.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = Main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart

		Main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

--==================================================
-- RESIZE HANDLE
--==================================================

local Resize = New("TextButton", {
	Parent = Main,
	AnchorPoint = Vector2.new(1, 1),
	Position = UDim2.fromScale(1, 1),
	Size = UDim2.fromOffset(24, 24),
	BackgroundTransparency = 1,
	Text = "◢",
	TextColor3 = PURPLE,
	Font = Enum.Font.GothamBold,
	TextSize = 14,
	AutoButtonColor = false,
	ZIndex = 20
})

local resizing = false
local resizeStart
local sizeStart

Resize.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		resizing = true
		resizeStart = input.Position
		sizeStart = Main.AbsoluteSize
	end
end)

UIS.InputChanged:Connect(function(input)
	if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - resizeStart

		local width = math.clamp(
			sizeStart.X + delta.X,
			650,
			1250
		)

		local height = math.clamp(
			sizeStart.Y + delta.Y,
			400,
			800
		)

		Main.Size = UDim2.fromOffset(width, height)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		resizing = false
	end
end)

--==================================================
-- CTRL HIDE / SHOW
--==================================================

UIS.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.LeftControl then
		GUI.Enabled = not GUI.Enabled
	end
end)

--==================================================
-- INITIAL VALUES
--==================================================

task.defer(function()
	ApplySpeed()
	ApplyJump()
	ApplyGravity()
	ApplyFOV()
end)
