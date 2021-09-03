//
//  PSPostView.swift
//  PostSpy
//
//  Created by Немања Аврамовић on 2.9.21..
//

import SwiftUI

struct PostView: View {
    var post: PSPost
    
    var body: some View {
        VStack(alignment: .leading, content: {
            Text(post.title)
                .font(.headline)
                .padding(.bottom, 5.0)
                .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                .foregroundColor(.postSpyTextPrimary)
            Text(post.body)
                .font(.body)
                .lineLimit(1)
                .padding(.bottom, 10.0)
        })
        .padding()
    }
}

struct PSPostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(
            post: PSPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "ut aspernatur corporis harum nihil quis provident sequi\nmollitia nobis aliquid molestiae\nperspiciatis et ea nemo ab reprehenderit accusantium quas\nvoluptate dolores velit et doloremque molestiae")
        )
    }
}
