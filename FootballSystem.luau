--//==================================================
--// THUNDER HUB - FF3 EXECUTOR EDITION
--//==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--//==================================================
--// UI PARENT
--//==================================================

local function GetUIParent()
	if typeof(gethui) == "function" then
		local success, result = pcall(gethui)

		if success and result then
			return result
		end
	end

	local CoreGui = game:GetService("CoreGui")

	if CoreGui then
		return CoreGui
	end

	return LocalPlayer:WaitForChild("PlayerGui")
end

local UIParent = GetUIParent()

--//==================================================
--// REMOVE OLD VERSION
--//==================================================

pcall(function()
	local old = UIParent:FindFirstChild("ThunderHub")

	if old then
		old:Destroy()
	end
end)

pcall(function()
	local old = game:GetService("CoreGui"):FindFirstChild("ThunderHub")

	if old then
		old:Destroy()
	end
end)

--//==================================================
--// STATE
--//==================================================

local State = {
	-- QB
	AimAssist = false,
	AimStrength = 75,
	Accuracy = 90,
	ThrowPower = 100,
	AutoTarget = false,
	TargetDistance = 100,

	-- Catching
	AutoCatch = false,
	CatchRadius = 10,
	CatchDelay = 0,
	CatchWindow = 100,
	HighPriority = false,
	VisualCatch = true,

	-- Physics
	Speed = 16,
	JumpBoost = false,
	JumpPower = 50,
	Gravity = 196.2,
	FOV = 70,
	AirResistance = 0,
	BallVelocity = 100,

	-- Settings
	SystemEnabled = true,
	FPSBoost = false,
	Visuals = true,
	UIScale = 100,

	-- Customs
	CustomQB = false,
	CustomBall = false,
	CustomAnimations = false,

	Preset = "Legit"
}

local Connections = {}

--//==================================================
--// COLORS
--//==================================================

local Purple = Color3.fromRGB(145, 70, 255)
local PurpleLight = Color3.fromRGB(181, 119, 255)

local Background = Color3.fromRGB(9, 7, 14)
local Panel = Color3.fromRGB(16, 13, 23)
local Card = Color3.fromRGB(23, 19, 32)
local CardHover = Color3.fromRGB(32, 26, 44)

local White = Color3.fromRGB(245, 243, 250)
local Gray = Color3.fromRGB(153, 148, 165)

--//==================================================
--// HELPERS
--//==================================================

local function Create(class, properties)
	local object = Instance.new(class)

	for property, value in pairs(properties or {}) do
		object[property] = value
	end

	return object
end

local function Corner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius or 8)
	corner.Parent = parent
	return corner
end

local function Stroke(parent, color, transparency, thickness)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Purple
	stroke.Transparency = transparency or 0
	stroke.Thickness = thickness or 1
	stroke.Parent = parent
	return stroke
end

local function Tween(object, properties, duration)
	TweenService:Create(
		object,
		TweenInfo.new(
			duration or 0.15,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		),
		properties
	):Play()
end

local function GetCharacter()
	return LocalPlayer.Character
end

local function GetHumanoid()
	local character = GetCharacter()

	if not character then
		return nil
	end

	return character:FindFirstChildOfClass("Humanoid")
end

--//==================================================
--// PHYSICS
--//==================================================

local function ApplyPhysics()
	if not State.SystemEnabled then
		return
	end

	local humanoid = GetHumanoid()

	if humanoid then
		pcall(function()
			humanoid.WalkSpeed = State.Speed
			humanoid.JumpPower = State.JumpPower
		end)
	end

	pcall(function()
		workspace.Gravity = State.Gravity
	end)

	local camera = workspace.CurrentCamera

	if camera then
		pcall(function()
			camera.FieldOfView = State.FOV
		end)
	end
end

--//==================================================
--// SCREEN GUI
--//==================================================

local ScreenGui = Create("ScreenGui", {
	Name = "ThunderHub",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Global,
	DisplayOrder = 999999,
	Parent = UIParent
})

