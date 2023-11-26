import random

def numberGuessingGame():
    number = random.randint(1, 100)
    attempts = 0
    maxAttemps = 5

    print("Sayı tahmin etme oyununa hoş geldiniz!")
    print("1 ile 100 arasında bir sayı tuttum bakalım onu bulabilecek misin?")

    while attempts < maxAttemps:
        guess = int(input("Tahmininizi giriniz: "))
        attempts += 1

        if guess < number:
            print("Tuttuğum sayı daha büyük! Tekrar dene")
        elif guess > number:
            print("Tuttuğum sayı daha küçük! Tekrar dene")
        else:
            print(f"Tebrikler! {number} sayısını {attempts} denemede buldun :)")
            break

    else:
        print(f"Maalesef! {maxAttemps} denemenin tamamını kullandın. Tuttuğum sayı {number}.")

numberGuessingGame()