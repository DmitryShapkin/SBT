/**
 Swift Facade
 Пример собирает все продукты а одном место (супермаркет).
 Чтобы отдельно не ходить по разным магазинам - мы приходим в супермаркет.
 */

class FruitShop {
    func buyFruits() -> String {
        return "Фрукты"
    }
}

class MeatShop {
    func buyMeat() -> String {
        return "Мясо"
    }
}

class MilkShop {
    func buyMilk() -> String {
        return "Молоко"
    }
}

class SweetShop {
    func buySweets() -> String {
        return "Конфеты"
    }
}

class BreadShop {
    func buyBread() -> String {
        return "Хлеб"
    }
}

// Facade
class Supermarket {
    private let fruitShop = FruitShop()
    private let meatShop = MeatShop()
    private let milkShop = MilkShop()
    private let sweetShop = SweetShop()
    private let breadShop = BreadShop()
    
    func buyProducts() -> String {
        var products = ""
        products += fruitShop.buyFruits() + ", "
        products += meatShop.buyMeat() + ", "
        products += milkShop.buyMilk() + ", "
        products += sweetShop.buySweets() + ", "
        products += breadShop.buyBread()
        return "Я купил: " + products
    }
}

let sm = Supermarket()
sm.buyProducts()
