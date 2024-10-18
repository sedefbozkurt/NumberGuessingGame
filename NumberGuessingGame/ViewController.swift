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
    @IBOutlet weak var attemptsLabel: UILabel!
    
    var randomNumber = Int.random(in: 1...100)
    
    var remainingAttempts = 5 // Kalan tahmin hakkı
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Başlangıç tahmin etme hakkı
        attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
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
            remainingAttempts -= 1 // Tahmin hakkı bir azaltıldı
            attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
            resultLabel.text = "Tuttuğum sayı daha küçük! Daha küçük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = .red
            }
        } else {
            remainingAttempts -= 1 // Tahmin hakkı bir azaltıldı
            attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
            resultLabel.text = "Tuttuğum sayı daha büyük! Daha büyük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = UIColor(hex: "#1E90FF")
            }
        }
        
        if remainingAttempts == 0 {
            // Tahmin hakkı bittiğinde uyarı ver
            showGameOverAlert()
        }
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Oyun Bitti", message: "Tahmin hakların bitti!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Tekrar Oyna", style: .default) { _ in
            //self.resetGame()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

