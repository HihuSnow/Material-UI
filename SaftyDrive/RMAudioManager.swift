//RMAudioManager
import AudioToolbox

class RMAudioManager:NSObject{
    class func playSE(name:String,type:String){
        var soundIdRing:SystemSoundID = 0
        let path = NSBundle.mainBundle().pathForResource(name, ofType: type)!
        let fileURL = NSURL(fileURLWithPath: path as String)
        AudioServicesCreateSystemSoundID(fileURL, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
    }
}