import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var myEffectView: UIView!
    
    //====================================================================
    //application
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        return true
    }
    //====================================================================
    //applicationWillResignActive
    func applicationWillResignActive(application: UIApplication) {
        RMAudioManager.playSE("Close", type: "mp3")
        let effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        myEffectView = UIVisualEffectView(effect: effect)
        myEffectView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        window?.addSubview(myEffectView)
    }
    //====================================================================
    //applicationDidEnterBackground
    func applicationDidEnterBackground(application: UIApplication) {}
    //====================================================================
    //applicationWillEnterForeground
    func applicationWillEnterForeground(application: UIApplication) {}
    //====================================================================
    //applicationDidBecomeActive
    func applicationDidBecomeActive(application: UIApplication) {
        RMAudioManager.playSE("Open", type: "mp3")
        if myEffectView != nil {
            self.myEffectView.removeFromSuperview()
        }
    }
    //====================================================================
    //applicationWillTerminate
    func applicationWillTerminate(application: UIApplication) {}
}