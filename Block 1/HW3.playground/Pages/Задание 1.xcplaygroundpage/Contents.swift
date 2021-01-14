import UIKit

//: ## Home work 3

/*:
 ### Задание 1
 Представьте, что вы владелец розничного магазина и вам необходимо закупить товар, стоимость которого варьируется от его количества. Если количество закупаемого товара меньше 10 позиций, то цена равна 1000 рублей за штуку. От 10 до 20 единиц товара будет стоить вам 800 рублей за штуку. И вы заплатите 600 рублей за единцу при единовременно покупке от 20 единиц. Создайте условие для расчета цены за еденицу товара в зависмости от его количества и подсичитайте общую сумму используя конструкцию `if-else`. Постарайтесь написать короткое и читаемое решение
 */
let costItemProduct = 1000
let countProduct = 11
let resultCost: Int

if countProduct >= 10 && countProduct < 20 {
    let discountFrom10To19 = 200
    resultCost = (costItemProduct - discountFrom10To19) * countProduct
} else if countProduct >= 20 {
    let discountMore20 = 400
    resultCost = (costItemProduct - discountMore20) * countProduct
} else {
    resultCost = costItemProduct * countProduct
}
print("Сумма равна \(resultCost) за \(countProduct) товаров")
//: |  задание 1 из 4  |  [Далее: Задание 2](@next)
