import UIKit

enum RMAlertStyle {
    case Message
    case Select
    case CheckItem_single
    case CheckItem_mulch
    case Custom
}

enum RMAlertButtonStyle {
    case ButtonSet_1
    case ButtonSet_2
    case Custom
    case None
}

class RMAlert: UIViewController {
    private var message = ""
    private var alertTitle = ""
    private var completion:()->() = {}
    private var buttonStyle = RMAlertButtonStyle.ButtonSet_1
    private var style = RMAlertStyle.Message
    private var cellItems:[String] = []
    private var cellActions:[()->()] = []
    private var centerContentsSize = CGSize()
    
    private var BGView = UIView()
    private var contentsView = UIView()
    private var titleLabel = UILabel()
    private var messageView = UITextView()
    private var tableView = RMAlertTableView()
    var buttonsView = RMAlertButtonsView()
    private var contentSize = CGSizeMake(260, 190)
    private var upperSeparater = Separator(width: 260)
    private var lowerSeparater = Separator(width: 260)
    
    func addButton(name:String,action:()->()){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            dispatch_async(dispatch_get_main_queue(), {
                self.buttonsView.addButton(name, action: {self.CloseAlert({});action()})
            });
        });
    }
    private func setUpSetting(){
        self.view.alpha = 0
        BGView.backgroundColor = UIColor.hex(0, alpha: 0.6)
        
        contentsView.backgroundColor = backColor
        contentsView.frame.size = contentSize
        contentsView.shadowLevel(24)
        contentsView.radiusLevel(2)
        
        titleLabel.frame.size = CGSizeMake(contentSize.width-dp(48), 17)
        titleLabel.frame.origin = CGPointMake(dp(24), dp(24))
        titleLabel.text = alertTitle
        titleLabel.font = main_font_bold(17)
        
        switch style {
        case .Message:
            messageView.frame.size = CGSizeMake(contentSize.width-dp(48), 100)
            messageView.frame.origin = CGPointMake(dp(24), titleLabel.buttomY+dp(20))
            messageView.textColor = subTextColor
            messageView.noPadding()
            messageView.backgroundColor = UIColor.hexStr("", alpha: 0)
            messageView.font = main_font(16)
            messageView.textAlignment = .Left
            messageView.showsVerticalScrollIndicator = false
            messageView.scrollEnabled = false
            messageView.selectable = false
            messageView.editable = false
            messageView.text = message
            messageView.sizeToFit()
            if messageView.frame.height < 70 {
                messageView.frame.size.height = 70
            }
            centerContentsSize = messageView.frame.size
            if messageView.frame.height>345 {
                messageView.frame.size.height = 345
                centerContentsSize = messageView.frame.size
                messageView.frame.size.height+=dp(24)
                messageView.scrollEnabled = true
                upperSeparater.frame.origin.y = messageView.frame.origin.y
                lowerSeparater.frame.origin.y = messageView.buttomY
                contentsView.addSubview(upperSeparater)
                contentsView.addSubview(lowerSeparater)
                buttonsView.frame.origin.y = messageView.buttomY
            }else{
                buttonsView.frame.origin.y = messageView.buttomY+dp(24)
            }
            contentsView.addSubview(messageView)
        case .Select,.CheckItem_single,.CheckItem_mulch:
            tableView.AlertStyle = style
            tableView.frame.size = CGSizeMake(contentSize.width, 100)
            tableView.frame.origin = CGPointMake(0, titleLabel.buttomY+dp(20))
            tableView.backgroundColor = UIColor.hexStr("", alpha: 0)
            tableView.scrollEnabled = false
            tableView.showsVerticalScrollIndicator = false
            tableView.actions = cellActions
            tableView.items = cellItems
            tableView.reloadData()
            if tableView.frame.height < 70 {
                tableView.frame.size.height = 70
            }
            if tableView.frame.height>339 {
                tableView.scrollEnabled = true
                tableView.frame.size.height = 340
                centerContentsSize = messageView.frame.size
                upperSeparater.frame.origin.y = tableView.frame.origin.y
                lowerSeparater.frame.origin.y = tableView.buttomY
                contentsView.addSubview(upperSeparater)
                contentsView.addSubview(lowerSeparater)
                buttonsView.frame.origin.y = tableView.buttomY
            }else{
                buttonsView.frame.origin.y = tableView.buttomY+dp(24)
            }
            
            contentsView.addSubview(tableView)
            centerContentsSize.height = tableView.frame.height-dp(24)
            buttonsView.frame.origin.y = tableView.buttomY
        case .Custom:
            break
        }
        buttonsView.frame.size.width = contentsView.frame.width
        buttonsView.frame.size.height = dp(52)
        switch buttonStyle {
        case .ButtonSet_1:
            buttonsView.addButton("OK", action: {self.CloseAlert({})})
        case .ButtonSet_2:
            buttonsView.addButton("OK", action: {self.CloseAlert({})})
            buttonsView.addButton("CANCEL", action: {self.CloseAlert({})})
        case .None:
            lowerSeparater.removeFromSuperview()
            buttonsView.frame.size.height = 0
        case .Custom:
            break
        }
        contentsView.frame.size.height = dp(65)+titleLabel.frame.height+centerContentsSize.height+buttonsView.frame.size.height
        contentsView.addSubview(buttonsView)
        contentsView.addSubview(titleLabel)
        view.addSubview(BGView)
        view.addSubview(contentsView)
    }
    func CloseAlert(action:()->()){
        UIView.animateWithDuration(
            0.3,
            animations: {self.view.alpha = 0},
            completion: {(Bool) in
                self.dismissViewControllerAnimated(false, completion: {action();self.completion()})
            }
        )
    }
    private func setUpScreen(){
        BGView.frame = view.frame
        contentsView.layer.position = view.layer.position
    }
    
    override func viewDidLoad() {
        setUpSetting()
        setUpScreen()
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(
            0.3,
            animations: {self.view.alpha = 1}
        )
    }
}
extension RMAlert{
    //======================================
    //call from instance Master
    func show(
        presentintViewController vc: UIViewController,
                                 title:String,
                                 message:String,
                                 style:RMAlertStyle,
                                 buttonStyle:RMAlertButtonStyle,
                                 cellItems:[String],
                                 cellActions:[()->()],
                                 completion:()->()
        ){
        self.alertTitle = title
        self.message = message
        self.buttonStyle = .Custom
        self.style = style
        self.completion = completion
        modalPresentationStyle = .OverCurrentContext
        modalTransitionStyle = .CrossDissolve
        vc.presentViewController(self, animated: true, completion: {})
    }
    //======================================
    //Master
    class func show(
        presentintViewController vc: UIViewController,
                                 title:String,
                                 message:String,
                                 style:RMAlertStyle,
                                 buttonStyle:RMAlertButtonStyle,
                                 cellItems:[String],
                                 cellActions:[()->()],
                                 completion:()->()
        ){
        let alert = RMAlert()
        alert.alertTitle = title
        alert.message = message
        alert.buttonStyle = buttonStyle
        alert.completion = completion
        alert.style = style
        alert.cellItems = cellItems
        var cellAction_temp:[()->()] = []
        for action in cellActions{
            cellAction_temp.append({
                UIView.animateWithDuration(
                    0.3,
                    animations: {alert.view.alpha = 0},
                    completion: {(Bool) in
                        alert.dismissViewControllerAnimated(false, completion: {action()})
                    }
                )
            })
        }
        alert.cellActions = cellAction_temp
        alert.modalPresentationStyle = .OverCurrentContext
        alert.modalTransitionStyle = .CrossDissolve
        vc.presentViewController(alert, animated: false, completion: {})
    }
    //======================================
    //show OK Button
    class func show(presentintViewController vc: UIViewController,title:String,message:String){
        RMAlert.show(
            presentintViewController: vc,
            title: title,
            message: message,
            style: .Message,
            buttonStyle: .ButtonSet_1,
            cellItems: [],
            cellActions: [],
            completion: {}
        )
    }
    //======================================
    //show OK and Cancel Button
    class func show(presentintViewController vc: UIViewController,title:String,message:String,completion:()->()){
        RMAlert.show(
            presentintViewController: vc,
            title: title,
            message: message,
            style: .Message,
            buttonStyle: .ButtonSet_2,
            cellItems: [],
            cellActions: [],
            completion: completion
        )
    }
    //======================================
    //show Select
    class func show(presentintViewController vc: UIViewController,title:String,cellItems:[String],cellActions:[()->()]){
        RMAlert.show(
            presentintViewController: vc,
            title: title,
            message: "",
            style: .Select,
            buttonStyle: .None,
            cellItems: cellItems,
            cellActions: cellActions,
            completion: {}
        )
    }
    //======================================
    //show CheckBox
    class func show(presentintViewController vc: UIViewController,title:String,style:RMAlertStyle,cellItems:[String],cellActions:[()->()]){
        RMAlert.show(
            presentintViewController: vc,
            title: title,
            message: "",
            style: style,
            buttonStyle: .ButtonSet_2,
            cellItems: cellItems,
            cellActions: cellActions,
            completion: {}
        )
    }
}

