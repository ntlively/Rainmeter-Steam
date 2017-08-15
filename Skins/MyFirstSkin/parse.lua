function Initialize() --link this script to rainmeter code in "MyFirstSkin.ini"
   GameList = {}
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
  end
  SKIN:Bang('!Log',GameList[1][3]) 
  SKIN:Bang('!Log'," >>>logo url ^<<< \n\n")
  --SKIN:Bang('!SetOption', MeasureImage, URL ,GameList[1][3])
   --return GameList[1][3]
   SKIN:Bang('!SetOption FirstImage URL \"' ..GameList[1][3] .. '\"')
   SKIN:Bang('!SetOption FirstGame LeftMouseUpAction \"steam://rungameid/'..GameList[1][1] .. '\"')
   
   SKIN:Bang('!SetOption SecondImage URL \"' ..GameList[2][3] .. '\"')
   SKIN:Bang('!SetOption SecondGame LeftMouseUpAction \"steam://rungameid/'..GameList[2][1] .. '\"')
   
   SKIN:Bang('!SetOption ThirdImage URL \"' ..GameList[3][3] .. '\"')
   SKIN:Bang('!SetOption ThirdGame LeftMouseUpAction \"steam://rungameid/'..GameList[3][1] .. '\"')
   
   SKIN:Bang('!UpdateMeasure FirstImage')
   SKIN:Bang('!UpdateMeasure SecondImage')
   SKIN:Bang('!UpdateMeasure ThirdImage')

end
