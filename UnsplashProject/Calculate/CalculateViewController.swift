//
//  CalculateViewController.swift
//  UnsplashProject
//
//  Created by 박다혜 on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!

    @IBOutlet var tempLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)

        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
        }

        viewModel.secondNumber.bind { number in
            self.secondTextField.text = number
        }

        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }

        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
    }

    @objc func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calulate()
        viewModel.presentNumberFormat()
    }

    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calulate()
    }

}

/*
 let person = Person("새싹")

 person.name = "봉식"
 person.name = "무민"

 person.introduce { value in
     self.resultLabel.text = value
     self.view.backgroundColor = [UIColor.orange, UIColor.red, UIColor.blue, UIColor.gray].randomElement()
 }

 DispatchQueue.main.asyncAfter(deadline: .now()+1) {
     person.name = "진라면"
     print("1초뒤")
 }

 DispatchQueue.main.asyncAfter(deadline: .now()+3) {
     person.name = "뽀글이"
     print("3초뒤")
 }

 firstTextField.text = viewModel.firstNumber.value
 secondTextField.text = viewModel.secondNumber.value
 */
