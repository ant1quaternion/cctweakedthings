local monitor = peripheral.find("monitor")
while true do
    sleep(10)
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("test")
