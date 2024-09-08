local turnRight = true

function refuel()
    local fuel = turtle.getFuelLevel()
    print("Fuel Level: "..fuel)
    
    if fuel < 50 then
        turtle.select(1)
        turtle.refuel(1)
        print("Refuel Level: "..turtle.getFuelLevel())
    end        
end

function moveFirst()

    turtle.forward()
    turtle.forward()
    turtle.forward()
    
    turtle.turnLeft()
    
    turtle.forward()
    turtle.forward()
    turtle.forward()
    turtle.forward()
    
    turtle.turnRight()
    
    turtle.up()
    turtle.forward()
    turtle.forward()
    

end

function turn()

    if turnRight then
        turtle.turnRight()
    else
        turtle.turnLeft()
    end    

end



function plantBayOne()
    
    for col=1,4 do
        refuel()

        turtle.select(3)
        turtle.placeDown()
                
        for row=1,8 do
            turtle.forward()
            turtle.placeDown()
        end
        
        turn()
        turtle.forward()
        turn()
        
        if turnRight then 
            turnRight = false
        else
            turnRight = true
        end
                
    end
    
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
    
    
end

function BackToStart()

    turtle.turnLeft()
    turtle.turnLeft()
    
    for i=1,4 do
        turtle.forward()    
    end

    turtle.turnRight()
    
    for i=1,6 do
        turtle.forward()
    end
    
    turtle.down()
    turtle.turnRight()
    turtle.back()
end


turtle.select(1)
while turtle.getItemCount() > 19 do
    
    refuel()
    moveFirst()
    plantBayOne()
    plantBayOne()
    BackToStart()

    turtle.select(3)
    while turtle.getItemCount() < 64 do
        print("Waiting for Seeds")
        os.sleep(5)
    end

    turtle.select(1)
end