--//==================================================
--// MAIN
--//==================================================

local Main = Create("Frame", {
	Name = "Main",
	Parent = ScreenGui,
	BackgroundColor3 = Background,
	BorderSizePixel = 0,
	Size = UDim2.fromOffset(850, 560),
	Position = UDim2.new(0.5, -425, 0.5, -280),
	ClipsDescendants = true,
	ZIndex = 10
})

Corner(Main, 12)
Stroke(Main, Color3.fromRGB(67, 47, 90), 0.25, 1)

local UIScale = Create("UIScale", {
	Parent = Main,
	Scale = 1
})

--//==================================================
--// LIGHTNING
--//==================================================

local LightningContainer = Create("Frame", {
	Parent = Main,
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 1),
	ZIndex = 11
})

local function Lightning(position, rotation, size)
	local bolt = Create("TextLabel", {
		Parent = LightningContainer,
		BackgroundTransparency = 1,
		Text = "ϟ",
		TextColor3 = Purple,
		TextTransparency = 0.86,
		Font = Enum.Font.GothamBlack,
		TextSize = size,
		Rotation = rotation,
		Position = position,
		Size = UDim2.fromOffset(120, 150),
		ZIndex = 11
	})

	return bolt
end

Lightning(UDim2.new(0.70, 0, -0.05, 0), 12, 140)
Lightning(UDim2.new(0.87, 0, 0.42, 0), -15, 110)
Lightning(UDim2.new(0.04, 0, 0.62, 0), 12, 90)
Lightning(UDim2.new(0.43, 0, 0.73, 0), -10, 75)

--//==================================================
--// TOP BAR
--//==================================================

local TopBar = Create("Frame", {
	Parent = Main,
	BackgroundColor3 = Panel,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 68),
	ZIndex = 20
})

local Logo = Create("TextLabel", {
	Parent = TopBar,
	BackgroundTransparency = 1,
	Text = "⚡ THUNDER HUB",
	TextColor3 = White,
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Left,
	Position = UDim2.fromOffset(22, 9),
	Size = UDim2.fromOffset(250, 26),
	ZIndex = 21
})

local GameName = Create("TextLabel", {
	Parent = TopBar,
	BackgroundTransparency = 1,
	Text = "FF3",
	TextColor3 = PurpleLight,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left,
	Position = UDim2.fromOffset(24, 36),
	Size = UDim2.fromOffset(100, 20),
	ZIndex = 21
})

local Status = Create("TextLabel", {
	Parent = TopBar,
	BackgroundTransparency = 1,
	Text = "● SYSTEM ONLINE",
	TextColor3 = Color3.fromRGB(130, 255, 180),
	Font = Enum.Font.GothamMedium,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Right,
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -20, 0, 24),
	Size = UDim2.fromOffset(170, 20),
	ZIndex = 21
})

--//==================================================
--// SIDEBAR
--//==================================================

local Sidebar = Create("Frame", {
	Parent = Main,
	BackgroundColor3 = Panel,
	BorderSizePixel = 0,
	Position = UDim2.fromOffset(0, 68),
	Size = UDim2.new(0, 175, 1, -68),
	ZIndex = 20
})

local SidebarPadding = Create("UIPadding", {
	Parent = Sidebar,
	PaddingTop = UDim.new(0, 16),
	PaddingLeft = UDim.new(0, 12),
	PaddingRight = UDim.new(0, 12)
})

local SidebarLayout = Create("UIListLayout", {
	Parent = Sidebar,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 7)
})

local TabButtons = {}
local Pages = {}

local function CreateTab(name, icon, order)
	local button = Create("TextButton", {
		Parent = Sidebar,
		BackgroundColor3 = Card,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 43),
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = order,
		ZIndex = 21
	})

	Corner(button, 7)

	local indicator = Create("Frame", {
		Parent = button,
		BackgroundColor3 = Purple,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.5, -10),
		Size = UDim2.fromOffset(3, 20),
		Visible = false,
		ZIndex = 22
	})

	Corner(indicator, 2)

	local text = Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = icon .. "  " .. name,
		TextColor3 = Gray,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(18, 0),
		Size = UDim2.new(1, -20, 1, 0),
		ZIndex = 22
	})

	TabButtons[name] = {
		Button = button,
		Indicator = indicator,
		Text = text
	}

	return button
