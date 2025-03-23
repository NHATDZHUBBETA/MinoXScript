-- Roblox UI Hub with Advanced Visual Effects
-- This script creates a sleek UI hub with animations, gradients, and smooth transitions

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local config = {
    hubName = "STELLAR HUB",
    mainColor = Color3.fromRGB(45, 52, 120),
    accentColor = Color3.fromRGB(107, 126, 255),
    backgroundColor = Color3.fromRGB(25, 25, 35),
    textColor = Color3.fromRGB(255, 255, 255),
    font = Enum.Font.GothamBold,
    cornerRadius = UDim.new(0, 10),
    buttonCornerRadius = UDim.new(0, 6),
    tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    categories = {"COMBAT", "VISUALS", "MOVEMENT", "MISC", "SETTINGS"}
}

-- Create UI
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove existing UI with same name if it exists
if playerGui:FindFirstChild("Wbmx Hub") then
    playerGui:FindFirstChild("Wbmx Hub"):Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Wbmx Hub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Create main frame with drop shadow
local shadowFrame = Instance.new("Frame")
shadowFrame.Name = "ShadowFrame"
shadowFrame.Size = UDim2.new(0, 650, 0, 400)
shadowFrame.Position = UDim2.new(0.5, -325, 0.5, -200)
shadowFrame.BackgroundTransparency = 1
shadowFrame.Parent = screenGui

-- Create shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0, -15, 0, -15)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://" -- Shadow asset
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(24, 24, 276, 276)
shadow.Parent = shadowFrame

-- Create main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = config.backgroundColor
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Parent = shadowFrame

-- Add corner radius to main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = config.cornerRadius
mainCorner.Parent = mainFrame

-- Create gradient effect
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, config.backgroundColor),
    ColorSequenceKeypoint.new(1, config.backgroundColor:Lerp(config.accentColor, 0.1))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

-- Create top bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.BackgroundColor3 = config.mainColor
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

-- Add corner radius to top bar
local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = config.cornerRadius
topBarCorner.Parent = topBar

-- Create top bar bottom cover (to make flat bottom edge)
local topBarCover = Instance.new("Frame")
topBarCover.Name = "TopBarCover"
topBarCover.Size = UDim2.new(1, 0, 0, 10)
topBarCover.Position = UDim2.new(0, 0, 1, -10)
topBarCover.BackgroundColor3 = config.mainColor
topBarCover.BorderSizePixel = 0
topBarCover.Parent = topBar

-- Create title
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 200, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = config.hubName
titleLabel.TextColor3 = config.textColor
titleLabel.TextSize = 22
titleLabel.Font = config.font
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

-- Create close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = config.textColor
closeButton.TextSize = 18
closeButton.Font = config.font
closeButton.Parent = topBar

-- Add corner radius to close button
local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 6)
closeButtonCorner.Parent = closeButton

-- Create minimize button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -80, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 75)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "-"
minimizeButton.TextColor3 = config.textColor
minimizeButton.TextSize = 24
minimizeButton.Font = config.font
minimizeButton.Parent = topBar

-- Add corner radius to minimize button
local minimizeButtonCorner = Instance.new("UICorner")
minimizeButtonCorner.CornerRadius = UDim.new(0, 6)
minimizeButtonCorner.Parent = minimizeButton

-- Create categories frame
local categoriesFrame = Instance.new("Frame")
categoriesFrame.Name = "CategoriesFrame"
categoriesFrame.Size = UDim2.new(0, 130, 1, -40)
categoriesFrame.Position = UDim2.new(0, 0, 0, 40)
categoriesFrame.BackgroundColor3 = config.mainColor:Lerp(Color3.new(0, 0, 0), 0.3)
categoriesFrame.BorderSizePixel = 0
categoriesFrame.Parent = mainFrame

