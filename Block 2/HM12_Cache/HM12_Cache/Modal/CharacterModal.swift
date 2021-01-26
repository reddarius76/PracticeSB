//
//  CharacterModal.swift
//  HM12_Cache
//
//  Created by Oleg Krikun on 24.01.2021.
//


// MARK: - CharacterInfo
struct CharacterInfo: Decodable {
    let info: Info?
    let results: [Result]?
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct Result: Decodable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Gender
enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Decodable {
    let name: String?
    let url: String?
}

// MARK: - Species
enum Species: String, Decodable {
    case alien = "Alien"
    case human = "Human"
}

// MARK: - Status
enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Character
struct Character: Decodable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    var description: String {
        """
    Status: \(status ?? "unknown")
    Species: \(species ?? "unknown")
    Gender: \(gender ?? "unknown")
    Origin: \(origin?.name ?? "unknown")
    Location: \(location?.name ?? "unknown")
    """
    }
}

// MARK: - API URLs
enum urlAPI: String {
    case urlCharacter = "https://rickandmortyapi.com/api/character/"
    case urlLocation = "https://rickandmortyapi.com/api/location/"
    case urlEpisode = "https://rickandmortyapi.com/api/episode/"
}

