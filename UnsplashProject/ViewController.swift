//
//  ViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!

    @IBOutlet var changeButton: UIButton!

    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//        nicknameTextField.placeholder = "nickname_placeholder".localized

//        let value = NSLocalizedString("nickname_result", comment: "")
//        resultLabel.text = String(format: value, "봉식이", "흠")

        //resultLabel.text = "age_result".localized(number: 17)


    }

    override func viewDidAppear(_ animated: Bool) {

    }

    override func viewDidDisappear(_ animated: Bool) {

    }

    override func viewWillAppear(_ animated: Bool) {

    }

}

