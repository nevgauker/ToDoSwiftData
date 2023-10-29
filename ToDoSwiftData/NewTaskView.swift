//
//  NewTaskView.swift
//  ToDoSwiftData
//
//  Created by Rotem Nevgauker on 28/10/2023.
//

import SwiftUI

struct NewTaskView: View {
    
    @State private var name: String = ""
    @State private var information: String = ""

    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            Text("New task")
            TextField("Task name", text: $name)
                .textFieldStyle(.roundedBorder)
            GeometryReader { geometry in
                TextEditor(text: $information)
                    .frame(width: geometry.size.width, height: 200)
                    .background(Color.white) // Optional: Set the background color
                    .cornerRadius(10) // Adjust the corner radius here
                    .border(Color.gray, width: 1)
            }
          
            Button("Save"){
                let newTask = Task(name: name, infotmation: information)
                context.insert(newTask)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitle("Second View", displayMode: .inline)
        .padding()

        
    }
}

#Preview {
    NewTaskView()
}
