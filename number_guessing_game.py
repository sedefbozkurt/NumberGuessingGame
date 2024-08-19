import random

def chooseDifficulty():
    while True:
        print("Zorluk seviyesini seçin:")
        print("1. Kolay (1-50)")
        print("2. Orta (1-100)")
        print("3. Zor (1-200)")
        choice = input("Seçiminizi giriniz (1-3): ")

        if choice in ['1', '2', '3']:
            return int(choice)
        else:
            print("Geçersiz seçim. Lütfen 1-3 aralığında bir seçim yapınız!")

def getGuess(minNum, maxNum):
    while True:
        try:
            guess = int(input(f"Tahmininizi {minNum}-{maxNum} aralığında giriniz: "))
            if minNum <= guess <= maxNum:
                return guess
            else:
                print(f"Lütfen {minNum}-{maxNum} aralığında bir sayı giriniz.")
        except ValueError:
            print("Geçersiz giriş. Sayısal bir değer giriniz.")

def numberGuessingGame():
    print("Sayı tahmin etme oyununa hoş geldiniz!")

    while True:
        difficulty = chooseDifficulty()
        if difficulty == 1:
            minNum, maxNum = 1, 50
        elif difficulty == 2:
            minNum, maxNum = 1, 100
        elif difficulty == 3:
            minNum, maxNum = 1, 200

        number = random.randint(minNum, maxNum)
        maxAttempts = 5
        playerScore = 100

        print(f"{minNum} ile {maxNum} arasında bir sayı tuttum bakalım onu bulabilecek misin?
            Dikkatli ol {maxAttempts} deneme hakkın var.")

        for attempts in range(maxAttempts):
            guess = getGuess(minNum, maxNum)
            if guess < number:
                print("Tuttuğum sayı daha büyük! Tekrar dene.")
                playerScore -= 20
            elif guess > number:
                print("Tuttuğum sayı daha küçük! Tekrar dene.")
                playerScore -= 20
            else:
                print(f"Tebrikler! {number} sayısını {attempts + 1} denemede buldun :)")
                break
        else:
            print(f"Maalesef! {maxAttempts} denemenin tamamını kullandın. Tuttuğum sayı {number}.")
        
        print(f"Oyun bitti. Toplam puanınız: {playerScore}")

        decision = input("Tekrar denemek ister misiniz? (Evet/Hayır): ").capitalize()
        if decision != "Evet":
            print("Oyun bitti. İyi günler!")
            break

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

if __name__ == "__main__":
    numberGuessingGame()