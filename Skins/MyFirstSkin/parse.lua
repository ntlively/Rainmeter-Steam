function Initialize() --link this script to rainmeter code in "MyFirstSkin.ini"
   GameList = {}
   TopThree={}
   i=0
   measureXML = SKIN:GetMeasure('MeasureAllXML')
   firstImage = SKIN:GetMeasure('FirstImage')
   secondImage = SKIN:GetMeasure('SecondImage')
   thirdImage = SKIN:GetMeasure('ThirdImage')
end


function Update()
  
   allXML = measureXML:GetStringValue()
   if allXML == '' then return end

   dummyString, dataCount = string.gsub(allXML, '<game>', '')
   SKIN:Bang('!SetOption', 'MeterDataCount', 'Text', 'Count of entries: '..dataCount)
   --SKIN:Bang('!Log', allXML)
   
   
   
   
  for game in string.gmatch(allXML, "%<game>(.-)%</game>") do 
    -- Creating an object
    --(%S+) means take one or more of anything that isnt a space
    local id = string.match(game, "%<appID>(%S+)%</appID>")
    local name = string.match(game, "%<name><!%[CDATA%[(.-)%]%]>%</name>")  --% is the escape character for the [] brackets
    local logo = string.match(game, "(%http://cdn%S+)%]%]>")
    local storeLink = string.match(game, "%<storeLink><!%[CDATA%[(.-)%]%]></storeLink>")
    local recentHours = string.match(game, "%<hoursLast2Weeks>(%S+)%</hoursLast2Weeks>")
    local totalHours = string.match(game, "%<hoursOnRecord>(%S+)%</hoursOnRecord>")
    

    GameList[#GameList+1] = {id,name,logo,storeLink,recentHours,totalHours}
    
    i = i+1
    SKIN:Bang('!Log', "\n\n >>>START GAME<<< \n\n"..game .."\n\n >>>END GAME<<< \n\n") 
    SKIN:Bang('!Log', GameList[i][1])
    SKIN:Bang('!Log', " >>>ID ^<<< \n\n") 
    SKIN:Bang('!Log', GameList[i][2]) 
    SKIN:Bang('!Log', " >>>NAME ^<<< \n\n") 
    SKIN:Bang('!Log', GameList[i][3])
    SKIN:Bang('!Log', " >>>LOGO ^<<< \n\n") 
    SKIN:Bang('!Log', GameList[i][4])
    SKIN:Bang('!Log', " >>>STORE^<<< \n\n") 
    SKIN:Bang('!Log', GameList[i][5])
    SKIN:Bang('!Log', " >>>RECENT HOURS ^<<< \n\n") 
    SKIN:Bang('!Log', GameList[i][6]) 
    SKIN:Bang('!Log'," >>>TOTAL HOURS ^<<< \n\n")
    SKIN:Bang('!Log', i) 
    SKIN:Bang('!Log'," >>>count ^<<< \n\n") 
    
    if i<=3 then 
      TopThree[#TopThree+1] = {GameList[i][1],GameList[i][2],GameList[i][3],GameList[i][4],GameList[i][5],GameList[i][6]}
    else
     -- SKIN:Bang('!Log'," >>>$$$$$$$$$$$$$$$<<< \n\n") 
      --SKIN:Bang('!Log',TopThree[1][6])
      --SKIN:Bang('!Log',TopThree[2][6])
     -- SKIN:Bang('!Log',TopThree[3][6])
     -- SKIN:Bang('!Log'," >>>$$$$$$$$$$$$$$$<<< \n\n") 
        for index,value in ipairs(TopThree) do
      --SKIN:Bang('!Log'," >>>TOPTHREE TEST<<< \n\n") 
     -- SKIN:Bang('!Log',index)
     -- SKIN:Bang('!Log',value)
      --   SKIN:Bang('!Log','<TOPTHREE>'..TopThree[index][6])
      --SKIN:Bang('!Log','<GAMELIST>'..GameList[i][6])
     -- SKIN:Bang('!Log'," >>>TOPTHREE TEST<<< \n\n") 
          if GameList[i][6] ~= nil then
            if tonumber(GameList[i][6]) > tonumber(TopThree[index][6]) then
              SKIN:Bang('!Log','+++++++++++++++++++++++++++++++++++++++++++TRUE')
                TopThree[index][1] = GameList[i][1]
                TopThree[index][2] = GameList[i][2]
                TopThree[index][3] = GameList[i][3]
                TopThree[index][4] = GameList[i][4]
                TopThree[index][5] = GameList[i][5]
                TopThree[index][6] = GameList[i][6]
            end
          end
        end
        
    end
    
  end
  SKIN:Bang('!Log',GameList[1][3]) 
  SKIN:Bang('!Log'," >>>logo url ^<<< \n\n")
  --SKIN:Bang('!SetOption', MeasureImage, URL ,GameList[1][3])
   --return GameList[1][3]
   SKIN:Bang('!SetOption FirstImage URL \"' ..TopThree[1][3] .. '\"')
   SKIN:Bang('!SetOption FirstGame LeftMouseUpAction \"steam://rungameid/'..TopThree[1][1] .. '\"')
   
   SKIN:Bang('!SetOption SecondImage URL \"' ..TopThree[2][3] .. '\"')
   SKIN:Bang('!SetOption SecondGame LeftMouseUpAction \"steam://rungameid/'..TopThree[2][1] .. '\"')
   
   SKIN:Bang('!SetOption ThirdImage URL \"' ..TopThree[3][3] .. '\"')
   SKIN:Bang('!SetOption ThirdGame LeftMouseUpAction \"steam://rungameid/'..TopThree[3][1] .. '\"')
   
   SKIN:Bang('!UpdateMeasure FirstImage')
   SKIN:Bang('!UpdateMeasure SecondImage')
   SKIN:Bang('!UpdateMeasure ThirdImage')

end
