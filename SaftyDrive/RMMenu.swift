import UIKit

class RMMenu: UIViewController,UITableViewDelegate, UITableViewDataSource{
    //====================================================================
    //member
    private let BGview_tap = UITapGestureRecognizer()
    
    var iconArr:[String] = []
    var titleArr:[String] = []
    var actionArr:[()->()] = []
    var completed:()->() = {}
    //======================================
    //Views
    private let BGview = UIView()
    private let tableView = UITableView()
    //====================================================================
    //method
    //====================================================================
    //private method
    @objc private func closeMenu(action:()->()){
        UIView.animateWithDuration(
            0.3,
            delay: 0.1,
            options: .CurveEaseOut,
            animations: {
                self.BGview.backgroundColor = UIColor.hexStr("0", alpha: 0)
                self.tableView.frame.origin.y = self.view.frame.height+self.tableView.frame.size.height
            },
            completion: {(Bool) in
                self.dismissViewControllerAnimated(
                    false,
                    completion: {
                        action()
                        self.completed()
                    }
                )
            }
        )
    }
    @objc private func closeMenuWithNoCompletion(){
        closeMenu({})
    }
    private func openMenu(){
        UIView.animateWithDuration(
            0.3,
            delay: 0.1,
            options: .OverrideInheritedCurve,
            animations: {
                self.BGview.backgroundColor = UIColor.hexStr("0", alpha: 0.6)
                self.tableView.frame.origin.y = self.view.frame.height-self.tableView.frame.size.height
            },
            completion: {(Bool) in}
        )
    }
    private func setUpScreen(){
        BGview.frame.size = view.frame.size
        tableView.frame.size.width = view.frame.width
        tableView.frame.size.height = CGFloat(iconArr.count*53)
        tableView.frame.origin.y = view.frame.size.height-tableView.frame.size.height
    }
    private func setUpSetting(){
        view.backgroundColor = UIColor.hexStr("0", alpha: 0)
        BGview_tap.addTarget(self, action: #selector(RMMenu.closeMenuWithNoCompletion))
        BGview.addGestureRecognizer(BGview_tap)
        BGview.backgroundColor = UIColor.hexStr("0", alpha: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 53
        tableView.frame.origin.y = self.view.frame.height+self.tableView.frame.size.height
        view.addSubview(BGview)
        view.addSubview(tableView)
    }
    //====================================================================
    //delegate method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        closeMenu(actionArr[indexPath.row])
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = MKTableViewCell()
        cell.rippleLayerColor = UIColor.lightGrayColor()
        
        let titleLabel = UILabel()
        titleLabel.frame.size = CGSizeMake(200, 30)
        titleLabel.layer.position = cell.layer.position
        titleLabel.frame.origin.x = 70
        titleLabel.frame.origin.y += 6
        titleLabel.textColor = UIColor.hexStr("555555", alpha: 1)
        titleLabel.text = titleArr[indexPath.row]
        cell.addSubview(titleLabel)
        
        cell.textLabel?.text = iconArr[indexPath.row]
        cell.textLabel?.font = mi_font(24)
        cell.textLabel?.textColor = UIColor.hexStr("555555", alpha: 1)
        return cell
    }
    //====================================================================
    //override method
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
        setUpSetting()
    }
    override func viewDidAppear(animated: Bool) {
        openMenu()
    }
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        view.frame.size = size
        setUpScreen()
    }
}

extension RMMenu{
    class func show(presentintViewController vc: UIViewController,iconArr:[String],titleArr:[String],actionArr:[()->()]) {
        let view = RMMenu()
        view.iconArr = iconArr
        view.titleArr = titleArr
        view.actionArr = actionArr
        view.modalPresentationStyle = .OverCurrentContext
        view.modalTransitionStyle = .CrossDissolve
        
        vc.presentViewController(view, animated: true, completion: nil)
    }
    class func show(presentintViewController vc: UIViewController,iconArr:[String],titleArr:[String],actionArr:[()->()],completed:()->()) {
        let view = RMMenu()
        view.iconArr = iconArr
        view.titleArr = titleArr
        view.actionArr = actionArr
        view.completed = completed
        view.modalPresentationStyle = .OverCurrentContext
        view.modalTransitionStyle = .CrossDissolve
        
        vc.presentViewController(view, animated: true, completion: nil)
    }
}
















