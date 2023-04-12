//
//  MainView.swift
//  HW2
//
//  Created by 贺力 on 4/11/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 100) {
                
                Text("Personal Health Monitoring System")
                    .font(.system(size:20))
                Image("health")
                    .resizable()
                    .scaledToFit()
                NavigationLink(destination: ContentView())
                {
                    Text("Record Now")
                        .font(.system(size:20))
                }.padding()
                    .clipShape(Capsule())
                NavigationLink(destination: ViewHealthView())
                {
                    Text("View My Health")
                        .font(.system(size:20))
                }.padding()
                    .clipShape(Capsule())
                
            }
            .padding()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
