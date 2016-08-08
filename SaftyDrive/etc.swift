import UIKit

//==========================================================================
//グローバル変数
var mainColor = UIColor.hexStr("#7FC247", alpha: 1)
let accentColor = UIColor.hexStr("#FFEB3B", alpha: 1)
let backColor = UIColor.hexStr("#fafafa", alpha: 1)
let textColor = UIColor.hexStr("#212121", alpha: 1)
let subTextColor = UIColor.hexStr("#767676", alpha: 1)
let defaults = NSUserDefaults()
let cache =  NSCache()
//==========================================================================
//グローバル関数
func setRound(float:CGFloat)->CGFloat{
    return CGFloat(Int(float))
}
func dp(dp:Int)->CGFloat{
    return setRound(CGFloat(dp)*0.95)
}
func navigationItemColor()->UIColor{
    var color = UIColor.whiteColor()
    if mainColor.is_dark {
        color = UIColor.hexStr("616161", alpha: 1)
    }
    return color
}
func mi_font(size:Int)->UIFont{
    return UIFont(name: "MaterialIcons-Regular", size: CGFloat(size))!
}
func main_font(size:Int)->UIFont{
    return UIFont(name: "Roboto-Light", size: CGFloat(size))!
}
func main_font_bold(size:Int)->UIFont{
    return UIFont(name: "RobotoDraft-Bold", size: CGFloat(size))!
}
func main_font_italic(size:Int)->UIFont{
    return UIFont(name: "RobotoDraft-Italic", size: CGFloat(size))!
}
func main_font_midium(size:Int)->UIFont{
    return UIFont(name: "RobotoDraft-Medium", size: CGFloat(size))!
}
func undef(){
    print("you call undefined number or object in switch brock.")
}
//==========================================================================
//オリジナルクラス
class Math{
    class func Max(Arr:[Int])->Int{
        var ans = Arr[0]
        for num in Arr {
            if ans<num {
                ans = num
            }
        }
        return ans
    }
    class func Max(Arr:[Double])->Double{
        var ans = Arr[0]
        for num in Arr {
            if ans<num {
                ans = num
            }
        }
        return ans
    }
    class func Max(Arr:[Float])->Float{
        var ans = Arr[0]
        for num in Arr {
            if ans<num {
                ans = num
            }
        }
        return ans
    }
class func Max(Arr:[CGFloat])->CGFloat{
        var ans = Arr[0]
        for num in Arr {
            if ans<num {
                ans = num
            }
        }
        return ans
    }
}
class Separator:UIView{
    init(width:CGFloat){
        super.init(frame: CGRectZero)
        frame.size.width = width
        frame.size.height = 1
        backgroundColor = UIColor.hexStr("#dadada", alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class Regexp {
    let internalRegexp: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalRegexp = try! NSRegularExpression( pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
    }
    
    func isMatch(input: String) -> Bool {
        let matches = self.internalRegexp.matchesInString( input, options: [], range:NSMakeRange(0, input.characters.count) )
        return matches.count > 0
    }
    
    func matches(input: String) -> [String]? {
        if self.isMatch(input) {
            let matches = self.internalRegexp.matchesInString( input, options: [], range:NSMakeRange(0, input.characters.count) )
            var results: [String] = []
            for i in 0 ..< matches.count {
                results.append( (input as NSString).substringWithRange(matches[i].range) )
            }
            return results
        }
        return nil
    }
}
//==========================================================================
//標準クラス拡張
extension UIView {
    var buttomY:CGFloat{
        get{
            return self.frame.size.height+self.frame.origin.y
        }
    }
    func shadowLevel(lv:Int){
        self.layer.shadowOffset = CGSize(width: 0, height: Double(lv)*0.7)
        self.layer.shadowColor = UIColor.blackColor().CGColor
        if lv<5 {
            self.layer.shadowOpacity = 0.4
        }else{
            self.layer.shadowOpacity = 0.6
        }
        self.layer.shadowRadius = CGFloat(lv)*0.7
    }
    func radiusLevel(px:CGFloat){
        self.layer.cornerRadius = CGFloat(px)
    }
    func setRadius(Corners:UIRectCorner,radiusLevel:CGFloat){
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: Corners,
            cornerRadii: CGSizeMake(radiusLevel, radiusLevel)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.CGPath
        layer.mask = maskLayer
    }
}
extension UITextView {
    func _firstBaselineOffsetFromTop() {
    }
    func _baselineOffsetFromBottom() {
    }
    func noPadding(){
        textContainerInset = UIEdgeInsetsZero
        textContainer.lineFragmentPadding = 0
    }
}
extension UIColor {
    var is_dark:Bool{
        get{
            var ans = true
            let v = max(r*0.9, g*0.8, b*0.4)
            if v>0.5 {
                ans = false
            }
            return ans
        }
    }
    var hexColor: UInt32 {
        let colorSpace = CGColorGetColorSpace(self.CGColor)
        let colorSpaceModel = CGColorSpaceGetModel(colorSpace)
        if colorSpaceModel.rawValue == 1 {
            let x = CGColorGetComponents(self.CGColor)
            let r: Int = Int(x[0] * 255.0)
            let g: Int = Int(x[1] * 255.0)
            let b: Int = Int(x[2] * 255.0)
            let hex = UInt32(r >> 4 + g >> 2 + b)
            return hex
        }else{
            return 0
        }
    }
    func setAlpha(alpha: CGFloat)->UIColor{
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    var r:CGFloat{
        let colorSpace = CGColorGetColorSpace(self.CGColor)
        let colorSpaceModel = CGColorSpaceGetModel(colorSpace)
        if colorSpaceModel.rawValue == 1 {
            let x = CGColorGetComponents(self.CGColor)
            return x[0]
        }else{
            return 0
        }
    }
    var g:CGFloat{
        let colorSpace = CGColorGetColorSpace(self.CGColor)
        let colorSpaceModel = CGColorSpaceGetModel(colorSpace)
        if colorSpaceModel.rawValue == 1 {
            let x = CGColorGetComponents(self.CGColor)
            return x[1]
        }else{
            return 0
        }
    }
    var b:CGFloat{
        let colorSpace = CGColorGetColorSpace(self.CGColor)
        let colorSpaceModel = CGColorSpaceGetModel(colorSpace)
        if colorSpaceModel.rawValue == 1 {
            let x = CGColorGetComponents(self.CGColor)
            return x[2]
        }else{
            return 0
        }
    }
    var a:CGFloat{
        let colorSpace = CGColorGetColorSpace(self.CGColor)
        let colorSpaceModel = CGColorSpaceGetModel(colorSpace)
        if colorSpaceModel.rawValue == 1 {
            let x = CGColorGetComponents(self.CGColor)
            return x[3]
        }else{
            return 0
        }
    }
    
    class func hex (hex : UInt32, alpha : CGFloat) -> UIColor {
        let hexStr = String(hex, radix: 16)
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        }else{
            return UIColor(white: 1, alpha: alpha)
        }
    }
    
    class func hexStr (hexStr : NSString, alpha : CGFloat) -> UIColor {
        var color = UIColor()
        switch hexStr {
        case "0":
            color = UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        case "1":
            color = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
        case "r":
            color = UIColor(red: 1, green: 0, blue: 0, alpha: alpha)
        case "g":
            color = UIColor(red: 0, green: 1, blue: 0, alpha: alpha)
        case "b":
            color = UIColor(red: 0, green: 0, blue: 1, alpha: alpha)
        default:
            let hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
            let scanner = NSScanner(string: hexStr as String)
            var colorNum: UInt32 = 0
            if scanner.scanHexInt(&colorNum) {
                let r = CGFloat((colorNum & 0xFF0000) >> 16) / 255.0
                let g = CGFloat((colorNum & 0x00FF00) >> 8) / 255.0
                let b = CGFloat(colorNum & 0x0000FF) / 255.0
                color = UIColor(red:r,green:g,blue:b,alpha:alpha)
            }else{
                color = UIColor(white: 1, alpha: alpha)
            }
        }
        return color
    }
}
extension UIImageView {
    class func maskImage(image: UIImage, maskImage: UIImage) -> UIImageView {
        
        let maskRef = maskImage.CGImage!
        let mask = CGImageMaskCreate(
            CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef),
            nil,
            false
            )!
        let maskedImageRef = CGImageCreateWithMask(image.CGImage, mask)!
        let maskedImage = UIImage(CGImage: maskedImageRef)
        let maskedImageView = UIImageView(image: maskedImage)
        maskedImageView.frame = CGRect(origin: CGPointZero, size: maskImage.size)
        
        return maskedImageView
    }
}
extension UIImage {
    class func getPixelColorFromUIImage(myUIImage:UIImage, pos: CGPoint) -> UIColor {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(myUIImage.CGImage))
        let data: UnsafePointer = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(myUIImage.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    class func maskImage(image:UIImage,maskImage:UIImage) -> UIImage{
        let maskRef = maskImage.CGImage!
        let mask = CGImageMaskCreate(
            CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef),
            nil,
            false
            )!
        let maskedImageRef = CGImageCreateWithMask(image.CGImage, mask)!
        let maskedImage = UIImage(CGImage: maskedImageRef)
        
        return maskedImage
    }
}

