end

CreateTab("QB", "◆", 1)
CreateTab("Catching", "○", 2)
CreateTab("Physics", "◇", 3)
CreateTab("Settings", "⚙", 4)
CreateTab("Customs", "✦", 5)

--//==================================================
--// CONTENT
--//==================================================

local Content = Create("Frame", {
	Parent = Main,
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(175, 68),
	Size = UDim2.new(1, -175, 1, -68),
	ZIndex = 20
})

--//==================================================
--// PAGE
--//==================================================

local function CreatePage(name, title, subtitle)
	local page = Create("ScrollingFrame", {
		Name = name .. "Page",
		Parent = Content,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Purple,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Visible = false,
		ZIndex = 21
	})

	local padding = Create("UIPadding", {
		Parent = page,
		PaddingTop = UDim.new(0, 18),
		PaddingLeft = UDim.new(0, 18),
		PaddingRight = UDim.new(0, 18),
		PaddingBottom = UDim.new(0, 25)
	})

	local layout = Create("UIListLayout", {
		Parent = page,
		FillDirection = Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 12)
	})

	local header = Create("Frame", {
		Parent = page,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 52),
		LayoutOrder = 1
	})

	Create("TextLabel", {
		Parent = header,
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = White,
		Font = Enum.Font.GothamBold,
		TextSize = 21,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(0, 0),
		Size = UDim2.new(1, 0, 0, 27)
	})

	Create("TextLabel", {
		Parent = header,
		BackgroundTransparency = 1,
		Text = subtitle,
		TextColor3 = Gray,
		Font = Enum.Font.Gotham,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(0, 29),
		Size = UDim2.new(1, 0, 0, 18)
	})

	Pages[name] = page

	return page
end

local function CreateSection(parent, title, description, order)
	local section = Create("Frame", {
		Parent = parent,
		BackgroundColor3 = Card,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 52),
		LayoutOrder = order or 2,
		ZIndex = 22
	})

	Corner(section, 8)
	Stroke(section, Color3.fromRGB(55, 43, 70), 0.35, 1)

	Create("TextLabel", {
		Parent = section,
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = White,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(15, 7),
		Size = UDim2.new(1, -30, 0, 18)
	})

	Create("TextLabel", {
		Parent = section,
		BackgroundTransparency = 1,
		Text = description or "",
		TextColor3 = Gray,
		Font = Enum.Font.Gotham,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(15, 27),
		Size = UDim2.new(1, -30, 0, 16)
	})

	return section
end

--//==================================================
--// ROW
--//==================================================

local function CreateRow(parent, height, order)
	local row = Create("Frame", {
		Parent = parent,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, height or 78),
		LayoutOrder = order,
		ZIndex = 22
	})

	local left = Create("Frame", {
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(0.5, -6, 1, 0),
		ZIndex = 23
	})

	local right = Create("Frame", {
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 6, 0, 0),
		Size = UDim2.new(0.5, -6, 1, 0),
		ZIndex = 23
	})

	return left, right
end

--//==================================================
--// TOGGLE
--//==================================================

