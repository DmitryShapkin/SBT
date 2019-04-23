/**
 Swift - Chain of responsibility
 Пример на основе противника с установленной силой (например, 600).
 Цепочка ответственности: Солдат -> Офицер -> Генерал
 Объекты передают ответственность если не могут победить врага.
 */

class Enemy {
    let strength = 600
}

protocol MilitaryChain {
    var strength: Int { get }
    var nextRank: MilitaryChain? { get set }
    func shouldDefeatWithStrength(amount: Int)
}

class Soldier: MilitaryChain {
    var strength = 100
    var nextRank: MilitaryChain?
    func shouldDefeatWithStrength(amount: Int) {
        if amount < strength {
            print("Солдат победил врага")
        } else {
            nextRank?.shouldDefeatWithStrength(amount: amount)
        }
    }
}

class Officer: MilitaryChain {
    var strength = 500
    var nextRank: MilitaryChain?
    func shouldDefeatWithStrength(amount: Int) {
        if amount < strength {
            print("Офицер победил врага")
        } else {
            nextRank?.shouldDefeatWithStrength(amount: amount)
        }
    }
}

class General: MilitaryChain {
    var strength = 1000
    var nextRank: MilitaryChain?
    func shouldDefeatWithStrength(amount: Int) {
        if amount < strength {
            print("Генерал победил врага")
        } else {
            print("Мы не можем победить врага")
        }
    }
}

let enemy = Enemy()
let soldier = Soldier()
let officer = Officer()
let general = General()

soldier.nextRank = officer
officer.nextRank = general

soldier.shouldDefeatWithStrength(amount: enemy.strength)
