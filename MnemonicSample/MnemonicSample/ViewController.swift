//
//  ViewController.swift
//  MnemonicSample
//
//  Created by hanwe on 2022/03/29.
//

//http://wiki.hash.kr/index.php/BIP39

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let test = MnemonicModule()
        let some = test.genMnemonics(.bits128)
        print("some : \(some)")
    }


}

