//
//  ViewController.swift
//  NumberGuessingGame
//
//  Created by Sedef Bozkurt on 17.10.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    
    var randomNumber: Int = 0
    var remainingAttempts = 5 // Kalan tahmin hakkı
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Başlangıç tahmin etme hakkı
        startNewGame()
        
        // Ekrana dokununca klavye gizlenir
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func startNewGame() {
        randomNumber = Int.random(in: 1...100)
        remainingAttempts = 5
        guessTextField.text = ""
        guessTextField.isEnabled = true
        resultLabel.isHidden = true
        attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
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
            guessTextField.isEnabled = false
        } else if guess > randomNumber {
            remainingAttempts -= 1 // Tahmin hakkı bir azaltıldı
            attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
            resultLabel.text = "Tuttuğum sayı daha küçük! Daha küçük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = .red
            }
            shakeTextField()
        } else {
            remainingAttempts -= 1 // Tahmin hakkı bir azaltıldı
            attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
            resultLabel.text = "Tuttuğum sayı daha büyük! Daha büyük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = UIColor(hex: "#1E90FF")
            }
            shakeTextField() // Sallanma animasyonu eklendi
        }
        
        if remainingAttempts == 0 {
            // Tahmin hakkı bittiğinde uyarı ver
            showGameOverAlert()
            guessTextField.isEnabled = false
            
        }
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "Oyun Bitti", message: "Tahmin hakların bitti! Tuttuğum sayı: \(randomNumber)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        startNewGame()
    }
    
    func shakeTextField() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: guessTextField.center.x - 11, y: guessTextField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: guessTextField.center.x + 11, y: guessTextField.center.y))
        guessTextField.layer.add(animation, forKey: "position")
    }
}