local function CreateToggle(parent, title, description, key)
	local button = Create("TextButton", {
		Parent = parent,
		BackgroundColor3 = Card,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		AutoButtonColor = false,
		ZIndex = 24
	})

	Corner(button, 8)
	Stroke(button, Color3.fromRGB(55, 43, 70), 0.35, 1)

	Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = White,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -75, 0, 18),
		ZIndex = 25
	})

	Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = description or "",
		TextColor3 = Gray,
		Font = Enum.Font.Gotham,
		TextSize = 9,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(14, 34),
		Size = UDim2.new(1, -75, 0, 15),
		ZIndex = 25
	})

	local toggle = Create("Frame", {
		Parent = button,
		BackgroundColor3 = Color3.fromRGB(55, 50, 65),
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -13, 0.5, 0),
		Size = UDim2.fromOffset(38, 20),
		ZIndex = 25
	})

	Corner(toggle, 10)

	local knob = Create("Frame", {
		Parent = toggle,
		BackgroundColor3 = Color3.fromRGB(175, 170, 185),
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(2, 2),
		Size = UDim2.fromOffset(16, 16),
		ZIndex = 26
	})

	Corner(knob, 10)

	local function Update()
		local enabled = State[key]

		if enabled then
			Tween(toggle, {
				BackgroundColor3 = Purple
			}, 0.12)

			Tween(knob, {
				BackgroundColor3 = White,
				Position = UDim2.new(1, -18, 0, 2)
			}, 0.12)
		else
			Tween(toggle, {
				BackgroundColor3 = Color3.fromRGB(55, 50, 65)
			}, 0.12)

			Tween(knob, {
				BackgroundColor3 = Color3.fromRGB(175, 170, 185),
				Position = UDim2.fromOffset(2, 2)
			}, 0.12)
		end
	end

	button.MouseEnter:Connect(function()
		Tween(button, {
			BackgroundColor3 = CardHover
		}, 0.1)
	end)

	button.MouseLeave:Connect(function()
		Tween(button, {
			BackgroundColor3 = Card
		}, 0.1)
	end)

	button.MouseButton1Click:Connect(function()
		State[key] = not State[key]

		Update()

		if key == "SystemEnabled" then
			ApplyPhysics()
		end
	end)

	Update()

	return button
end

--//==================================================
--// SLIDER
--//==================================================

local function CreateSlider(parent, title, description, key, minimum, maximum, suffix)
	local card = Create("Frame", {
		Parent = parent,
		BackgroundColor3 = Card,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 24
	})

	Corner(card, 8)
	Stroke(card, Color3.fromRGB(55, 43, 70), 0.35, 1)

	Create("TextLabel", {
		Parent = card,
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = White,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(14, 9),
		Size = UDim2.new(1, -80, 0, 18),
		ZIndex = 25
	})

	local valueLabel = Create("TextLabel", {
		Parent = card,
		BackgroundTransparency = 1,
		TextColor3 = PurpleLight,
		Font = Enum.Font.GothamBold,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(1, -65, 0, 9),
		Size = UDim2.fromOffset(50, 18),
		ZIndex = 25
	})

	Create("TextLabel", {
		Parent = card,
		BackgroundTransparency = 1,
		Text = description or "",
		TextColor3 = Gray,
		Font = Enum.Font.Gotham,
		TextSize = 9,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(14, 28),
		Size = UDim2.new(1, -28, 0, 14),
		ZIndex = 25
	})

	local bar = Create("Frame", {
		Parent = card,
		BackgroundColor3 = Color3.fromRGB(50, 44, 60),
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(14, 52),
		Size = UDim2.new(1, -28, 0, 6),
		ZIndex = 25
	})

	Corner(bar, 5)

	local fill = Create("Frame", {
		Parent = bar,
		BackgroundColor3 = Purple,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 0, 1, 0),
		ZIndex = 26
	})

	Corner(fill, 5)

	local dragging = false

	local function UpdateVisual()
		local value = State[key]

		local percent = math.clamp(
			(value - minimum) / (maximum - minimum),
			0,
			1
		)

		fill.Size = UDim2.new(percent, 0, 1, 0)

		valueLabel.Text =
			tostring(math.floor(value)) ..
			(suffix or "")
	end

	local function SetFromMouse(mouseX)
		local width = bar.AbsoluteSize.X

		if width <= 0 then
			return
		end

		local percent = math.clamp(
			(mouseX - bar.AbsolutePosition.X) / width,
			0,
			1
		)

		State[key] = math.floor(
			minimum + ((maximum - minimum) * percent)
		)

		UpdateVisual()

		if key == "Speed"
			or key == "JumpPower"
			or key == "Gravity"
			or key == "FOV" then

			ApplyPhysics()
		end

		if key == "UIScale" then
			UIScale.Scale = math.clamp(
				State.UIScale / 100,
				0.75,
				1.25
			)
		end
	end

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			SetFromMouse(input.Position.X)
		end
	end)

	local changed = UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			SetFromMouse(input.Position.X)
		end
	end)

	table.insert(Connections, changed)

	local ended = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	table.insert(Connections, ended)

	UpdateVisual()

	return card
