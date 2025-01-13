                                                                                 local player=game.    
                                                                        Players.LocalPlayer;local character=player.     
                                                                    Character or player.CharacterAdded:Wait() ;local              
                                                                humanoidRootPart=character:WaitForChild("HumanoidRootPart");local       
                                                            UserInputService=game:GetService("UserInputService");local levels={{location1 
                                                          =Vector3.new( -47.276222229003906,3.999999761581421, -66.55294036865234),         
                                                        location2=Vector3.new( -59.20359420776367,71.99992370605469, -77.61924743652344),     
                                                      delay=1.02},{location1=Vector3.new( -112.25444030761719,3.999999761581421, -              
                                                    66.39424896240234),location2=Vector3.new( -120.97818756103516,74.0000228881836, -             
                                                  109.56258392333984),delay=1.025},{location1=Vector3.new( -206.28701782226562,3.999999523162842, - 
                                                  72.34754943847656),location2=Vector3.new( -189.44268798828125,122.39969635009766, -                 
                                                64.09607696533203),delay=1.025},{location1=Vector3.new( -344.5915832519531,3.999999761581421,           
                                                105.57103729248047),location2=Vector3.new( -1351.9378662109375,3.999999761581421,105.24887084960938),     
                                              delay=1.019},{location1=Vector3.new( -309.7260437011719,3.999999761581421,35.417484283447266),location2=      
                                              Vector3.new( -319.0489807128906,1004.0036010742188,33.59334182739258),delay=1.019}};local function            
                                            teleportToLocation(targetPosition) humanoidRootPart.CFrame=CFrame.new(targetPosition);end local function          
                                            teleportLevel(level) local levelData=levels[level];if levelData then teleportToLocation(levelData.location1);wait(  
                                          levelData.delay);teleportToLocation(levelData.location2);else warn("Nieprawidłowy poziom: "   .. tostring(level) );end  
                                          end local existingGui=player:WaitForChild("PlayerGui"):FindFirstChild("TeleportGUI");if existingGui then existingGui:     
                                          Destroy();end local ScreenGui=Instance.new("ScreenGui");ScreenGui.Name="TeleportGUI";ScreenGui.Parent=player:WaitForChild(  
                                          "PlayerGui");local Frame=Instance.new("Frame",ScreenGui);Frame.Size=UDim2.new(0,250,0,350);Frame.Position=UDim2.new(0.5, -  
                                        125,0.5, -175);Frame.BackgroundColor3=Color3.new(0.1,0.1,0.1);Frame.BackgroundTransparency=0.2;Frame.BorderSizePixel=3;Frame.   
                                        BorderColor3=Color3.fromRGB(255,255,255);Frame.Visible=true;Frame.    --[[==============================]]Position=UDim2.new(0.5, 
                                         -125,0.5, -250);Frame:TweenPosition(UDim2.new(0.5, -125,   --[[============================================]]0.5, -175),Enum.    
                                        EasingDirection.Out,Enum.EasingStyle.Bounce,1);local    --[[======================================================]]titleFrame=     
                                      Instance.new("Frame",Frame);titleFrame.Size=UDim2.new --[[==========================================================]](1,0,0,40);       
                                      titleFrame.Position=UDim2.new(0,0,0,0);titleFrame.  --[[==============================================================]]                
                                      BackgroundTransparency=1;local titleLabel=Instance. --[[================================================================]]new("TextLabel" 
                                      ,titleFrame);titleLabel.Size=UDim2.new(1,0,1,0);    --[[==================================================================]]titleLabel.   
                                      Text="Wall Hop Practice";titleLabel.TextSize=25;    --[[==================================================================]]titleLabel.       
                                    TextColor3=Color3.fromRGB(255,255,255);titleLabel.    --[[====================================================================]]              
                    BackgroundTransparency=1;titleLabel.TextXAlignment=Enum.              --[[====================================================================]]TextXAlignment. 
              Center;titleLabel.Font=Enum.Font.GothamBold;local buttonsFrame=Instance.new --[[======================================================================]]("Frame",     
            Frame);buttonsFrame.Size=UDim2.new(1,0,1, -40);buttonsFrame.Position=UDim2.   --[[======================================================================]]new(0,0,0,40) 
          ;buttonsFrame.BackgroundTransparency=1;local UIListLayout=Instance.new(         --[[======================================================================]]              
        "UIListLayout",buttonsFrame);UIListLayout.FillDirection=Enum.FillDirection.       --[[======================================================================]]Vertical;     
        UIListLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center;UIListLayout.    --[[======================================================================]]              
      VerticalAlignment=Enum.VerticalAlignment.Top;UIListLayout.Padding=UDim.new(0,10);   --[[======================================================================]]for i=1, #    
      levels do local button=Instance.new("TextButton",buttonsFrame);button.Size=UDim2.new( --[[==================================================================]]0,180,0,30);    
      button.Text="Poziom "   .. i ;button.BackgroundColor3=Color3.fromRGB(0,170,255);      --[[================================================================]]button.TextColor3 
    =Color3.fromRGB(255,255,255);button.TextSize=18;button.MouseButton1Click:Connect(       --[[==============================================================]]function()        
    teleportLevel(i);end);local buttonCorner=Instance.new("UICorner");buttonCorner.           --[[==========================================================]]CornerRadius=UDim.  
    new(0,12);buttonCorner.Parent=button;end local infoLabel=Instance.new("TextLabel",Frame);   --[[====================================================]]infoLabel.Size=UDim2.   
    new(1,0,0,30);infoLabel.Position=UDim2.new(0,0,1, -40);infoLabel.Text=                        --[[==============================================]]                          
    "Naciśnij 'P' aby otworzyć/zamknąć GUI";infoLabel.TextSize=14;infoLabel.TextColor3=Color3.fromRGB --[[====================================]](255,255,255);infoLabel.      
    BackgroundTransparency=1;infoLabel.TextXAlignment=Enum.TextXAlignment.Center;infoLabel.Font=Enum.Font --[[========================]].Gotham;local isDragging=false;local  
    dragStart,startPos;Frame.InputBegan:Connect(function(input) if (input.UserInputType==Enum.UserInputType.MouseButton1) then isDragging=true;dragStart=input.Position;    
  startPos=Frame.Position;end end);Frame.InputChanged:Connect(function(input) if (isDragging and (input.UserInputType==Enum.UserInputType.MouseMovement)) then local      
  delta=input.Position-dragStart ;Frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X ,startPos.Y.Scale,startPos.Y.Offset + delta.Y );end end);Frame. 
  InputEnded:Connect(function(input) if (input.UserInputType==Enum.UserInputType.MouseButton1) then isDragging=false;end end);UserInputService.InputBegan:Connect(        
  function(input,gameProcessedEvent) if ( not gameProcessedEvent and (input.KeyCode==Enum.KeyCode.P)) then Frame.Visible= not Frame.Visible;end end);