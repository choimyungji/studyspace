//
//  ContentView.swift
//  BindableFormStates
//
//  Created by Myungji Choi on 2019/06/11.
//  Copyright © 2019 Myungji Choi. All rights reserved.
//

import SwiftUI

struct ContentView : View {

  @State var firstName = ""
  @State var lastName = ""

  @State var users = [String]()

  var body: some View {
    NavigationView {
      VStack {
        VStack {
          VStack {
            Group {
              TextField($firstName, placeholder:Text("First Name"))
                .padding(12)
              }.background(Color.white)
              .clipShape(RoundedRectangle(cornerRadius: 5))
              .shadow(radius: 5)

            Group {
              TextField($lastName, placeholder:Text("Last Name"))
                .padding(12)
              }.background(Color.white)
              .clipShape(RoundedRectangle(cornerRadius: 5))

            Button(action: {
              self.users.append("\(self.firstName) \(self.lastName)")
              self.firstName = ""
              self.lastName = ""

            }) {
              Group {
                Text("Create User")
                  .color(.white)
                  .padding(12)
                  .background(firstName.count + lastName.count > 0 ? Color.blue : Color.gray)
                  .clipShape(RoundedRectangle(cornerRadius: 5))
              }
            }
            }.padding(12)

          }.background(Color.gray)
        
        List (users.identified(by: \.self)){
          Text($0)
          }
          .navigationBarTitle(Text("Credit Card Form"))
          .navigationBarItems(leading: HStack {
            Text("First name:")
            Text(firstName).color(.red)
            Text("Last name:")
            Text(lastName).color(.red)
          })
      }
    }
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
