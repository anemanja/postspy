//
//  ContentView.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PostsViewModel()
    
    var body: some View {
        NavigationView(content: {
            List(viewModel.posts, id: \.id) { post in
                NavigationLink(destination: PostDetailsView(viewModel: PostDetailsViewModel(), post: post)) {
                PostView(post: post)
                }
            }
            .onAppear {
                viewModel.reloadPosts()
            }
            .navigationTitle("Posts")
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PostsViewModel(mockFile:"posts.json"))
    }
}
