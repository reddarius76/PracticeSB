import UIKit

//: ## Home Work 5
/*:
 ### Задание 1
 Создайте словарь, который содержит результаты игр спортивной команды в чемпионате (например по хоккею). Ключом словаря должно быть название команды соперника, а в качестве значения должен быть массив с результатами игр с этим соперником. Необходимо вывести на консоль результаты игр. Выглядить это должно примерно следующим образом:
 
 - Игра с Салават Юлаев - 3:6
 
 - Игра с Салават Юлаев - 5:5
 
 - Игра с Авангард - 2:1
 
 - Игра с Авангард - 2:3
 
 - Игра с АкБарс - 3:3
 
 - Игра с АкБарс - 1:2
 */

let resultGames = ["Салават Юлаев": ["3:6", "5:5"],
                  "Авангард": ["2:1", "2:3"],
                  "АкБарс": ["3:3", "1:2"]]

for (team, results) in resultGames {
    for score in results {
        print("Игра c \(team) - \(score)")
    }
}
/*:
 ### Задание 2
 2.1 Создайте функцию, которая считает общую сумму денег, хранящихся в кошельке. В кошельке имеются купюры различного достоинства от 50 до 5000 рублей
 */
func sumMoney(inWallet notes: [Int]) {
    var result = 0
    for cash in notes {
        result += cash
    }
    print("Общая сумма денег в кошельке равна: \(result)")
}
//: 2.2 Заполните массив различными купюрами и подсчитайте общую сумму
let myNotes = [50, 100, 200, 500, 1000, 5000, 100, 1000]
sumMoney(inWallet: myNotes)
/*:
 ### Задание 3
 3.1 Создайте функцию, которая определяет является ли число четным или нет. В случае, если число является четным, функция должна возвращать `true`. Иначе - `false`. Подумайте над названием функции, оно должно быть ёмким и в то же время не очень длинным
 */
func isEven(number: Int) -> Bool {
    number % 2 == 0
}

isEven(number: 5)
isEven(number: 4)

/*:
3.2 Создайте функцию, которая определяет делится ли число на *3* без остатка. Функция так же должна возвращать булево значение. Так же подумайте над названием функции
*/
func isDividedByThree(inNumber number: Int) -> Bool {
    number % 3 == 0
}

isDividedByThree(inNumber: 6)
isDividedByThree(inNumber: 4)
/*:
 3.3 Создайте функцию, которая создает возрастающий массив чисел в интервале от *x* до *y*. Данный интервал должен определять пользователь при вызове функции. Если хотите усложить задание, то пусть данная функция создает массив случайных чисел в заданном интервале с уникальными значениями
 */
func generateArrayInRange(from x: Int, to y:Int) -> [Int] {
    var array = [Int]()
    for value in x...y {
        array.append(value)
    }
    return array
}

generateArrayInRange(from: 1, to: 10)
/*:
3.4 Создайте массив чисел от *1* до *100*, используя для этого вышесозданную функцию
 */
let arrayFrom1To100 = generateArrayInRange(from: 1, to: 100)
/*:
 3.5 Создайте функции для удаления всех четных чисел из массива и чисел, которые делятся на *3*. Для определения четного числа и числа которое делится на *3* используейте ранее созданные функции из задания **3.1** и **3.2**.
 */
func removeNumbers(fromArray array: [Int], closure: (Int) -> Bool) -> [Int] {
    var tempArray = [Int]()
    for number in array {
        if !closure(number) {
            tempArray.append(number)
        }
    }
    return tempArray
}

let array = [1, 2, 5, 7, 9]

removeNumbers(fromArray: array, closure: isEven)

removeNumbers(fromArray: array, closure: { number in
    number % 2 == 0
})

removeNumbers(fromArray: array, closure: { (number) in
    number % 3 == 0
})

removeNumbers(fromArray: array, closure: { (number) in
    number % 2 == 0 || number % 3 == 0
})


