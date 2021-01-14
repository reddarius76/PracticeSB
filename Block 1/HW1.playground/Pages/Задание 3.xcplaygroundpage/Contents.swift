import Foundation

/*:
 ### Задание 3
 
 Необходимо вычислить площадь и периметр прямоугольного треугольника.
 
 >Условия:
 Катеты прямоугольного треугольника:
 AC = 8.0, CB = 6.0. Гипотенузу треугольника AB вычисляем при помощи функции `sqrt(Double)`, заменив `Double` суммой квадратов катетов
 
 */

let AC = 8.0
let CB = 6.0

let AB = sqrt(pow(AC, 2) + pow(CB, 2))

let areaTriangle = AC * CB / 2
let perimeterTriangle = AC + CB + AB

//: [Ранее: Задани 2](@previous) | Задание 3 из 3
