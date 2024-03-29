//
//  ContentView.swift
//  FetchJSONandImagesDemo
//
//  Created by Myungji Choi on 2019/06/11.
//  Copyright © 2019 Myungji Choi. All rights reserved.
//

import SwiftUI
import Combine

struct Course: Decodable {
  let name, imageUrl: String
}

class NetworkManager: BindableObject {
  var didChange = PassthroughSubject<NetworkManager, Never>()
  var courses = [Course]() {
    didSet {
      didChange.send(self)
    }
  }

  init() {
    guard let url = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/courses") else { return }
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let data = data else { return }
      let courses = try! JSONDecoder().decode([Course].self, from: data)
      DispatchQueue.main.async {
        self.courses = courses
      }

      print(String(bytes: data, encoding: .utf8))
    }.resume()
  }
}

struct ContentView : View {
  @State var networkManager = NetworkManager()

    var body: some View {
      NavigationView {
        List (networkManager.courses.identified(by: \.name)) { course in
          CourseRowView(course: course)
        }.navigationBarTitle(Text("Courses"))
      }
    }
}

struct CourseRowView: View {
  let course: Course

  var body: some View {
    VStack (alignment: .leading){
      ImageViewWidget(imageUrl: course.imageUrl)
//        .resizable()
//        .frame(width: 200, height: 200)
//        .clipped()

      Text(course.name)
    }
  }
}

class ImageLoader:BindableObject {
  var didChange = PassthroughSubject<Data, Never>()

  var data = Data() {
    didSet {
      didChange.send(data)
    }
  }

  init(imageUrl: String) {
    guard let url = URL(string: imageUrl) else { return }
    URLSession.shared.dataTask(with: url) { (data, _, _) in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.data = data
      }
    }.resume()
  }
}

struct ImageViewWidget: View {
  @ObjectBinding var imageLoader: ImageLoader

  init(imageUrl: String) {
    imageLoader = ImageLoader(imageUrl: imageUrl)
  }
  var body: some View {
    Image(uiImage: (imageLoader.data.count == 0)
      ? UIImage(named: "IMG_0076")!
      : UIImage(data: imageLoader.data)!)
    .resizable()
    .frame(width: 320, height: 180)
    .clipped()
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
