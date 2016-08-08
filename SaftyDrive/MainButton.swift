import UIKit

enum mainButtonPosition {
    case lowerRight
    case lowerLeft
    case lowerCenter
    case upperRight
    case upperLeft
    case upperCenter
}
enum mainButtonAnimationStyle{
    case none
    case pop
    case move
}
class MainButton: MKButton {
    var position = mainButtonPosition.lowerRight
    var animationStyle = mainButtonAnimationStyle.none
    var titleColor:UIColor{
        get{
            return currentTitleColor
        }
        set(value){
            setTitleColor(value, forState: .Normal)
        }
    }
    var icon:String{
        get{
            return currentTitle!
        }
        set(value){
            setTitle(value, forState: .Normal)
        }
    }
    @objc private func PmainButtonTapped(){
        UIView.animateWithDuration(
            0.5,
            animations: {
                self.layer.shadowOffset = CGSize(width: 0, height: 9)
                self.layer.shadowRadius = 6
            }
        )
    }
    @objc private func PmainButtonOn(){
        PmainButtonOffed()
        RMAudioManager.playSE("Button", type: "mp3")
    }
    @objc private func PmainButtonOffed(){
        UIView.animateWithDuration(
            0.5,
            animations: {
                self.layer.shadowOffset = CGSize(width: 0, height: 5)
                self.layer.shadowRadius = 4
            }
        )
    }
    
    func animate(){
        let oldPosition = self.frame.origin
        self.transform = CGAffineTransformMakeScale(0, 0)
        switch animationStyle {
        case .pop:
            UIView.animateWithDuration(
                0.2,
                delay: 0.2,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    self.transform = CGAffineTransformMakeScale(1, 1)
                },
                completion: {(Bool) in}
            )
        case .move:
            self.frame.size = CGSize(width: 60, height: 60)
            self.frame.origin.y += 80
            UIView.animateWithDuration(
                0.2,
                delay: 0.2,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    self.frame.origin = oldPosition
                },
                completion: {(Bool) in}
            )
        case .none:
            break
        }
    }
    init(icon:String,position:mainButtonPosition,animationStyle:mainButtonAnimationStyle){
        super.init(frame: CGRectZero)
        self.position = position
        self.animationStyle = animationStyle
        backgroundColor = accentColor
        frame.size = CGSize(width: 60, height: 60)
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 5)
        addTarget(self, action: #selector(MainButton.PmainButtonTapped), forControlEvents: .TouchDown)
        addTarget(self, action: #selector(MainButton.PmainButtonOn), forControlEvents: .TouchUpInside)
        addTarget(self, action: #selector(MainButton.PmainButtonOffed), forControlEvents: .TouchUpOutside)
        addTarget(self, action: #selector(MainButton.PmainButtonOffed), forControlEvents: .TouchCancel)
        titleLabel?.font = mi_font(24)
        if !accentColor.is_dark {
            setTitleColor(UIColor.whiteColor(), forState: .Normal)
        }else{
            setTitleColor(subTextColor, forState: .Normal)
        }
        setTitle(icon, forState: .Normal)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}










