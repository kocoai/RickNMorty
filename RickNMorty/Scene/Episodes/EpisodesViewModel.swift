//
//  EpisodesView.swift
//  RickNMorty
//
//  Created by Kien on 1/25/21.
//

import Foundation
import Combine

final class EpisodesViewModel: ObservableObject {
    private let service = RickAndMortyService()
    private var cancellables = Set<AnyCancellable>()
    @Published var episodes = [EpisodeCellViewModel]()
    @Published var navigationTitle = "Episodes"
    private var nextPageURL: String?
    var hasMore: Bool { nextPageURL != nil }
    
    
    func load() {
        service.fetchEpisode()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.episodes = data.results.map(EpisodeCellViewModel.init)
                self?.navigationTitle = "Episodes (\(data.info.count))"
                self?.nextPageURL = data.info.next
                #if DEBUG
                print(data)
                #endif
            })
            .store(in: &cancellables)
    }
    
    func loadMore() {
        guard let nextPageURL = nextPageURL else { return }
        service.fetchEpisode(url: nextPageURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { value in
                switch value {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.episodes.append(contentsOf: data.results.map(EpisodeCellViewModel.init))
                self?.nextPageURL = data.info.next
                #if DEBUG
                print(data)
                #endif
            })
            .store(in: &cancellables)
    }
}

final class EpisodeCellViewModel: ObservableObject, Identifiable {
    let id: Int
    let name: String
    let characters: [String]
    let airDate: String
    @Published var isLiked = false
    
    init(_ episode: RickAndMortyService.EpisodeResponse.Episode) {
        self.id = episode.id
        self.name = episode.name
        self.characters = episode.characters
        self.airDate = episode.airDate
    }
}
