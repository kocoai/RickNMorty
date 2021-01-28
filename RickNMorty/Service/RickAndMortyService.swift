//
//  RickAndMortyService.swift
//  RickNMorty
//
//  Created by Kien on 26/01/2021.
//

import Foundation
import Combine

struct RickAndMortyService {
    private let baseURL = "https://rickandmortyapi.com/api"
    private let restClient = RESTClient(session: URLSession.shared)
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func fetchEpisode() -> AnyPublisher<EpisodeResponse, Error> {
        restClient.get(url: "\(baseURL)/episode", decoder: decoder, type: EpisodeResponse.self)
    }
    
    func fetchCharacter(id: String) -> AnyPublisher<Character, Error> {
        restClient.get(url: "\(baseURL)/character/\(id)", decoder: decoder, type: Character.self)
    }
    
    func fetchCharacter(url: String) -> AnyPublisher<Character, Error> {
        restClient.get(url: url, decoder: decoder, type: Character.self)
    }
    
    struct EpisodeResponse: Decodable {
        let info: Info
        let results: [Episode]
        
        struct Info: Decodable {
            let count: Int
            let pages: Int
            let next: String?
            let prev: String?
        }
        
        struct Episode: Decodable {
            let id: Int
            let name: String
            let characters: [String]
            let airDate: String
        }
    }
    
    struct Character: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let image: String
    }
}
