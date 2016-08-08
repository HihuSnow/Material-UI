import UIKit

class MainViewController: RMNavigationController{
    //====================================================================
    //member
    private let searchButton = MainButton(icon: "search", position: .lowerRight, animationStyle: .pop)
    //====================================================================
    //method
    func moreButtomTapped(){
        RMMenu.show(
            presentintViewController: self,
            iconArr: ["watch","check_circle","crop_free","phone_iphone","phone_android","timer"],
            titleArr: ["About LIFT","Agree","Free","Buy Apple Products","Buy Android","Timer"],
            actionArr: [
                {
                   RMAlert.show(
                    presentintViewController: self,
                    title: "LIFT",
                    message: "スマートウォッチを充電する時はケーブルで机の上がゴチャゴチャしてしまうもの。そこで、「スマートウォッチを宙に浮かべる」という方法で極限まで充電時の光景をスッキリさせてしまったのがワイヤレスチャージャーの「LIFT」です。スマートウォッチだけでなくスマートフォンのワイヤレス充電器も兼ねており、さらに充電器とて使わない時は「宙に浮かぶランプ」としての使用もできるアイテムになっています。"
                    ) 
                },
                {RMAlert.show(presentintViewController: self,title: "利用規約", message: "YouTubeのウェブサイトまたはYouTubeのウェブサイト上で、ウェブサイトを通じて、もしくはウェブサイトから提供されるYouTubeの製品、ソフトウェア、データフィード及びサービス（以下、総称して「本サービス」といいます。）を利用又は訪問することにより、お客様は、(1) 本書に記載される規約 (以下「本サービス条件」といいます。)、(2) https://www.youtube.jp/t/privacyに記載されており、ここに参照され本サービス条件の一部を構成するYouTubeのプライバシーポリシー、及び(3) https://www.youtube.jp/t/community_guidelinesに記載されており、同様に、ここに参照され本サービス条件の一部を構成するYouTubeのコミュニティガイドラインに同意するものとします。お客様が本書に記載される規約、YouTubeのプライバシーポリシーまたはコミュニティガイドラインに同意しない場合には、YouTubeウェブサイトをご利用にならないで下さい。本サービスは、YouTube LLCにより提供され、 本サービス条件においては、YouTube LLC並びにその製品及びサービスを共にYouTubeといいます。\nYouTubeは、これら本サービス条件に重大な変更がなされた場合には、お客様にその旨通知するよう試みることもありますが、お客様は、定期的に、最新版(https://www.youtube.jp/t/terms)をご確認下さい。YouTubeは、その単独の裁量により、これら本サービス条件及び諸ポリシーをいつでも修正又は改訂することができ、お客様は、それら修正又は改訂に拘束されることに同意します。本サービス規約は、第三者に属する権利又は利益を付与するものとはみなされません。",
                    completion: {}
                    )},
                {
                    let alert = RMAlert()
                    alert.show(
                        presentintViewController: self,
                        title: "Free Button",
                        message: "自由な名前とアクションのボタンを置くことができます。ただしボタンの文字は大文字になります。",
                        style: .Message,
                        buttonStyle: .Custom,
                        cellItems: [],
                        cellActions: [],
                        completion: {}
                    )
                    alert.buttonsView.addButton("CLOSE", action: {alert.CloseAlert({})})
                    alert.buttonsView.addButton("MOVE", action: {})
                },
                {RMAlert.show(presentintViewController: self,title: "一番欲しいのは？",style: .CheckItem_single,
                    cellItems: [
                        "iPhone",
                        "iPad",
                        "iPod touch",
                        "iPod",
                        "iMac",
                        "macBook Air",
                        "macBook",
                        "macBook Pro",
                        "Apple Watch"
                    ],cellActions: [
                        {},{},{},{},{}
                    ]
                    )},
                {RMAlert.show(presentintViewController: self,title: "欲しいものを選んでください。",style: .CheckItem_mulch,cellItems: [
                    "Mono",
                    "Galaxy",
                    "AQUOS",
                    "arrows",
                    "Blade",
                    "P9"
                    ],cellActions: [
                        {},{},{},{},{}
                    ]
                    )},
                {RMAlert.show(presentintViewController: self,title: "タイマー",cellItems: [
                    "12:00",
                    "11:00",
                    "10:00",
                    "9:00",
                    "8:00"
                    ],cellActions: [
                        {},{},{},{},{}
                    ]
                    )}
            ]
        )
    }
    override func menuButtonTapped(){
        if let sideDrawerViewController = self.sideDrawerViewController {
            sideDrawerViewController.toggleDrawer()
        }
    }
    //====================================================================
    //オーバーライドメソッド
    override func setUpScreen(){
        super.setUpScreen()
    }
    override func setUpSetting() {
        //======================================
        //setting
        super.setUpSetting()
        mainButton = searchButton
        let moreButtom = RMTip(icon: "more_vert")
        moreButtom.addTarget(self, action: #selector(MainViewController.moreButtomTapped), forControlEvents: .TouchUpInside)
        addButtonRight(moreButtom)
        
    }
}


























