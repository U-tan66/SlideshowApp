//
//  BiggerImageViewController.swift
//  SlideshowApp
//
//  Created by 小野﨑悠太 on 2021/10/28.
//

import UIKit

class ShowDatailViewController: UIViewController {
    /*——設定する画像について———————————————
    　ViewControllerからクラスが変わるため、
    　そこで設定した配列などは失われる。
    　別ファイルとして管理すれば解消されるが、
    　課題提出時は前の画面からimageを受取る対応をとる。
    ——————————————————————————————————*/
    
    //TODO: 質問→画像の拡大 ※ViewControllerに質問記載
    /*--表示する画像について—————————————————
     切り抜いて表示しても、枠のサイズに合わせて拡大された
     画像が表示されるが、アプリ作成時に画像フェードイン＋拡大しつつ
     スライドショーで表示したい。
     よって、難しいが画像の一部を拡大して表示する方法を採用する
     ——————————————————————————————————*/
    
    @IBOutlet weak var imageDetail: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--▼⑤画面の拡大表示—————————————————
        //imageDetail.image = ViewController.imageArray[ViewController.showingNum]
        //二つの変数をstaticにしたところ、VCクラスの他の同じ変数もstaticが必要になった。
        //　→情報を受け渡す形式にする
        
        imageDetail.image = image //遷移前の画面でimageに画像を格納してある
        //--△⑤画面の拡大表示—————————————————
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
