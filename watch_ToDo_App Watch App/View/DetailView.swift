//
//  DetailView.swift
//  watch_ToDo_App Watch App
//
//  Created by english on 2025-02-19.
//

import SwiftUI

struct DetailView: View {
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3){
            HStack{
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }.foregroundStyle(.accent)
            Spacer()
            ScrollView {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            HStack(alignment: .center){
                Image(systemName: "gear")
                Spacer()
                Text("\(count)/\(index)")
                Spacer()
                Image(systemName: "info.circle")
            }
            .foregroundStyle(.secondary)
        }.padding()
    }
}

#Preview {
    DetailView(note: Note(id: UUID(), text: "something"), count: 10, index: 1)
}