end

--//==================================================
--// ACTION
--//==================================================

local function CreateAction(parent, title, description, callback)
	local button = Create("TextButton", {
		Parent = parent,
		BackgroundColor3 = Card,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Text = "",
		AutoButtonColor = false,
		ZIndex = 24
	})

	Corner(button, 8)
	Stroke(button, Color3.fromRGB(55, 43, 70), 0.35, 1)

	Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = White,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(14, 12),
		Size = UDim2.new(1, -28, 0, 18),
		ZIndex = 25
	})

	Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = description or "",
		TextColor3 = Gray,
		Font = Enum.Font.Gotham,
		TextSize = 9,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(14, 34),
		Size = UDim2.new(1, -28, 0, 16),
		ZIndex = 25
	})

	button.MouseEnter:Connect(function()
		Tween(button, {
			BackgroundColor3 = CardHover
		}, 0.1)
	end)

	button.MouseLeave:Connect(function()
		Tween(button, {
			BackgroundColor3 = Card
		}, 0.1)
	end)

	button.MouseButton1Click:Connect(callback)

	return button
end

--//==================================================
--// QB
--//==================================================

local QB = CreatePage(
	"QB",
	"Quarterback",
	"Throwing and targeting controls"
)

CreateSection(
	QB,
	"QB Controls",
	"Adjust your local quarterback configuration",
	2
)

local a, b = CreateRow(QB, 78, 3)
CreateToggle(a, "Aim Assist", "Local aim configuration", "AimAssist")
CreateSlider(b, "Aim Strength", "Targeting strength", "AimStrength", 0, 100, "%")

local c, d = CreateRow(QB, 78, 4)
CreateSlider(c, "Accuracy", "Throw accuracy", "Accuracy", 0, 100, "%")
CreateSlider(d, "Throw Power", "Throw power", "ThrowPower", 0, 100, "%")

local e, f = CreateRow(QB, 78, 5)
CreateToggle(e, "Auto Target", "Automatically select target", "AutoTarget")
CreateSlider(f, "Target Distance", "Maximum target distance", "TargetDistance", 10, 300, "")

--//==================================================
--// CATCHING
--//==================================================

local Catching = CreatePage(
	"Catching",
	"Catching",
	"Configure local catching preferences"
)

CreateSection(
	Catching,
	"Catch Controls",
	"Fine tune your catching setup",
	2
)

local ca, cb = CreateRow(Catching, 78, 3)
CreateToggle(ca, "Auto Catch", "Local catch configuration", "AutoCatch")
CreateSlider(cb, "Catch Radius", "Detection radius", "CatchRadius", 1, 50, "")

local cc, cd = CreateRow(Catching, 78, 4)
CreateSlider(cc, "Catch Delay", "Reaction delay", "CatchDelay", 0, 500, "ms")
CreateSlider(cd, "Catch Window", "Catch timing window", "CatchWindow", 0, 100, "%")

local ce, cf = CreateRow(Catching, 78, 5)
CreateToggle(ce, "High Priority", "Prioritize catch input", "HighPriority")
CreateToggle(cf, "Visual Catch", "Show catch visuals", "VisualCatch")

--//==================================================
--// PHYSICS
--//==================================================

local Physics = CreatePage(
	"Physics",
	"Physics",
	"Local movement and camera settings"
)

CreateSection(
	Physics,
	"Movement",
	"These settings apply directly to your local character",
	2
)

