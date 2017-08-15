function Initialize() --link this script to rainmeter code in "MyFirstSkin.ini"

   measureXML = SKIN:GetMeasure('MeasureAllXML')
end
function Update()
  
   allXML = measureXML:GetStringValue()
   if allXML == '' then return end

   dummyString, dataCount = string.gsub(allXML, '<game>', '')
   SKIN:Bang('!SetOption', 'MeterDataCount', 'Text', 'Count of entries: '..dataCount)
   --SKIN:Bang('!Log', allXML)
   
   --From allXML string, find a pattern: starting from http://cdn, taking all characters not whitespace, stopping at ]]>
  for url in string.gmatch(allXML, "(%http://cdn%S+)%]]>") do 
    -- Creating an object
    myGame = Game:new(nil,1,dotes,url,0,0)

    SKIN:Bang('!Log', myGame.URL) 
    
    end
   return dataCount

end

-- Meta class
Game = {id = 0,name="", URL = "",recentHours=0,totalHours=0}

-- Base class method new

function Game:new (o,id,name,URL,recentHours,totalHours)
   o = o or {}
   setmetatable(o, self)
   self.__index = self
   self.id = id or 0
   self.name = name or ""
   self.URL = URL or ""
   self.recentHours = recentHours or 0
   self.totalHours = totalHours or 0
   return o
end

-- Base class method printArea

function Game:printURL()
   print("The area is ",self.URL)
end