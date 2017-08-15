function Initialize() --link this script to rainmeter code in "MyFirstSkin.ini"

   measureXML = SKIN:GetMeasure('MeasureAllXML')
end

function Update()
  
   allXML = measureXML:GetStringValue()
   if allXML == '' then return end
  
  for url in string.gmatch(AllXML, "http:.-$") do SKIN:Bang('!Log', url) end


   SKIN:Bang('!Log', allXML)
   return 3

end