local pa, pb = CreateRow(Physics, 78, 3)
CreateSlider(pa, "Speed", "Humanoid WalkSpeed", "Speed", 1, 100, "")
CreateToggle(pb, "Jump Boost", "Enable jump configuration", "JumpBoost")

local pc, pd = CreateRow(Physics, 78, 4)
CreateSlider(pc, "Jump Power", "Humanoid JumpPower", "JumpPower", 0, 150, "")
CreateSlider(pd, "Gravity", "Workspace gravity", "Gravity", 0, 300, "")

local pe, pf = CreateRow(Physics, 78, 5)
CreateSlider(pe, "FOV", "Camera FieldOfView", "FOV", 40, 120, "")
CreateSlider(pf, "Air Resistance", "Ball physics setting", "AirResistance", 0, 100, "%")

local pg, ph = CreateRow(Physics, 78, 6)
CreateSlider(pg, "Ball Velocity", "Ball velocity setting", "BallVelocity", 0, 200, "%")

CreateAction(
	ph,
	"Apply Physics",
	"Apply current local values",
	function()
		ApplyPhysics()
	end
)

--//==================================================
--// SETTINGS
--//==================================================

local Settings = CreatePage(
	"Settings",
	"Settings",
	"Thunder Hub interface and system options"
)

CreateSection(
	Settings,
	"System",
	"General menu configuration",
	2
)

local sa, sb = CreateRow(Settings, 78, 3)

CreateToggle(
	sa,
	"System Enabled",
	"Enable Thunder Hub controls",
	"SystemEnabled"
)

CreateToggle(
	sb,
	"FPS Boost",
	"Reduce selected visual effects",
	"FPSBoost"
)

local sc, sd = CreateRow(Settings, 78, 4)

CreateToggle(
	sc,
	"Visuals",
	"Show Thunder Hub visual effects",
	"Visuals"
)

CreateSlider(
	sd,
	"UI Scale",
	"Change menu size",
	"UIScale",
	75,
	125,
	"%"
)

local Controls = Create("Frame", {
	Parent = Settings,
	BackgroundColor3 = Card,
	BorderSizePixel = 0,
	Size = UDim2.new(1, 0, 0, 105),
	LayoutOrder = 5,
	ZIndex = 24
})

Corner(Controls, 8)
Stroke(Controls, Color3.fromRGB(55, 43, 70), 0.35, 1)

Create("TextLabel", {
	Parent = Controls,
	BackgroundTransparency = 1,
	Text = "Controls",
	TextColor3 = White,
	Font = Enum.Font.GothamBold,
	TextSize = 13,
	TextXAlignment = Enum.TextXAlignment.Left,
	Position = UDim2.fromOffset(15, 10),
	Size = UDim2.new(1, -30, 0, 20)
})

Create("TextLabel", {
	Parent = Controls,
	BackgroundTransparency = 1,
	Text = "CTRL  —  Hide / Show Hub\nDrag top bar  —  Move Hub\nBottom-right corner  —  Resize Hub\nMouse wheel  —  Scroll pages",
	TextColor3 = Gray,
	Font = Enum.Font.Gotham,
	TextSize = 10,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	Position = UDim2.fromOffset(15, 35),
	Size = UDim2.new(1, -30, 0, 65)
})

local sx, sy = CreateRow(Settings, 65, 6)

CreateAction(
	sx,
	"Reset Local Physics",
	"Restore normal Roblox values",
	function()
		State.Speed = 16
		State.JumpPower = 50
		State.Gravity = 196.2
		State.FOV = 70

		ApplyPhysics()

		Status.Text = "● PHYSICS RESET"
		Status.TextColor3 = PurpleLight
	end
)

CreateAction(
	sy,
	"Kill Client",
	"Unload Thunder Hub completely",
	function()
		for _, connection in ipairs(Connections) do
			pcall(function()
				connection:Disconnect()
			end)
		end

		ScreenGui:Destroy()
	end
)

--//==================================================
--// CUSTOMS
--//==================================================

