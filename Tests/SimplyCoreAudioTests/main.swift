import Foundation
import SimplyCoreAudio

let simply = SimplyCoreAudio()

print("All Devices: ")

for device in simply.allDevices {
	print("  " + device.description)
}


