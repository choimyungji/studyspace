//
//  ContentView.swift
//  FBGroupsSwiftUI
//
//  Created by Myungji Choi on 2019/06/09.
//  Copyright © 2019 Myungji Choi. All rights reserved.
//

import SwiftUI

struct Post {
  let id: Int
  let username, text, imageName: String
}
struct ContentView : View {

  let posts: [Post] = [
    .init(id: 0, username: "Hillary Clinton", text: "Good old bill up to his usual ways and dirty tricks", imageName: "burger"),
    .init(id: 0, username: "Hillary Clinton", text: "Good old bill up to his usual ways and dirty tricks", imageName: "burger"),
    .init(id: 0, username: "Hillary Clinton", text: "Good old bill up to his usual ways and dirty tricks", imageName: "burger")
  ]
  var body: some View {
    NavigationView {
      List {
        VStack (alignment: .leading) {
          Text("Trending")
          ScrollView {
            VStack (alignment: .leading) {
              HStack {
                NavigationButton(destination: GroupDetailView()) {
                  GroupView()
                }

                GroupView()
                GroupView()
                GroupView()
              }
            }
          }.frame(height: 210)
        }

        ForEach(posts.identified(by: \.id)) { post in
          PostView(post: post)
        }
        }.navigationBarTitle(Text("Groups"))
    }
  }
}
struct GroupView: View {
  var body: some View {
    VStack (alignment: .leading) {
      Image("hike").renderingMode(.original).cornerRadius(8)
      Text("Co-Ed Hikes of Colorado")
        .color(.primary)
        .lineLimit(nil)
        .padding(.leading, 0)
      }.frame(width: 120, height: 170)
  }
}

struct GroupDetailView: View {
  var body: some View {
    Text("Group Detail VIEW")
  }
}

struct PostView: View {
  let post: Post

  var body: some View {
    VStack (alignment: .leading) {
      HStack {
        Image("burger")
          .resizable()
          .clipShape(Circle())
          .frame(width: 70, height: 70)
          .clipped()

        VStack (alignment: .leading, spacing: 4){
          Text(post.username).font(.headline)
          Text("Posted 8 hrs ago").font(.headline)
        }.padding(.leading, 8)
      }.padding(.leading, 16).padding(.top, 16)

      Text("Post body text htat will hopefully support auto sizing vertically and span multiple lines")
        .lineLimit(nil)
      .padding(.leading, 16).padding(.trailing, 32)

      Image(post.imageName)
//        .resizable()
        .scaledToFill()
        .frame(height: 300)
        .clipped()
      }.padding(.leading, -20).padding(.bottom, -8)
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
