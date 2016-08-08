import UIKit

class RMTip: MKButton {
    func tapped(){
        RMAudioManager.playSE("Button", type: "mp3")
    }
    init(icon:String){
        super.init(frame: CGRectZero)
        frame.size = CGSizeMake(48, 48)
        layer.cornerRadius = 24
        setTitle(icon, forState: .Normal)
        titleLabel?.font = mi_font(24)
        addTarget(self, action: #selector(RMTip.tapped), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}