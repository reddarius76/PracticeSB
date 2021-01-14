/*:
 ## Упражнение - приведение типов и их контроль
 
 Создайте коллекцию типа [Any], включающую несколько вещественных чисел, целых, строк и булевых значений.  Распечатайте содержимое коллекции.
 */
let collectionWithAnyValues: [Any] = [1, 5.5, true, "Строка", 0.55581, 125, "Net", false]

for value in collectionWithAnyValues {
    print(value)
}
/*:
 Пройдите по всем элементам коллекции.  Для каждого целого, напечайте "Целое число " и его значение.  Повторите то же самое для вещественных чисел, строк и булевых значений.
 */
for value in collectionWithAnyValues {
    if value is Int {
        print("Целое число: \(value)")
    } else if value is Double {
        print("Вещественное число: \(value)")
    } else if value is String {
        print("Значение строка: \(value)")
    } else if value is Bool {
        print("Логическое значение: \(value)")
    }
}
/*:
 Создайте словарь [String : Any], где все значения — это смесь вещественных и целых чисел, строк и булевых значений.  Выведите пары ключ/значения для всех элементов коллекции.
 */
let someDictionary: [String: Any] = [
    "Name": "5",
    "Age": 30,
    "isEmployee": true,
    "height": 175.58
]

for (key, value) in someDictionary {
    print("Ключ \(key): Значение \(value)")
}

/*:
 Создайте переменную `total` типа `Double`, равную 0.  Переберите все значения словаря, и добавьте значение каждого целого и вещественного числа к значению вашей переменной.  Для каждой строки добавьте 1.  Для каждого булева значения, добавьте 2, в случае, если значение равно `true`, либо вычтите 3, если оно `false`.  Напечатайте значение `total`.
 */

var total = 0.0
    
for (_, value) in someDictionary {
    if let value = value as? Int {
        total += Double(value)
    } else if let value = value as? Double {
        total += value
    } else if value is String {
        total += 1
    } else if let value = value as? Bool {
        total += value ? 2 : -3
    }
}

print(total)
    

/*:
 Обнулите переменную total и снова пройдите по всей коллекции, прибавляя к ней все целые и вещественные числа.  Для каждой строки, встретившейся на пути, попробуйте сконвертировать её в число, и добавьте это значение к общему.  Игнорируйте булевы значения.  Распечатайте итог.
 */
total = 0

for (_, value) in someDictionary {
    if let value = value as? Int {
        total += Double(value)
    } else if let value = value as? Double {
        total += value
    } else if let value = value as? String {
        total += Double(value) ?? 0
    }
}

print(total)
//: страница 1 из 2  |  [Далее: упражнение для приложения - типы тренировок](@next)
