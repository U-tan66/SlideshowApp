//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 小野﨑悠太 on 2021/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: 実装手順
    /*--実装手順 —————————————————
     ①imageViewに画像を表示してみる
     ②配列にして任意の番号表示
     　※タイマーの設定もする
     ③戻る、進むを実装
     ④再生・停止を実装　→②のタイマー設定時に実装済み
    　　※③のボタン押下不可にする
    　　※再生中は停止、停止中は再生
     ⑤拡大表示の実装
     　※タイマーも無効化
     課題提出後…ボタンの色をコードで変更し、押下
     —————————————————*/
    
    @IBOutlet weak var showLastButton: UIButton!
    @IBOutlet weak var showNextButton: UIButton!
    @IBOutlet weak var stopOrGo: UIButton!
    @IBOutlet weak var slideShow: UIImageView!
    //MARK: グローバル変数
    //画像の変数
    var going = false //スライド中かどうかを取得
    var imageArray: Array<UIImage> = []
    var countImage = 0 //登録されている画像の枚数を取得 課題用には3で良い
    var showingNum = 0 //④これから表示する番号にしたいので、受動態から変更
    //タイマーの変数
    var timer: Timer!
    var timer_sec: Int = 0 //余りを計算したいのでInt
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // --▼①画像を表示…—————————————————
        //let showedImage = UIImage(named: "Watermelon0.jpeg")
        //slideShow.image = showedImage
        // --△①画像を表示 —————————————————
        
        // --▼②配列の画像表示…—————————————————
        getImage() //画像の配列にデータを格納
        countImage = imageArray.count
        //TODO: 課題提出後→画像の枚数が0ならメッセージ表示して終了
        
        //TODO: 課題提出後→スタート用に設定した画像を表示したい
        slideShow.image = imageArray[0]
        
        // --△②配列の画像表示 —————————————————
        
        // --▼④再生中のボタン無効化—————————————————
        //TODO: 質問→viewDidLoadは画面がロードされた瞬間だけ?
        //  →ステータス管理は機能として呼びだす仕様に変更
        //showLastButton.isEnabled = !going
        //showNextButton.isEnabled = !going
        buttonStatus()  //
        /*再生中のステータス管理にboolを使ったら、思いがけずラクになった。
        　on/offにboolを使うやり方はちょっと覚えておきたい */
        // --△④再生中のボタン無効化—————————————————
    }
    
    //MARK: 画面内の処理
    @IBAction func pushGo(_ sender: Any) {
        
        // --▼②配列の画像表示…—————————————————
        going.toggle() //1回目の押下でfalse→true
        buttonStatus() //
        if going{  //goingがtrueならshowImage
            timeGoing()
        } else {
            self.timer.invalidate() //「無効にする」
            //示していたイメージはそのまま表示
        }
        // --△②配列の画像表示 —————————————————
    }

    @IBAction func showLast(_ sender: Any) {
        // --▼③戻る、進むを実装—————————————————
        showingNum = (showingNum + countImage - 2) % countImage //showImage()で+1して表示するため、-2とする
        // (-2)%3=-2のため、countImageを足して正にする
          //showingNum+1を画像表示前としたため、-1に変更
        showTheImage()
        //TODO: 質問→showLast,showNextを-1,+1で取得し1つの機能で実装する記法と、案２の実装方法のヒント
        //案１．押下されたボタン名称でif/else またはcase
        //案２．ボタンの名称か引数に-1などを設定
    
        //TODO: ✅課題提出後→ボタンの色なども非活性の表現にしたい
        //  →isEnableで自動調整された
        
        //TODO: 課題提出後→ボタンを見やすく→https://qiita.com/bu-ka/items/afda427e8dbe03e8e3a2
        // --△③戻る、進むを実装—————————————————
    }
    
    @IBAction func showNext(_ sender: Any) {
        // --▼③戻る、進むを実装—————————————————
        showTheImage()
        // --△③戻る、進むを実装—————————————————
    }
    
    
    @objc func updateTimerAndImage(_ timer: Timer){
        //-- ▼②タイマーの設定 —————————————————
        self.timer_sec += 1 //timeIntervalの1秒ごとにインクリメント
        showImages()
        //-- △②タイマーの設定 —————————————————
    }
    
    func getImage(){
        // --▼②配列に画像を格納…—————————————————
        //TODO: 課題提出後→別ファイルを参照するなどして一括取得したい
        //TODO: 質問→リリースするなら、Azure以外ではどのような形式が良いか?
        //　　　 リリースアプリの一部で使う際の要件としては、以下を検討している
        // (1)家族内のみのドメスティックなSNSを作りたいが、
        //   曽祖父母など携帯に慣れないユーザー用にこの画面を使用する
        //　　※アプリ拡散用にInstagramやTwitterへの外部連携機能もつける
        // (2)データ保存・共有方法は、サーバーコストを考え以下とする
        //　　　①当初リリースでは端末内で全idについて写真以外の情報を格納し、
        //　　　　対象権限の写真のうちダウンロード未完の差分のみダウンロードする
        //　　　②後でリリースする有料版使用時は、
        //　　　　Wifi接続時にサーバーから都度読込んで表示できる設定も用意
        
        imageArray.append(UIImage(named:"Watermelon0.jpeg")!)
        imageArray.append(UIImage(named:"Watermelon1.jpeg")!)
        imageArray.append(UIImage(named:"Watermelon2.jpeg")!)
        // --△②配列に画像を格納 —————————————————
    }
    
    func timeGoing(){
        //-- ▼②タイマーの設定 —————————————————
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerAndImage(_:)), userInfo: nil, repeats: true)
        //-- △②タイマーの設定 —————————————————
    }
    
    func showImages(){
        // --▼②配列の画像表示 —————————————————
        if (self.timer_sec % 2) == 0{
            //slideShow.image = imageArray[showedNum]
            //showedNum = (showedNum + 1) % countImage
            showTheImage() //④のボタンと、アニメーションをつけるため別機能に
        }
        // --△②配列の画像表示 —————————————————
    }
    
    func showTheImage(){
        showingNum = (showingNum + 1) % countImage
        slideShow.image = imageArray[showingNum]
        // TODO: 課題提出後→表示画像に、ランダムでアニメーションをつける
        //透明度0→100、数％だけ拡大しながら表示、動く方向
        //もし顔が認識できるようになったら、顔を拡大していく
    }
    
    func buttonStatus(){
        showLastButton.isEnabled = !going
        showNextButton.isEnabled = !going
        if going{
            stopOrGo.setTitle("停止", for: .normal)
        } else {
            stopOrGo.setTitle("開始", for: .normal)
        }
        
    }
    
    //MARK: 画面遷移の処理
    /*
    @IBAction func tapImageView(_ sender: Any) {
        //--▼⑤拡大表示の実装—————————————————
        //TODO: 時間を止め、スライドも一時停止
        self.timer.invalidate()
        going = false
        //--△⑤拡大表示の実装—————————————————
    }
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //--▼⑤拡大表示の実装—————————————————
        self.timer.invalidate()
        going = false
        
        let showDetailViewController: ShowDatailViewController = segue.destination as! ShowDatailViewController
        showDetailViewController.image = imageArray[showingNum]
        //画像表示直後の時点で、次の数値を用意しているので-1
        //--△⑤拡大表示の実装—————————————————
    }
    
    @IBAction func goBack(_ segue: UIStoryboardSegue){
        //次画面からExitで戻った時の処理を入れる機能
        //--▼⑤拡大表示の実装—————————————————
        going = false //念の為、戻った時もfalseの設定に。
        buttonStatus()
        
        //TODO: 質問→画像の拡大表示は未実装 アニメーションをつけて画像を表示させる方法は?
        //最終章の課題提出時、スライドショーはアニメーションで拡大+透過度100→0%にさせつつ表示させたい
        //初期表示か何かで"animated"の引数があったように思うが、
        //この辺りでフェードインのような効果をつけられるか。
        //それとも、拡大した状態の画像と繋げるような実装をする必要があるか
        //--△⑤拡大表示の実装—————————————————
    }
    
}