-- Create content frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -140, 1, -50)
contentFrame.Position = UDim2.new(0, 140, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.ClipsDescendants = true
contentFrame.Parent = mainFrame

-- Create category buttons
local categoryButtons = {}
local categoryContents = {}
local selectedCategory = nil

for i, category in ipairs(config.categories) do
    -- Create category button
    local categoryButton = Instance.new("TextButton")
    categoryButton.Name = category .. "Button"
    categoryButton.Size = UDim2.new(1, -20, 0, 40)
    categoryButton.Position = UDim2.new(0, 10, 0, 10 + (i-1) * 50)
    categoryButton.BackgroundColor3 = config.mainColor
    categoryButton.BorderSizePixel = 0
    categoryButton.Text = category
    categoryButton.TextColor3 = config.textColor
    categoryButton.TextSize = 14
    categoryButton.Font = config.font
    categoryButton.Parent = categoriesFrame
    
    -- Add corner radius to category button
    local categoryButtonCorner = Instance.new("UICorner")
    categoryButtonCorner.CornerRadius = config.buttonCornerRadius
    categoryButtonCorner.Parent = categoryButton
    
    -- Create indicator
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 4, 0.7, 0)
    indicator.Position = UDim2.new(0, 0, 0.15, 0)
    indicator.BackgroundColor3 = config.accentColor
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.Parent = categoryButton
    
    -- Add corner radius to indicator
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = indicator
    
    -- Create content frame for this category
    local categoryContent = Instance.new("ScrollingFrame")
    categoryContent.Name = category .. "Content"
    categoryContent.Size = UDim2.new(1, 0, 1, 0)
    categoryContent.BackgroundTransparency = 1
    categoryContent.BorderSizePixel = 0
    categoryContent.ScrollBarThickness = 4
    categoryContent.ScrollBarImageColor3 = config.accentColor
    categoryContent.Visible = false
    categoryContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    categoryContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    categoryContent.Parent = contentFrame
    
    -- Add some sample content
    for j = 1, 5 do
        local featureFrame = Instance.new("Frame")
        featureFrame.Name = "FeatureFrame" .. j
        featureFrame.Size = UDim2.new(1, -20, 0, 45)
        featureFrame.Position = UDim2.new(0, 10, 0, (j-1) * 55 + 10)
        featureFrame.BackgroundColor3 = config.backgroundColor:Lerp(config.mainColor, 0.1)
        featureFrame.BorderSizePixel = 0
        featureFrame.Parent = categoryContent
        
        -- Add corner radius to feature frame
        local featureFrameCorner = Instance.new("UICorner")
        featureFrameCorner.CornerRadius = config.buttonCornerRadius
        featureFrameCorner.Parent = featureFrame
        
        -- Create feature name
        local featureName = Instance.new("TextLabel")
        featureName.Name = "FeatureName"
        featureName.Size = UDim2.new(0.6, 0, 1, 0)
        featureName.Position = UDim2.new(0, 15, 0, 0)
        featureName.BackgroundTransparency = 1
        featureName.Text = category .. " Feature " .. j
        featureName.TextColor3 = config.textColor
        featureName.TextSize = 14
        featureName.Font = Enum.Font.Gotham
        featureName.TextXAlignment = Enum.TextXAlignment.Left
        featureName.Parent = featureFrame
        
        -- Create toggle button
        local toggleButton = Instance.new("Frame")
        toggleButton.Name = "ToggleButton"
        toggleButton.Size = UDim2.new(0, 36, 0, 18)
        toggleButton.Position = UDim2.new(1, -60, 0.5, -9)
        toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        toggleButton.BorderSizePixel = 0
        toggleButton.Parent = featureFrame
        
        -- Add corner radius to toggle button
        local toggleButtonCorner = Instance.new("UICorner")
        toggleButtonCorner.CornerRadius = UDim.new(0, 9)
        toggleButtonCorner.Parent = toggleButton
        
        -- Create toggle indicator
        local toggleIndicator = Instance.new("Frame")
        toggleIndicator.Name = "ToggleIndicator"
        toggleIndicator.Size = UDim2.new(0, 14, 0, 14)
        toggleIndicator.Position = UDim2.new(0, 2, 0.5, -7)
        toggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        toggleIndicator.BorderSizePixel = 0
        toggleIndicator.Parent = toggleButton
        
        -- Add corner radius to toggle indicator
        local toggleIndicatorCorner = Instance.new("UICorner")
        toggleIndicatorCorner.CornerRadius = UDim.new(0, 7)
        toggleIndicatorCorner.Parent = toggleIndicator
        
        -- Create toggle button click detector
        local toggleClickArea = Instance.new("TextButton")
        toggleClickArea.Name = "ToggleClickArea"
        toggleClickArea.Size = UDim2.new(1, 0, 1, 0)
        toggleClickArea.BackgroundTransparency = 1
        toggleClickArea.Text = ""
        toggleClickArea.Parent = toggleButton
        
        -- Toggle functionality
        local toggled = false
        toggleClickArea.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            -- Create toggle animation
            local toggleGoal = {}
            local indicatorGoal = {}
            
            if toggled then
                toggleGoal.BackgroundColor3 = config.accentColor
                indicatorGoal.Position = UDim2.new(1, -16, 0.5, -7)
                indicatorGoal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            else
                toggleGoal.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                indicatorGoal.Position = UDim2.new(0, 2, 0.5, -7)
                indicatorGoal.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            end
            
            -- Apply toggle animations
            TweenService:Create(toggleButton, config.tweenInfo, toggleGoal):Play()
            TweenService:Create(toggleIndicator, config.tweenInfo, indicatorGoal):Play()
        end)
    end
    
    -- Store references
    table.insert(categoryButtons, {
        button = categoryButton,
        indicator = indicator
    })
    
    categoryContents[category] = categoryContent
    
    -- Set up click handler
    categoryButton.MouseButton1Click:Connect(function()
        selectCategory(category)
    end)
end

