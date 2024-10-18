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
    @IBOutlet weak var guessButton: UIButton!
    
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
        guessButton.isEnabled = true
        resultLabel.isHidden = true
        attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
        attemptsLabel.backgroundColor = .green
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
        
        // Kalan tahmin hakkını bir azalt
        remainingAttempts -= 1
        updateAttemptsLabel() // Arka plan rengi güncellendi
        
        if guess == randomNumber {
            resultLabel.text = "Tebrikler, doğru tahmin!"
            generator.notificationOccurred(.success) // Başarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = UIColor(hex: "#81C784")
            }
            guessTextField.text = ""
            guessTextField.isEnabled = false
            guessButton.isEnabled = false
            return // Doğru tahmin yapıldığında fonksiyondan çık
            
        } else if guess > randomNumber {
            resultLabel.text = "Tuttuğum sayı daha küçük! Daha küçük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = .red
            }
            shakeTextField()
        } else {
            resultLabel.text = "Tuttuğum sayı daha büyük! Daha büyük bir tahminde bulun"
            generator.notificationOccurred(.warning) // Uyarı titreşimi
            UIView.animate(withDuration: 0.5) {
                self.resultLabel.backgroundColor = UIColor(hex: "#1E90FF")
            }
            shakeTextField() // Sallanma animasyonu eklendi
        }
        
        // Kalan tahmin hakkı sıfır olduğunda oyunu bitir
        if remainingAttempts == 0 {
            showGameOverAlert()
            guessTextField.isEnabled = false
            guessButton.isEnabled = false
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
    
    func updateAttemptsLabel() {
        attemptsLabel.text = "Kalan Tahmin Hakkı: \(remainingAttempts)"
        
        switch remainingAttempts {
        case 5:
            attemptsLabel.backgroundColor = .green
        case 4:
            attemptsLabel.backgroundColor = UIColor(hex: "FABC3F")
        case 3:
            attemptsLabel.backgroundColor = UIColor(hex: "E85C0D")
        case 2:
            attemptsLabel.backgroundColor = UIColor(hex: "C7253E")
        case 1:
            attemptsLabel.backgroundColor = UIColor(hex: "821131")
        default:
            attemptsLabel.backgroundColor = .lightGray
        }
    }
}
