//
//  ContentView.swift
//  watch_ToDo_App Watch App
//
//  Created by english on 2025-02-19.
//

import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    // func to save the notes
    func save() {
        do{
            let data = try JSONEncoder().encode(notes)
            
            let url = getDocumentsDirectory().appendingPathComponent("notes")
            
            try data.write(to: url)
        }catch{
            print("Failed to save the notes")
        }
    }
    // func to load the notes
    func load() {
        DispatchQueue.main.async{
            do {
                let url = getDocumentsDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                
                notes = try JSONDecoder().decode([Note].self, from: data)
            }catch{
                // nothing
            }
        }
    }
    
    // get the path -> where you store the notes
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    func delete(offsets: IndexSet){
        withAnimation{
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    var body: some View {

        
        VStack {
            HStack(alignment: .center, spacing: 4){
                TextField("Add a note", text: $text)
                Button {
                    print("Saving note")
                    guard text.isEmpty == false else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42,weight: .semibold))
                }.fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundStyle(.accent)
            }
            Spacer()
                                    
            //List
            if notes.count >= 1 {
                List {
                    ForEach(0..<notes.count, id: \.self){
                        i in
                        NavigationLink{
                            DetailView(note: notes[i], count: notes.count, index: i)
                        } label: {
                            HStack{
                                // vertical divider
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundStyle(.accent)
                                Text(self.notes[i].text)
                                    .lineLimit(1)
                                    .padding(.leading, 5)
                            }
                        }
                    }.onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .padding(20)
                Spacer()
            }
        }
        .navigationTitle("Notes")
        .onAppear(){
            load()
        }
    }
}

#Preview {
    ContentView()
}
