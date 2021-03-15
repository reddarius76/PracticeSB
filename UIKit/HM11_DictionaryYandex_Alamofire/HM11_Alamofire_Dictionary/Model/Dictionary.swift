//
//  DictionaryModal.swift
//  HM11_AlamoFire_Dictionary
//
//  Created by Oleg Krikun on 22.01.2021.
//

//head - Заголовок результата (не используется).
//def - Массив словарных статей. В атрибуте ts может указываться транскрипция искомого слова.
//tr - Массив переводов.
//syn - Массив синонимов.
//mean - Массив значений.
//ex - Массив примеров.
//text - Текст статьи, перевода или синонима (обязательный).
//num - Число (для имен существительных). pl - указывается для существительных во множественном числе.
//pos - Часть речи (может отсутствовать).
//gen - Род существительного для тех языков, где это актуально (может отсутствовать).

// MARK: - Dictionary
struct Dictionary: Decodable {
    let head: Head?
    let def: [Def]?
}

// MARK: - Def
struct Def: Decodable {
    let text, pos: String?
    let tr: [Tr]?
}

// MARK: - Tr
struct Tr: Decodable {
    let text, pos: String?
    let syn, mean: [Mean]?
    let ex: [Ex]?
}

// MARK: - Ex
struct Ex: Decodable {
    let text: String?
    let tr: [Mean]?
}

// MARK: - Mean
struct Mean: Decodable {
    let text: String?
}

// MARK: - Head
struct Head: Decodable {
}

