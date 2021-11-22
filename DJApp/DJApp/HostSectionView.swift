//
//  HostingSectionView.swift
//  DJApp
//
//  Created by Sam on 11/20/21.
//

import SwiftUI

struct HostSectionView: View {
    @StateObject var viewModel = HostSectionViewModel()
    
    
    var body: some View {
        let noPlaylist = Binding<Bool>(get: { viewModel.playlist == nil }, set: { _ in })
        var nominations = viewModel.room?.nominations
        
        GeometryReader {geometry in
                VStack(alignment: .center) {
                    if viewModel.leaving {
                        ProgressView()
                    } else {
                        if let errorMessage = viewModel.leavingErrorMessage {
                            Text(errorMessage)
                                .padding()
                        
        //                Text("Name: \(viewModel.room.name)")
        //                    .padding()
        //
        //                Text("Code: \(viewModel.room.code)")
        //                    .padding()
                    }
                        Spacer()
                        
                        if let nominations = nominations {
                            let song1 = nominations.0
                            let song2 = nominations.1
                            Button(action: { viewModel.vote(vote: .song(song1.id))
                            })
                                {
                                    Text(song1.title + "\n\n" + song1.artist)
            //                            .frame(wid height: 200, alignment: .center)
    //                                    .padding()
                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height / 4)
                                        .background(Color.pink)
                                         .cornerRadius(40)
                                         .foregroundColor(Color.white)
//                                         .font(.title, Weight: .bold)
//                                         .font(UIFont(descriptor: "HelveticaNeue-Bold", size: 16.0))
//
                                }
                                

                            Spacer()
                            Button(action: { viewModel.vote(vote: .song(song2.id))
                            })
                                {
                                    Text(song2.title + "\n\n" + song2.artist)
    //                                    .padding()
                                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height / 4, alignment: .center)

                                        .background(Color.indigo)
                                        .cornerRadius(40)
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                }
                                
                        }


                        
                        Spacer()
                        Button(action: { viewModel.vote(vote: .random)
                        })
                            {
                                Text("Random")
//                                    .padding()
                                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height / 4, alignment: .center)

                                        .background(Color.black)
                                        .cornerRadius(40)
                    //                    .padding()
//                                        .border(Color.black)
                                        .foregroundColor(Color.white)
                                        .font(.title)
                            }
                            
                            
                        Spacer()
                        Button(action: {
                            viewModel.leaveRoom()
                        }) {
                            Text("Leave Room")
                        }
        //                .padding()
        //                .background(Color.pink)
        //                .cornerRadius(40)
        //                .padding()
        //                .foregroundColor(Color.black)
        //                .font(.title)
                        
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
    //            .padding()
    //            .frame(alignment: .center)
            }
            .sheet(isPresented: noPlaylist) {
                SelectMusicProviderView()
                    .interactiveDismissDisabled()
        }
//            .background(LinearGradient(gradient: Gradient(colors: [.green, .purple, .green]), startPoint: .top, endPoint: .bottom))
            .background(Color.green)
    }
}
        


struct HostingSectionView_Previews: PreviewProvider {
    static var previews: some View {
        HostSectionView()
    }
}
