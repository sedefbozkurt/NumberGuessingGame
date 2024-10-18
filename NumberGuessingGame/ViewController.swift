//
//  ViewController.swift
//  NumberGuessingGame
//
//  Created by Sedef Bozkurt on 17.10.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var randomNumber = Int.random(in: 1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guessTextField.delegate = self
        
        // Ekrana dokununca klavye gizlenir
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true) // Klavye gizlendi
    }

    @IBAction func guessButtonTapped(_ sender: UIButton) {
        let guess = Int(guessTextField.text ?? "") ?? 0
        checkGuess(guess)
        
        // resultLabel görünür
        resultLabel.isHidden = false
    }
    
    func checkGuess(_ guess: Int) {
        let generator = UINotificationFeedbackGenerator()
        
        if guess == randomNumber {
            resultLabel.text = "Tebrikler, doğru tahmin!"
            generator.notificationOccurred(.success) // Başarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = UIColor(hex: "#81C784")
            }
            guessTextField.text = ""
        } else if guess > randomNumber {
            resultLabel.text = "Tuttuğum sayı daha küçük! Daha küçük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = .red
            }
        } else {
            resultLabel.text = "Tuttuğum sayı daha büyük! Daha büyük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = UIColor(hex: "#1E90FF")
            }
        }
    }
    
}

