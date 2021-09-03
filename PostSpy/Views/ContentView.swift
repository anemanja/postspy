//
//  ContentView.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PostsViewModel()
    @State var shouldShowAlert: Bool = false
    
    var body: some View {
        NavigationView(content: {
            List(viewModel.posts, id: \.id) { post in
                NavigationLink(destination: PostDetailsView(viewModel: PostDetailsViewModel(), post: post)) {
                PostView(post: post)
                }
            }
            .onAppear {
                viewModel.reloadPosts() {
                    shouldShowAlert = true
                }
            }
            .alert(isPresented: $shouldShowAlert) {
                Alert(title: Text("Network Error"), message: Text(viewModel.networkErrorText))
            }
            .toolbar(content: {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        viewModel.reloadPosts(forcedRefresh: true) {
                            shouldShowAlert = true
                        }
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.large)
                    })
                }
            })
            .navigationTitle("Posts")
        })
        .accentColor(.postSpyPrimary)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PostsViewModel(mockFile:"posts.json"))
    }
}