class RMAlertButtonsView:UIView{
    private var buttons:[MKButton] = []
    private var actions:[()->()] = []
    
    func addButton(name:String,action:()->()){
        let button = MKButton()
        button.setTitle(name, forState: .Normal)
        button.setTitleColor(mainColor, forState: .Normal)
        button.titleLabel?.font = main_font_midium(17)
        button.sizeToFit()
        button.radiusLevel(2)
        button.frame.size.height=dp(36)
        button.frame.size.width+=dp(16)
        if button.frame.width < dp(64) {
            button.frame.size.width = dp(64)
        }
        button.addTarget(self, action: #selector(RMAlertButtonsView.buttonTapped(_:)), forControlEvents: .TouchUpInside)
        var position = dp(8)
        for button in buttons{
            position+=button.frame.width+dp(8)
        }
        buttons.append(button)
        actions.append(action)
        position+=button.frame.width
        button.frame.origin.x =  self.frame.size.width-position
        button.frame.origin.y = dp(8)
        addSubview(button)
    }
    func buttonTapped(sender: MKButton) {
        let count = buttons.indexOf(sender)!
        actions[count]()
    }
}
protocol RMAlertTableViewDelegate {
    func cellTapped(row:Int)
}

class RMAlertTableView:UITableView, UITableViewDelegate, UITableViewDataSource{
    var items:[String] = []
    var actions:[()->()] = []
    var AlertStyle = RMAlertStyle.Select
    var singleSelectedBoxIndex = 0
    
    
    init(){
        super.init(frame: CGRectZero, style: .Plain)
        self.delegate = self
        self.dataSource = self
        
        separatorStyle = .None
        rowHeight = 53
    }
    
