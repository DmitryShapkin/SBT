/**
 Swift Abstract Factory
 Создал 3 фабрики (для США, Европы и России)
 Каждая фабрика выпускает по банковской карте и телефону
 Россия: Карта "Мир" и Яндекс.Телефон
 США: Карта "Виза" и iPhone
 Европа: Карта "МастерКард" и Самсунг
 
 И карта и телефон могут что-нибудь оплачивать
 */

/** Сбербанк выпускает банковские карты */
protocol BankCard {
    func paySomething()
}

class Visa: BankCard {
    func paySomething() {
        print("Оплата по карте Виза")
    }
}

class MasterCard: BankCard {
    func paySomething() {
        print("Оплата по карте МастерКард")
    }
}

class Mir: BankCard {
    func paySomething() {
        print("Оплата по карте Мир")
    }
}

/** Apple, Samsung и YandexPhone выпускают телефоны с возможностью оплаты */
protocol PhoneWithPaymentFunction {
    func paySomething()
}

class IPhone: PhoneWithPaymentFunction {
    func paySomething() {
        print("Оплата с помощью Apple Pay")
    }
}

class Samsung: PhoneWithPaymentFunction {
    func paySomething() {
        print("Оплата с помощью Samsung Pay")
    }
}

class YandexPhone: PhoneWithPaymentFunction {
    func paySomething() {
        print("Оплата с помощью Yandex Phone :)")
    }
}

protocol FactoryProtocol {
    func produceBankCard() -> BankCard
    func producePhone() -> PhoneWithPaymentFunction
}

class AmericanFactory: FactoryProtocol {
    func produceBankCard() -> BankCard {
        print("Создана карта Виза")
        return Visa()
    }
    
    func producePhone() -> PhoneWithPaymentFunction {
        print("Создан телефон iPhone")
        return IPhone()
    }
}

class EuropeanFactory: FactoryProtocol {
    func produceBankCard() -> BankCard {
        print("Создана карта МастерКард")
        return MasterCard()
    }
    
    func producePhone() -> PhoneWithPaymentFunction {
        print("Создан телефон Samsung")
        return Samsung()
    }
}

class RussianFactory: FactoryProtocol {
    func produceBankCard() -> BankCard {
        print("Создана карта Мир")
        return Mir()
    }
    
    func producePhone() -> PhoneWithPaymentFunction {
        print("Создан Яндекс.Телефон")
        return YandexPhone()
    }
}

/** Собираем фабрики */
let americanFactory = AmericanFactory()
americanFactory.produceBankCard()
americanFactory.producePhone()

let europeanFactory = EuropeanFactory()
europeanFactory.produceBankCard()
europeanFactory.producePhone()

let russianFactory = RussianFactory()
russianFactory.produceBankCard()
russianFactory.producePhone()
