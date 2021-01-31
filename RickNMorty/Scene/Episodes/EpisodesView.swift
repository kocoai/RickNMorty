//
//  EpisodesView.swift
//  RickNMorty
//
//  Created by Kien on 1/25/21.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject private var viewModel = EpisodesViewModel()
    @State private var isLoaded = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 15) {
                ForEach(viewModel.episodes, content: EpisodeCell.init)
            }
            if viewModel.hasMore {
                Button("More...") {
                    viewModel.loadMore()
                }
                .foregroundColor(.white)
            }
        }
        .padding(.horizontal)
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            if !isLoaded {
                viewModel.load()
                isLoaded = true
            }
        }
    }
}

struct EpisodeCell: View {
    @ObservedObject var viewModel: EpisodeCellViewModel
    
    var body: some View {
        NavigationLink(destination: CharactersView(episode: viewModel)) {
            ZStack {
                Color.red
                VStack {
                    Text("\(viewModel.id)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(viewModel.name)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    Text(viewModel.airDate).font(.caption)
                        .foregroundColor(.white)
                    Spacer()
                    
                }
                .padding()
                if viewModel.isLiked {
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
        }
    }
}

struct EpisodessView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesView()
    }
}