-- Function to select a category
function selectCategory(category)
    -- Deselect all categories
    for _, btn in ipairs(categoryButtons) do
        TweenService:Create(btn.button, config.tweenInfo, {
            BackgroundColor3 = config.mainColor
        }):Play()
        btn.indicator.Visible = false
    end
    
    -- Hide all content frames
    for _, content in pairs(categoryContents) do
        content.Visible = false
    end
    
    -- Select the new category
    for _, btn in ipairs(categoryButtons) do
        if btn.button.Text == category then
            TweenService:Create(btn.button, config.tweenInfo, {
                BackgroundColor3 = config.accentColor
            }):Play()
            btn.indicator.Visible = true
        end
    end
    
    -- Show the selected content
    categoryContents[category].Visible = true
    
    -- Update selected category
    selectedCategory = category
end

-- Select the first category by default
selectCategory(config.categories[1])

-- Make the UI draggable
local dragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    TweenService:Create(shadowFrame, TweenInfo.new(0.1), {
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    }):Play()
end

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = shadowFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    -- Create closing animation
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    TweenService:Create(shadowFrame, tweenInfo, {
        Position = UDim2.new(0.5, -325, 1.5, 0),
        Size = UDim2.new(0, 650, 0, 50)
    }):Play()
    
    -- Destroy the UI after animation completes
    wait(0.7)
    screenGui:Destroy()
end)

-- Minimize button functionality
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    if minimized then
        TweenService:Create(shadowFrame, tweenInfo, {
            Size = UDim2.new(0, 650, 0, 40)
        }):Play()
    else
        TweenService:Create(shadowFrame, tweenInfo, {
            Size = UDim2.new(0, 650, 0, 400)
        }):Play()
    end
end)

-- Create pulsing effect for accent elements
local function createPulsingEffect()
    local t = 0
    RunService.Heartbeat:Connect(function(dt)
        if not screenGui.Parent then return end
        
        t = t + dt
        
        -- Create subtle pulsing effect
        local pulse = math.sin(t * 2) * 0.1 + 0.9
        local pulseColor = config.accentColor:Lerp(Color3.new(1, 1, 1), pulse * 0.1)
        
        -- Apply to active category indicators
        for _, btn in ipairs(categoryButtons) do
            if btn.indicator.Visible then
                btn.indicator.BackgroundColor3 = pulseColor
            end
        end
    end)
end

createPulsingEffect()

-- Add pop-up notification function
local function createNotification(message, duration)
    duration = duration or 3
    
    -- Create notification frame
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 250, 0, 60)
    notification.Position = UDim2.new(1, 20, 0.5, 0)
    notification.BackgroundColor3 = config.mainColor
    notification.BorderSizePixel = 0
    notification.AnchorPoint = Vector2.new(0, 0.5)
    notification.Parent = screenGui
    
    -- Add corner radius
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = config.cornerRadius
    notifCorner.Parent = notification
    
    -- Add notification text
    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotificationText"
    notifText.Size = UDim2.new(1, -20, 1, 0)
    notifText.Position = UDim2.new(0, 10, 0, 0)
    notifText.BackgroundTransparency = 1
    notifText.Text = message
    notifText.TextColor3 = config.textColor
    notifText.TextSize = 14
    notifText.Font = Enum.Font.Gotham
    notifText.TextWrapped = true
    notifText.Parent = notification
    
    -- Add accent line
    local accentLine = Instance.new("Frame")
    accentLine.Name = "AccentLine"
    accentLine.Size = UDim2.new(0, 4, 0.8, 0)
    accentLine.Position = UDim2.new(0, 0, 0.1, 0)
    accentLine.BackgroundColor3 = config.accentColor
    accentLine.BorderSizePixel = 0
    accentLine.Parent = notification
    
    -- Add corner radius to accent line
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 2)
    accentCorner.Parent = accentLine
    
    -- Add shadow
    local notifShadow = Instance.new("ImageLabel")
    notifShadow.Name = "Shadow"
    notifShadow.Size = UDim2.new(1, 30, 1, 30)
    notifShadow.Position = UDim2.new(0, -15, 0, -15)
    notifShadow.BackgroundTransparency = 1
    notifShadow.Image = "rbxassetid://" -- Shadow asset
    notifShadow.ImageColor3 = Color3.new(0, 0, 0)
    notifShadow.ImageTransparency = 0.6
    notifShadow.ScaleType = Enum.ScaleType.Slice
    notifShadow.SliceCenter = Rect.new(24, 24, 276, 276)
    notifShadow.ZIndex = -1
    notifShadow.Parent = notification
    
    -- Animate in
    notification.Position = UDim2.new(1, 20, 0.5, 0)
    TweenService:Create(notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -270, 0.5, 0)
    }):Play()
    
    -- Animate out after duration
    delay(duration, function()
        if notification and notification.Parent then
            TweenService:Create(notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, 20, 0.5, 0)
            }):Play()
            
            -- Remove after animation
            wait(0.8)
            if notification and notification.Parent then
                notification:Destroy()
            end
        end
    end)
    
    return notification
end

-- Show welcome notification
createNotification("Welcome to Stellar Hub!", 5)

-- Return the hub object for external control
return {
    screenGui = screenGui,
    createNotification = createNotification,
    selectCategory = selectCategory
}