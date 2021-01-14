import UIKit
/*:
 ### Задание 1
 1.1 Объявите два свойства с типом `Float` и присвойте каждому число с дробной частью — например, 3.14 или 42.0
 
 1.2 Объявите еще одно свойство с типом `Double` и присвойте ей сумму двух переменных типа `Float`
 
 1.3 Выведите результат при помощи `print()`
 */
let pi: Float = 3.14
let value: Float = 42.0
let resultSum = Double(pi + value)
print(resultSum)
/*:
 ### Задание 2
 2.1 Создайте переменную `numberOne` и присвойте ей любое целочисленное значение
 
 2.2 Создайте ещё одну целочисленную переменную `numberTwo` и присвойте ей любое значение меньше `numberOne`
 
 2.3 Присвойте новой целочисленной константе `result` результат деления `numberOne` на `numberTwo`
 
 2.4 Присвойте новой целочисленной константе `remainder` остаток от деления `numberOne` на `numberTwo`
 
 2.5 Выведите на консоль сообщение: «При делении <...> на <...> результат равен <...>, остаток равен <...>», подставив вместо (<...>) свои результаты.
 
 2.6 Выведите на консоль фразу: «Результат деления <...> на <...> равен <...> <...>/<...>». Поясню: в математике результатом деления 5 на 3 будет натуральная дробь 1 2/3 (одна целая две третьих, здесь мы используем стандартную математическую запись, а не оператор деления). Вам необходимо вывести на консоль именно такой результат от деления `numberOne` на `numberTwo` в виде натуральной дроби — например «Результат деления 7 на 3 равен 2 1/3».
 
 */
let numberOne = 22
let numberTwo = 3

let result = numberOne / numberTwo
let remainder = numberOne % numberTwo

print("При делении \(numberOne) на \(numberTwo) результат равен \(result), остаток равен \(remainder)")

if remainder == 0 {
    print("Результат деления \(numberOne) на \(numberTwo) равен \(result)")
} else {
    print("Результат деления \(numberOne) на \(numberTwo) равен \(result) \(remainder)/\(numberTwo)")
}

/*:
 ### Задание 3
 3.1 Объявите константу `dayOfBirth` и присвоейте ей дату вашего рождения
 
 3.2 Объявите константу `mothOfBirth` и присвоейте ей месяц вашего рождения
 
 3.3 Объявите константу `yearOfBirth` и присвоейте ей год вашего рождения
 
 3.4 Необходимо рассчитать прожитое вами время время с момента вашего рождения по текущую дату в разных единицах измерения (в годах, месяцах, днях и секундах). За текущее время возьмите сегодняшнюю дату и 0 часов 0 минут. Високосные года учитывать не надо. Пусть среднее количество дней в месяце будет 30. Создайте необходимые для решения данной задачи свойства. Для расчета всех необходимых величин используйте только арифметические операторы. Ни каких функций использоваться не должно.
 
 3.5 Выведите результат решения на консоль в виде текста (n years, n months, n days and n seconds have passed since my birth). Можете использовать свой текст. Например, если я родился 9 ноября 1980 года, а текущая дата 29.01.20, то результат будет следующим: **39 years, 470 months, 14120 days and 1219968000 seconds have passed since my birth**
 
 3.6 Выведите на консоль сообщение о том в каком квартале вы родились. Для этого используейте операторы сравнения, что бы сравнить номер месяца вашего рождения с одним из четрырех кварталов. Например если номер месяца больше 0 и меньше или равно 3, то это будет первый квартал. Для получения результата используйте конструкцию if
 */

let (dayOfBirth, monthOfBirth, yearOfBirth) = (01, 01, 2020)
let (dayOfToday, monthOfToday, yearOfToday) = (12, 12, 2020)

var countYears: Int
var countMonths: Int
var countDays: Int
var countSeconds: Int


if dayOfToday - dayOfBirth < 0 {
    if monthOfToday - monthOfBirth - 1 < 0 {
        countYears = yearOfToday - yearOfBirth - 1
    }
    else {
        countYears = yearOfToday - yearOfBirth
    }
}
else if dayOfToday - dayOfBirth > 0 {
    if monthOfToday - monthOfBirth - 1 < 0 {
        countYears = yearOfToday - yearOfBirth - 1
    }
    else {
        countYears = yearOfToday - yearOfBirth
    }
}
else {
    if monthOfToday - monthOfBirth - 1 > 0 {
        countYears = yearOfToday - yearOfBirth - 1
    }
    else {
        countYears = yearOfToday - yearOfBirth
    }
}

if countYears < 0 {
    print("Год рождения больше текущего года! - Проверьте год рождения.")
}
else if countYears == 0 {
    countMonths = monthOfToday - monthOfBirth
    
    if countMonths < 0 {
        print("Месяц рождения больше текущего месяца! - Проверьте месяц рождения.")
    }
    
    else if countMonths == 0 {
        countDays = dayOfToday - dayOfBirth
        
        if countDays < 0 {
            print("День рождения больше текущего дня! - Проверьте день рождения.")
        }
        else if countDays == 0 {
            countSeconds = 0
            print("\(countYears) years, \(countMonths) months, \(countDays) days and \(countSeconds) seconds have passed since my birth")
        }
        else if countDays > 0 {
            countSeconds = 86400 * countDays
            print("\(countYears) years, \(countMonths) months, \(countDays) days and \(countSeconds) seconds have passed since my birth")
        }
    }
    
    else if countMonths > 0 {
        countDays =  30 * countMonths + (monthOfToday - monthOfBirth)
        countSeconds = 86400 * countDays
        print("\(countYears) years, \(countMonths) months, \(countDays) days and \(countSeconds) seconds have passed since my birth")
    }
}
else if countYears > 0 {
    if monthOfToday >= monthOfBirth {
        if dayOfToday >= dayOfBirth {
            countMonths = countYears * 12 + (monthOfToday - monthOfBirth)
        }
        else {
            countMonths = countYears * 12 + (monthOfToday - monthOfBirth - 1)
        }
    }
    else {
        countMonths = countYears * 12 + (12 - monthOfBirth + monthOfToday)
    }
    countDays =  30 * countMonths + (dayOfToday - dayOfBirth)
    countSeconds = 86400 * countDays
    print("\(countYears) years, \(countMonths) months, \(countDays) days and \(countSeconds) seconds have passed since my birth")
}

if  monthOfBirth <= 0 || monthOfBirth >= 13 {
    print("Неверный месяц!")
} else if monthOfBirth <= 3 {
    print("Вы родились в первом квартале.")
} else if monthOfBirth <= 6 {
    print("Вы родились во втором квартале.")
} else if monthOfBirth <= 9 {
    print("Вы родились в третьем квартале.")
} else {
    print("Вы родились в четвертом квартале.")
}
/*:
 ### Задание 4
 Задание на вашу способность гуглить. Необходимо вычислить синус от числа 1 и округлить результат до тысячных.
 > Подсказка: в результате должно получиться 0.841
 */
let rad = 1
let degreeOfRad = Float((rad * 180)) / pi
let sineDegree = sin(degreeOfRad * pi / 180)
let sineFromRad = round(1000 * sineDegree) / 1000
print("Sine from \(rad) is equal " + String(sineFromRad))
