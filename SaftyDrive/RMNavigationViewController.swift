import UIKit

class RMNavigationController: UIViewController,UIGestureRecognizerDelegate{
    //====================================================================
    //member
    var showNavigationBer:Bool{
        get{
            return rawShowNavigationBer
        }
        set(value){
            if rawShowNavigationBer != value {
                if value {
                    UIView.animateWithDuration(
                        0.2,
                        delay: 0,
                        options: UIViewAnimationOptions.CurveEaseOut,
                        animations: {
                            self.navigationBar.frame.origin.y = 20
                            self.contentView.frame.size.height -= 52
                            self.contentView.frame.origin.y += 52
                        },
                        completion: {(Bool) in}
                    )
                }else{
                    UIView.animateWithDuration(
                        0.2,
                        delay: 0,
                        options: UIViewAnimationOptions.CurveEaseOut,
                        animations: {
                            self.navigationBar.frame.origin.y = -(self.navigationBar.frame.size.height)+20
                            self.contentView.frame.size.height += 52
                            self.contentView.frame.origin.y -= 52
                        },
                        completion: {(Bool) in}
                    )
                }
            }
            rawShowNavigationBer = value
        }
    }
    private var rawShowNavigationBer = true
    var showShadow:Bool{
        get{
            return rawShowShadow
        }
        set(value){
            if value {
                navigationBar.layer.shadowOpacity = 0.5
            }else{
                navigationBar.layer.shadowOpacity = 0
            }
        }
    }
    private var rawShowShadow = true
    var themeColor:UIColor{
        get{
            return rawColor
        }
        set(value){
            rawColor = value
            statasBarBackground.backgroundColor = value
            navigationBar.backgroundColor = value
        }
    }
    private var rawColor = UIColor()
    var titleText:String{
        get{
            return rawTitle
        }
        set(value){
            titleTextLabel.text = value
        }
    }
    private var rawTitle = ""
    private var navigationBarButtonsLeft:[RMTip] = []
    private var navigationBarButtonsRight:[RMTip] = []
    //======================================
    //Views
    var mainButton:MainButton?{
        get{
            return rawMainButton
        }
        set(value){
            setMainButtonPosition(value)
            if rawMainButton == nil {
                view.addSubview(value!)
            }
            rawMainButton = value
        }
    }
    private var rawMainButton:MainButton?
    var contentView = UIView()
    private let helpGestureView = UIView()
    private var statasBarBackground = UIView()
    private var titleTextLabel = UILabel()
    private var navigationBar = UIView()
    private var backButton = RMTip(icon: "arrow_back")
    private var menuButton = RMTip(icon: "menu")
    //====================================================================
    //method
    func setUpScreen(){
        helpGestureView.frame = CGRect(
            origin: CGPointMake(0, 0),
            size: CGSize(width: 10, height: view.frame.height)
        )
        statasBarBackground.frame = CGRect(
            origin: CGPointMake(0, 0),
            size: CGSize(width: view.frame.width, height: 20)
        )
        navigationBar.frame = CGRect(
            origin: CGPointMake(0, 20),
            size: CGSize(width: view.frame.width, height: 52)
        )
        contentView.frame = CGRect(
            origin: CGPointMake(0, 72),
            size: CGSize(width: view.frame.width, height: view.frame.height-72)
        )
        titleTextLabel.frame = CGRect(
            origin: CGPointMake(80, 14),
            size: CGSize(width: 200, height: 20)
        )
        if rawMainButton != nil{
            setMainButtonPosition(mainButton)
        }
    }
    func setUpSetting(){
        //======================================
        //setting
        helpGestureView.backgroundColor = UIColor.hexStr("", alpha: 0)
        statasBarBackground.backgroundColor = mainColor
        navigationBar.backgroundColor = mainColor
        navigationBar.shadowLevel(2)
        titleTextLabel.textColor = navigationItemColor()
        titleTextLabel.font = main_font(19)
        menuButton.addTarget(self, action: #selector(RMNavigationController.menuButtonTapped), forControlEvents: .TouchUpInside)
        backButton.addTarget(self, action: #selector(RMNavigationController.back), forControlEvents: .TouchUpInside)
        //======================================
        //add
        addButtonLeft(menuButton)
        if navigationController?.viewControllers.count != 1{
            addButtonLeft(backButton)
        }
        navigationBar.addSubview(titleTextLabel)
        view.addSubview(contentView)
        view.addSubview(navigationBar)
        view.addSubview(statasBarBackground)
        view.addSubview(helpGestureView)
    }
    func path(viewController vc:UIViewController){
        navigationController?.pushViewController(vc, animated: true)
    }
    //======================================
    //not recommended
    func addButtonLeft(button:RMTip){
        button.setTitleColor(navigationItemColor(), forState: .Normal)
        self.navigationBarButtonsLeft.append(button)
        self.checkButtonsFromRight(false)
        self.navigationBar.addSubview(button)
    }
    func addButtonRight(button:RMTip){
        button.setTitleColor(navigationItemColor(), forState: .Normal)
        self.navigationBarButtonsRight.append(button)
        self.checkButtonsFromRight(true)
        self.navigationBar.addSubview(button)
    }
    private func checkButtonsFromRight(right:Bool){
        if right {
            for i in 0...navigationBarButtonsRight.count-1{
                let button = navigationBarButtonsRight[navigationBarButtonsRight.count-i-1]
                button.frame.origin.x = view.frame.width-CGFloat((i+1)*48)
            }
        }else{
            for i in 0...navigationBarButtonsLeft.count-1{
                let button = navigationBarButtonsLeft[navigationBarButtonsLeft.count-i-1]
                button.frame.origin.x = CGFloat(i*48)
            }
        }
    }
    private func setMainButtonPosition(button:MainButton?){
        switch button!.position {
        case .lowerRight:
            button?.frame.origin = CGPoint(x: view.frame.width - 75, y: view.frame.height - 75)
        case .lowerLeft:
            button?.frame.origin = CGPoint(x: 15, y: view.frame.height - 75)
        case .lowerCenter:
            button?.frame.origin = CGPoint(x: 0, y: view.frame.height - 75)
            button?.layer.position.x = self.view.layer.position.x
        case .upperRight:
            button?.frame.origin = CGPoint(x: view.frame.width - 75, y: 42)
        case .upperLeft:
            button?.frame.origin = CGPoint(x: 15, y: 42)
        case .upperCenter:
            button?.frame.origin = CGPoint(x: 0, y: 42)
            button?.layer.position.x = self.view.layer.position.x
        }
    }
    //====================================================================
    //private method
    //======================================
    //menuButtonTapped
    func menuButtonTapped(){}
    //======================================
    //back
    func back(){
        navigationController?.popViewControllerAnimated(true)
    }
    //====================================================================
    //viewDidLoad
    override func viewDidLoad() {
        //======================================
        //view setting
        navigationController?.interactivePopGestureRecognizer!.delegate = self
        navigationController?.navigationBarHidden = true
        view.backgroundColor = backColor
        setUpScreen()
        setUpSetting()
    }
    override func viewDidAppear(animated: Bool) {
        mainButton?.animate()
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        view.frame.size = size
        setUpScreen()
    }
}





















