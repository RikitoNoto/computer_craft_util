local Master = {

}

function Master.new ()
  return {

    listen = function (port, callback)
      if port ~= nil then
        local modem = peripheral.find("modem") or error("No modem attached", 0)
        modem.open(port)
      else
        rednet.open()
      end

      while true do
        sleep(0.01)
        local sender_id, message, distance = rednet.receive()
        if callback ~= nil then
          callback(sender_id, message, distance)
        end
      end
    end
  }
end

local Slave = {

}

function Slave.new ()
end
return {
  Master = Master,
}