local Customs = CreatePage(
	"Customs",
	"Customs",
	"Presets and custom configuration"
)

CreateSection(
	Customs,
	"Presets",
	"Choose a starting configuration",
	2
)

local PresetRow = Create("Frame", {
	Parent = Customs,
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 75),
	LayoutOrder = 3
})

local PresetLayout = Create("UIListLayout", {
	Parent = PresetRow,
	FillDirection = Enum.FillDirection.Horizontal,
	Padding = UDim.new(0, 8)
})

local function CreatePreset(name, description, values)
	local button = Create("TextButton", {
		Parent = PresetRow,
		BackgroundColor3 = Card,
		BorderSizePixel = 0,
		Size = UDim2.new(0.333, -6, 1, 0),
		Text = "",
		AutoButtonColor = false,
		ZIndex = 24
	})

	Corner(button, 8)
	Stroke(button, Color3.fromRGB(55, 43, 70), 0.35, 1)

	Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = name,
		TextColor3 = White,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(12, 10),
		Size = UDim2.new(1, -24, 0, 18)
	})

	Create("TextLabel", {
		Parent = button,
		BackgroundTransparency = 1,
		Text = description,
		TextColor3 = Gray,
		Font = Enum.Font.Gotham,
		TextSize = 9,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(12, 34),
		Size = UDim2.new(1, -24, 0, 25)
	})

	button.MouseEnter:Connect(function()
		Tween(button, {
			BackgroundColor3 = CardHover
		}, 0.1)
	end)

	button.MouseLeave:Connect(function()
		Tween(button, {
			BackgroundColor3 = Card
		}, 0.1)
	end)

	button.MouseButton1Click:Connect(function()
		State.Preset = name

		for key, value in pairs(values) do
			State[key] = value
		end

		ApplyPhysics()

		Status.Text = "● PRESET: " .. string.upper(name)
		Status.TextColor3 = PurpleLight
	end)
end

CreatePreset(
	"Legit",
	"Balanced settings",
	{
		AimStrength = 55,
		Accuracy = 90,
		ThrowPower = 95,
		CatchRadius = 8,
		Speed = 16,
		JumpPower = 50,
		Gravity = 196.2,
		FOV = 70
	}
)

CreatePreset(
	"Advanced",
	"Stronger configuration",
	{
		AimStrength = 75,
		Accuracy = 95,
		ThrowPower = 100,
		CatchRadius = 12,
		Speed = 18,
		JumpPower = 55,
		Gravity = 180,
		FOV = 75
	}
)

CreatePreset(
	"Blatant",
	"Maximum local values",
	{
		AimStrength = 100,
		Accuracy = 100,
		ThrowPower = 100,
		CatchRadius = 25,
		Speed = 30,
		JumpPower = 100,
		Gravity = 120,
		FOV = 90
	}
)

CreateSection(
	Customs,
	"Custom Controls",
	"Toggle individual custom systems",
	4
)

local csa, csb = CreateRow(Customs, 78, 5)

CreateToggle(
	csa,
	"Custom QB",
	"Use custom quarterback values",
	"CustomQB"
)

CreateToggle(
	csb,
	"Custom Ball",
	"Use custom ball values",
	"CustomBall"
)

local csc, csd = CreateRow(Customs, 78, 6)

CreateToggle(
	csc,
	"Custom Animations",
	"Use custom animation settings",
	"CustomAnimations"
)

CreateAction(
	csd,
	"Reset Customs",
	"Restore custom configuration",
	function()
		State.CustomQB = false
		State.CustomBall = false
		State.CustomAnimations = false
		State.Preset = "Legit"

		Status.Text = "● CUSTOMS RESET"
		Status.TextColor3 = PurpleLight
	end
)

--//==================================================
--// PAGE SWITCHING
--//==================================================

