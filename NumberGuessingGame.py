import random

def numberGuessingGame():
    print("Sayı tahmin etme oyununa hoş geldiniz!")
    print("Zorluk seviyesini seçin \n"
          "1. Kolay (1-50)\n"
          "2. Orta (1-100)\n"
          "3. Zor (1-200)")

    while True:
        choice = input("Seçiminizi giriniz (1-3): ")

        attempts = 0
        minNum = 1
        if choice == '1':
            maxNum = 50
            number = random.randint(minNum, maxNum)
            maxAttempts = 5
            break
        elif choice == '2':
            maxNum = 100
            number = random.randint(minNum, maxNum)
            maxAttempts = 5
            break
        elif choice == '3':
            maxNum = 200
            number = random.randint(minNum, maxNum)
            maxAttempts = 5
            break
        else:
            print("Geçersiz seçim. Lütfen 1-3 aralığında bir seçim yapınız!")
    
    # Başlangıç puanı
    playerScore = 100

    print(f"{minNum} ile {maxNum} arasında bir sayı tuttum bakalım onu bulabilecek misin?\n"
          f"Dikkatli ol {maxAttempts} deneme hakkın var.")

    while attempts < maxAttempts:
        guess = int(input("Tahmininizi giriniz: "))
        attempts += 1

        if guess < number:
            if attempts!=maxAttempts:
                print("Tuttuğum sayı daha büyük! Tekrar dene")
            playerScore -= 20

        elif guess > number:
            if attempts!=maxAttempts:
                print("Tuttuğum sayı daha küçük! Tekrar dene")
            playerScore -= 20

        else:
            print(f"Tebrikler! {number} sayısını {attempts} denemede buldun :)")
            break


    else:
        print(f"Maalesef! {maxAttempts} denemenin tamamını kullandın. Tuttuğum sayı {number}.")

    
    print(f"Oyun bitti. Toplam puanınız: {playerScore}")
    return PlayAgain()


def PlayAgain():
    while True:
        decision = input("Tekrar denemek ister misiniz? (Evet/Hayır): ").capitalize()
        if decision == "Evet":
            return numberGuessingGame()
        elif decision == "Hayır":
            print("Oyun bitti. İyi günler!")
            break
        else:
            print("Lütfen geçerli bir değer giriniz (Evet/Hayır): ")

numberGuessingGame()