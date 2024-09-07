
local first = true
local row = 4
local column = 4
local spinLeft = false

function refuel() 

    local fuel = turtle.getFuelLevel()
    
    print("fuelLevel: "..fuel)
    
    if fuel < 50 then
        turtle.select(1)
        turtle.refuel(1)
        print("Refueled: "..turtle.getFuelLevel())
    end 

end

function setTopper()

    print("Seting Top")    
    for i=1,5 do
        turtle.digUp()
        turtle.up()
    end
    
    turtle.select(3)
    turtle.place()
    turtle.up()
    turtle.place()
    turtle.up()
    turtle.place()
    
    for i=1,9 do
        turtle.down()
    end
    
    turtle.select(2)
    turtle.place()

    turtle.select(1)
end

function spin(left)

    turtle.digUp()
    turtle.up()
    turtle.dig()
    turtle.forward()
    
    if left ~= true then
        print("spin Left")
        turtle.turnRight()
        turtle.dig()
        turtle.forward()
        turtle.turnRight()
        turtle.turnRight()
        turtle.digDown()
        turtle.down()
    else
        print("Spin Right")
        turtle.turnLeft()
        turtle.dig()
        turtle.forward()
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.digDown()
        turtle.down()
    end
end

function DetectTree()

    local seeBlock, data = turtle.inspect()

    if seeBlock then
        print("Block name", data.name)
        
        if data.name == "minecraft:log" then
            print("True")
            return true
        end
    end
    return false
end

function ChopTree()

    print("Choping Tree")    
    local height = 1
    
    while DetectTree() do
        height = height + 1
        turtle.digUp()
        turtle.dig()
        turtle.up()
    end

    for i=1,height do
        turtle.down()
    end
    
    turtle.select(2)
    turtle.place()
    turtle.select(1)

end

function WoodCheck()

    turtle.select(4)
    local WoodCount = turtle.getItemCount() > 5
    return WoodCount
end

function ToStart()

    print("Back To Home")
    
    turtle.digUp()
    turtle.up()
    
    for i=1,7 do
        turtle.dig()
        turtle.forward()
    end

    turtle.turnLeft()

    local dimention = row * column
    dimention = dimention + 2
    
    for i=1, dimention do
        turtle.dig()
        turtle.forward()        
    end    
    
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
    turtle.turnRight()
    turtle.down()    

end

function nextSpot()

    turtle.digUp()
    turtle.up()
    
    for i=1,6 do
        turtle.dig()
        turtle.suckDown()
        turtle.forward()
    end 
    
    turtle.digDown()
    turtle.down()
    
    if turtle.detect() then
        print("I see Somthing")
        
        if DetectTree() then
            ChopTree()
        else
            print("No Tree")
        end
        
        turtle.suck()
        
    else
       setTopper()       
    end  
   
     
        
end

local spinTwo = false
local coalIN = turtle.getItemCount() > 19
local woodIN = false

while coalIN do

spinLeft = true

for r=1,row do

    for c=1,column do
        refuel()
        nextSpot() 
        
        if spinTwo then
            spinTwo = false            
            spin(spinLeft)
        end
                   
    end

    if r ~= row then
        if spinLeft then
            spinTwo = true
            spinLeft = false
        else
            spinTwo = true
            spinLeft = true
        end
        
        spin(spinLeft)
    else
        ToStart()
    end
    
    
end

    turtle.select(1)
    coalIN = turtle.getItemCount() < 19
    woodIN = WoodCheck()
    
    while coalIN do
        print("Waiting for Coal")
        turtle.select(1)
        coalIN = turtle.getItemCount() < 19
    end
        
    
    while woodIN do
        print("Waiting for Wood")
        woodIN = WoodCheck()
    end

    turtle.select(1)
        
    coalIN = true
end

first = false