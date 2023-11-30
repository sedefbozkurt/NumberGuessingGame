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
            maxAttempts = 7
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


    print(f"{minNum} ile {maxNum} arasında bir sayı tuttum bakalım onu bulabilecek misin?\n"
          f"Dikkatli ol {maxAttempts} deneme hakkın var.")

    while attempts < maxAttempts:
        guess = int(input("Tahmininizi giriniz: "))
        attempts += 1

        if guess < number:
            if attempts!=maxAttempts:
                print("Tuttuğum sayı daha büyük! Tekrar dene")
        elif guess > number:
            if attempts!=maxAttempts:
                print("Tuttuğum sayı daha küçük! Tekrar dene")
        else:
            print(f"Tebrikler! {number} sayısını {attempts} denemede buldun :)")
            break

    else:
        print(f"Maalesef! {maxAttempts} denemenin tamamını kullandın. Tuttuğum sayı {number}.")

numberGuessingGame()