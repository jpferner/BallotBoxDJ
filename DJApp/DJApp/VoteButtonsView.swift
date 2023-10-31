//
//  VoteButtonsView.swift
//  DJApp
//
//  Created by user206471 on 11/23/21.
//

import SwiftUI

struct VoteButtonsView: View {
    @StateObject var viewModel = VoteButtonsViewModel()
    var nominations:(Song, Song)
    
    var vote:Vote?
    
    var voteTally: VoteTally
    
    var colors: [Color]
    
    var allowChangingVotes: Bool
    var postVotesInChat: Bool
    
    var onVote:(Vote) ->()
    
    
    
    
    var body: some View {
//        VStack {
            
      //  var value = false
//            GeometryReader {geometry in
                VStack {
                    
                    let hasVoted:Bool = vote != nil
                    let song1 = nominations.0
                    let song2 = nominations.1
                    
          //          switch (viewModel.room!.settings.setting) {
         //           case let .toggle(value): break
                        
           //         default:
             //           let value = false
                        
            
               //     }
                    
                    
                        
                    VoteButtonView(vote: .song(song1), voteCount: voteTally.song1, showingVotes: hasVoted || postVotesInChat, disablesVotes: hasVoted && !allowChangingVotes,  backgroundColor: colors[3], textColor: Color.black, onVote: onVote)
                    
                    
                    
                    
                    Spacer(minLength: 16)
                    
                    
                    VoteButtonView(vote: .song(song2), voteCount: voteTally.song2, showingVotes: hasVoted || postVotesInChat, disablesVotes: hasVoted && !allowChangingVotes, backgroundColor: colors[6], textColor: Color.black, onVote: onVote)
                    //                Spacer()
                    
                    
                    Spacer(minLength: 16)
                    
                    VoteButtonView(vote: .random, voteCount: voteTally.random, showingVotes: hasVoted || postVotesInChat, disablesVotes: hasVoted && !allowChangingVotes, backgroundColor: Color.black, textColor: Color.white
                                   , onVote: onVote)
                    

                    
                    
                }
//                .frame(width: geometry.size.width)
                //            .background(LinearGradient(colors: [Color(hex: "#a5ffc9"), Color(hex: "#a5ffc9")], startPoint: .top, endPoint: .bottom))
                //            .background(Color(hex: "#440a67"))
                //            .background(Color(hex: "#d41041"))
                //            .background(LinearGradient(colors: [Color(hex: "#666666"), Color(hex: "#d41041")], startPoint: .top, endPoint: .bottom))
            }
            
        }
//    }
//}

struct VoteButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        VoteButtonsView(nominations: (Song(id: "454", provider: .spotify, title: "Every Little Thing she Does is Magic", artist: "The Police"), Song(id: "String", provider: .spotify, title: "Levels", artist: "Aviici")), voteTally: VoteTally(song1: 5, song2: 4, random: 3), colors: [], allowChangingVotes: false, postVotesInChat: false, onVote: {_ in})
    }	
}

struct VoteButtonView: View {
    var vote: Vote
    var voteCount: Int
    var showingVotes: Bool
    var disablesVotes: Bool
    var backgroundColor: Color
    var textColor: Color
    var onVote: (Vote) -> ()
    
    var body: some View {
        Button(action: {
            var result = onVote(vote)
    //        switch (result) {
   //         case .success(let room):
                
    //        case .failure:
                
          //  }
            
            
        })
        {
            
            HStack {
                
                if (showingVotes) {
                    Text("**\(Image(systemName: "checkmark.square")) \(voteCount)**")
                        .font(Font.system( size: 30))
                        .minimumScaleFactor(0.5)
                        .padding(.trailing, 24)
                }
                
                Spacer(minLength: 0)
                VStack (spacing: 8) {
                    switch vote {
                    case .song(let song):
                        Text("**\(song.title)**")
                            .font(Font.system(size: 30))
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                        
                        
                        Text ("\(song.artist)")
                            .font(Font.system( size: 24))
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                    case .random:
                        Text("**Random**")
                            .font(Font.system( size: 30))
                            .minimumScaleFactor(0.5)

                    }
                
                    
                }
                Spacer(minLength: 0)
                
                
                
            }
            .padding(16)
            .frame(idealWidth: .infinity, maxWidth: .infinity, minHeight: 88, idealHeight: 136, maxHeight: .infinity)
            
            .background(backgroundColor)
            .cornerRadius(24)
            
            .foregroundColor(textColor)
            
            
            
        }
        .disabled(disablesVotes)
        .padding(.horizontal)
    }
}