local function ShowPage(name)
	for pageName, page in pairs(Pages) do
		page.Visible = pageName == name

		if pageName == name then
			page.CanvasPosition = Vector2.new(0, 0)
		end
	end

	for tabName, data in pairs(TabButtons) do
		local active = tabName == name

		data.Indicator.Visible = active
		data.Text.TextColor3 = active and White or Gray

		Tween(
			data.Button,
			{
				BackgroundColor3 =
					active
					and Color3.fromRGB(35, 27, 48)
					or Card
			},
			0.12
		)
	end
end

for name, data in pairs(TabButtons) do
	local connection = data.Button.MouseButton1Click:Connect(function()
		ShowPage(name)
	end)

	table.insert(Connections, connection)
end

-- Start on QB
ShowPage("QB")

--//==================================================
--// DRAGGING
--//==================================================

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = Main.Position
	end
end)

local dragChanged = UserInputService.InputChanged:Connect(function(input)
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

table.insert(Connections, dragChanged)

local dragEnded = UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

table.insert(Connections, dragEnded)

--//==================================================
--// RESIZE
--//==================================================

local Resize = Create("TextButton", {
	Parent = Main,
	BackgroundColor3 = Purple,
	BackgroundTransparency = 0.1,
	BorderSizePixel = 0,
	AnchorPoint = Vector2.new(1, 1),
	Position = UDim2.new(1, 0, 1, 0),
	Size = UDim2.fromOffset(20, 20),
	Text = "↘",
	TextColor3 = White,
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	AutoButtonColor = false,
	ZIndex = 50
})

Corner(Resize, 5)

local resizing = false
local resizeStart
local originalSize

Resize.MouseButton1Down:Connect(function()
	resizing = true
	resizeStart = UserInputService:GetMouseLocation()
	originalSize = Main.Size
end)

local resizeChanged = UserInputService.InputChanged:Connect(function(input)
	if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mouse = UserInputService:GetMouseLocation()

		local deltaX = mouse.X - resizeStart.X
		local deltaY = mouse.Y - resizeStart.Y

		local width = math.clamp(
			originalSize.X.Offset + deltaX,
			650,
			1100
		)

		local height = math.clamp(
			originalSize.Y.Offset + deltaY,
			450,
			750
		)

		Main.Size = UDim2.fromOffset(width, height)
	end
end)

table.insert(Connections, resizeChanged)

local resizeEnded = UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		resizing = false
	end
end)

table.insert(Connections, resizeEnded)

--//==================================================
--// CTRL TOGGLE
--//==================================================

local hidden = false

local ctrlConnection = UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.LeftControl
		or input.KeyCode == Enum.KeyCode.RightControl then

		hidden = not hidden
		Main.Visible = not hidden
	end
end)

table.insert(Connections, ctrlConnection)

--//==================================================
--// FPS BOOST
--//==================================================

local function ApplyFPSBoost()
	if not State.FPSBoost then
		return
	end

	for _, object in ipairs(workspace:GetDescendants()) do
		pcall(function()
			if object:IsA("ParticleEmitter")
				or object:IsA("Trail")
				or object:IsA("Beam") then

				object.Enabled = false
			end
		end)
	end
end

--//==================================================
--// CHARACTER RESPAWN
--//==================================================

local characterConnection = LocalPlayer.CharacterAdded:Connect(function()
	task.wait(0.5)

	ApplyPhysics()
	ApplyFPSBoost()
end)

table.insert(Connections, characterConnection)

--//==================================================
--// LIGHTNING ANIMATION
--//==================================================

task.spawn(function()
	while ScreenGui.Parent do
		task.wait(2)

		for _, object in ipairs(LightningContainer:GetChildren()) do
			if object:IsA("TextLabel") then
				if State.Visuals then
					Tween(
						object,
						{
							TextTransparency = math.random(80, 93) / 100
						},
						0.35
					)
				else
					Tween(
						object,
						{
							TextTransparency = 1
						},
						0.2
					)
				end
			end
		end
	end
end)

--//==================================================
--// INITIALIZE
--//==================================================

pcall(function()
	UIScale.Scale = State.UIScale / 100
end)

ApplyPhysics()
ApplyFPSBoost()

print("[Thunder Hub] Loaded successfully.")
