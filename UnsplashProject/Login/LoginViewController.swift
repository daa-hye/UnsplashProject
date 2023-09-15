//
//  LoginViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var loginButton: UIButton!

    var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        idTextField.addTarget(self, action: #selector(idTextFiledChanged), for: .editingChanged)
        pwTextField.addTarget(self, action: #selector(pwTextFiledChanged), for: .editingChanged)


        viewModel.id.bind { text in
            self.idTextField.text = text
        }

        viewModel.pw.bind { text in
            self.pwTextField.text = text
        }

        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .green : .lightGray
        }

    }

    @objc func idTextFiledChanged() {
        viewModel.id.value = idTextField.text!
        viewModel.checkValidation()
    }

    @objc func pwTextFiledChanged() {
        viewModel.pw.value = idTextField.text!
        viewModel.checkValidation()
    }

    @objc func loginButtonClicked() {

        viewModel.signIn {
            print("로그인 성공했기 때문에 얼럿 띄우기")
        }

    }

    

}
