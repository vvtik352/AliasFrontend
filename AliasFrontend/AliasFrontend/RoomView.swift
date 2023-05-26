//
//  RoomView.swift
//  AliasFrontend
//
//  Created by 1234 on 19.05.2023.
//

import Foundation
import SwiftUI


// Shows room.
struct RoomView: View {
    @EnvironmentObject var dataManager: DataManager
    @Binding var isTabViewHidden: Bool

    @State var firstTeam: [String] = ["User1"]
    @State var secondTeam: [String] = []
    @State private var showEditGameRoomView = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        HStack(spacing: 30){
                            Text("First Team")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGray4))
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .frame(width: 50, height: 30)
                                    .foregroundColor(Color.mint)
                                Button {} label: {
                                    //  Добавить добавление участника
                                    Text("Join")
                                }.buttonStyle(.plain)
                                    .foregroundColor(.black)
                        
                            }
                        
                        }
                        ForEach((0...4), id: \.self) {i in
                                ZStack {
                                    Divider()
                                        .frame(height: 35)
                                        .background() {
                                            Rectangle()
                                                .foregroundStyle(.linearGradient(colors: [.white.opacity(0.06), .mint.opacity(0.8)], startPoint: .top, endPoint: .leading))
                                                .frame(width: 500, height: 50)
                                            
                                            
                                        }
                                    if i < firstTeam.count {
                                        HStack() {
                                            // Отобразить участников команды
                                            Text(firstTeam[i])
                                                .foregroundColor(Color(.systemGray4))
                                                .fontWeight(.bold)
                                            // Добавить проверку является ли участник админом, если нет, то не показывать эти кнопки
                                            HStack {
                                                // Если участник админ поменять иконку на ту что в коментах
                                                Button {} label: {
                                                    Image(systemName: "flag")
                                                        .resizable()
                                                        .frame(width: 20, height:20)
                                                        .foregroundColor(Color(.systemGray4))
                                                }
                                                //                                            Image(systemName: "flag.fill")
                                                //                                                                    .resizable()
                                                //                                                                    .frame(width: 20, height:20)
                                                //                                                                    .foregroundColor(Color(.systemGray4))
                                                
                                                // Удаление участника
                                                Button {} label: {
                                                    Image(systemName: "xmark")
                                                        .resizable()
                                                        .frame(width: 20, height:20)
                                                        .foregroundColor(Color(.systemGray4))
                                                    
                                                }
                                            }
                                            .offset(x: 120)
                                        }
                        
                                    }
                                }
                            Spacer()
                                .frame(height: 16)
                            }
                        
                    }
                    Spacer()
                        .frame(height: 10)
                    VStack {
                        VStack {
                            HStack(spacing: 30){
                                Text("Second Team")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGray4))
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .frame(width: 50, height: 30)
                                        .foregroundColor(Color.mint)
                                    Button {} label: {
                                        Text("Join")
                                    }.buttonStyle(.plain)
                                        .foregroundColor(.black)
                                    
                                }
                                
                            }
                        }
                        ForEach((0...4), id: \.self) {i in
                            ZStack {
                                Divider()
                                    .frame(height: 35)
                                    .background() {
                                        Rectangle()
                                            .foregroundStyle(.linearGradient(colors: [.white.opacity(0.06), .mint.opacity(0.8)], startPoint: .top, endPoint: .leading))
                                            .frame(width: 500, height: 50)
                                           
                                            
                                    }
                                if i < secondTeam.count {
                                    Text(secondTeam[i])
                                }
                            }
                            Spacer()
                                .frame(height: 16)
                        }
                    }
                    HStack(spacing: 30) {
                        Button {} label: {
                            Text("Покинуть комнату")
                                .foregroundColor(Color(.systemGray4))
                        
                        }
                        // Отображается только для админа, сделать проверку 
                        Button {} label: {
                            Text("Начать игру")
                                .foregroundColor(Color(.systemGray4))
                        
                        }
                    }
                    .padding(.top, 20)
                }
                
                
            }
        
            .navigationTitle(dataManager.currentRoom?.name ?? "Room name")
            .navigationBarBackButtonHidden()
            .navigationBarTitleTextColor(Color.mint.opacity(0.7))
            // Сделать проверку является ли пользователь админом, неадмину они не доступны
            .navigationBarItems(leading:   Button {
                dataManager.deleteRoom()
            } label: {
                Label("", systemImage: "trash")
                    .foregroundColor(Color(.systemGray4))
            }, trailing: HStack {
                NavigationLink(destination: EditGameRoomView().environmentObject(dataManager), isActive: $showEditGameRoomView) {
                    EmptyView()
                }
                Button {
                    showEditGameRoomView = true
                } label: {
                    Label("", systemImage: "gearshape")
                        .foregroundColor(Color(.systemGray4))
                }
            })      .onAppear {
                isTabViewHidden = true
            }
            .onDisappear {
                isTabViewHidden = false
            }
        }
    }
}
extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }
}
struct RoomView_Previews: PreviewProvider {
    @State static var isTabViewHidden = false

    static var previews: some View {
        RoomView(isTabViewHidden: $isTabViewHidden)
    }
}