    func singleSelectedBox(index:Int){
        singleSelectedBoxIndex = index
        reloadData()
    }
    //select
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        actions[indexPath.row]()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if CGFloat(items.count*53)<340 {
            self.frame.size.height = CGFloat(items.count*53)
        }else{
            self.frame.size.height = 340
        }
        
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = MKTableViewCell(style: .Default, reuseIdentifier: "myCell")
        cell.rippleLayerColor = UIColor.hexStr("eeeeee", alpha: 1)
        let textLabel = UILabel()
        textLabel.frame.size.height = 17
        textLabel.font = main_font(16)
        textLabel.textColor = textColor
        textLabel.frame.size.width = cell.frame.width
        textLabel.frame.origin.x = dp(24)
        textLabel.layer.position.y = cell.layer.position.y
        textLabel.frame.origin.y+=4
        textLabel.text = items[indexPath.row]
        switch AlertStyle {
        case .CheckItem_single:
            let box = CheckBox(style: .single)
            box.index = indexPath.row
            if indexPath.row == singleSelectedBoxIndex {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                    dispatch_async(dispatch_get_main_queue(), {
                        box.setSelects(true)
                    });
                });
            }else{
                box.setSelects(false)
            }
            box.layer.position.y = textLabel.layer.position.y
            box.frame.origin.x += 6
    
            box.valueChanged = singleSelectedBox
            cell.addSubview(box)
            textLabel.frame.origin.x = box.frame.size.width+box.frame.origin.y+10
        case .CheckItem_mulch:
           let box = CheckBox(style: .mulch)
           box.layer.position.y = textLabel.layer.position.y
           box.frame.origin.x += 6
           cell.addSubview(box)
           textLabel.frame.origin.x = box.frame.size.width+box.frame.origin.y+10
        default:
            break
        }
        
        switch AlertStyle {
        case .Select:
            break
        default:
            break
        }
        
        cell.backgroundColor = UIColor.hex(0, alpha: 0)
        cell.addSubview(textLabel)
        return cell
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
enum RMCheckBoxStyle {
    case single
    case mulch
}
class CheckBox: RMTip {
    private let singleCenter = UIView()
    private let singleBorder = UIView()
    var select = false
    var valueChanged:(Int)->() = {(Int)in}
    var index = 0
    
    var style:RMCheckBoxStyle?
    func setSelects(to:Bool){
        if to {
            self.singleCenter.transform =  CGAffineTransformMakeScale(0, 0)
            self.singleBorder.layer.borderColor = subTextColor.CGColor
            UIView.animateWithDuration(
                0.2,
                delay: 0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    self.singleCenter.transform =  CGAffineTransformMakeScale(1, 1)
                    self.singleBorder.layer.borderColor = mainColor.CGColor
                },
                completion: {(Bool) in}
            )
        }else{
            self.singleCenter.transform =  CGAffineTransformMakeScale(1, 1)
            self.singleBorder.layer.borderColor = mainColor.CGColor
            UIView.animateWithDuration(
                0.2,
                delay: 0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    self.singleCenter.transform =  CGAffineTransformMakeScale(0, 0)
                    self.singleBorder.layer.borderColor = subTextColor.CGColor
                },
                completion: {(Bool) in}
            )
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if style == .mulch {
            select = !select
            if select {
                setTitle("check_box", forState: .Normal)
                setTitleColor(mainColor, forState: .Normal)
            }else{
                setTitle("check_box_outline_blank", forState: .Normal)
                setTitleColor(subTextColor, forState: .Normal)
            }
        }
        valueChanged(index)
    }
    var defaultSelect = false
    private var rawSelect = false
    init(style:RMCheckBoxStyle){
        super.init(icon: "")
        rippleLayerColor = accentColor
        self.style = style
        switch style {
        case .single:
            singleCenter.frame.size = CGSizeMake(9, 9)
            singleCenter.radiusLevel(4.5)
            singleCenter.backgroundColor = mainColor
            singleCenter.layer.position = self.layer.position
            
            singleBorder.frame.size = CGSizeMake(21, 21)
            singleBorder.radiusLevel(10.5)
            singleBorder.layer.borderWidth = 3
            singleBorder.layer.position = self.layer.position
            
            addSubview(singleCenter)
            addSubview(singleBorder)
        case .mulch:
            setTitle("check_box_outline_blank", forState: .Normal)
            setTitleColor(subTextColor, forState: .Normal)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}












