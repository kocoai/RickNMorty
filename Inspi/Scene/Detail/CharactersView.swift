//
//  CharactersView.swift
//  Inspi
//
//  Created by Kien on 1/25/21.
//

import SwiftUI
import Kingfisher

struct CharactersView: View {
    @ObservedObject var episode: EpisodeCell.ViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(episode.characters, id: \.self, content: CharacterCell.init)
            }
        }
        .navigationTitle("Episode \(episode.id)")
        .navigationBarItems(trailing: Button(action: { episode.isLiked.toggle() }, label: { Image(systemName: episode.isLiked ? "heart.fill" : "heart") })
        )
    }
}

struct CharacterCell: View {
    let characterUrl: String
    @StateObject var viewModel = ViewModel()
    
    init(characterUrl: String) {
        self.characterUrl = characterUrl
    }
    
    var body: some View {
        VStack {
            KFImage.url(URL(string: viewModel.imageURL))
            VStack {
                Text(viewModel.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text("Gender: \(viewModel.gender)")
                Text("Species: \(viewModel.species)")
                Text("Status: \(viewModel.status)")
            }
            Spacer(minLength: 40)
        }
        .onAppear {
            viewModel.loadCharacter(url: characterUrl)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(episode: EpisodeCell.ViewModel(RickAndMortyService.EpisodeResponse.Episode(id: 1, name: "", characters: [], airDate: "")))
    }
}