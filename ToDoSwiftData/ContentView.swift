//
//  ContentView.swift
//  ToDoSwiftData
//
//  Created by Rotem Nevgauker on 28/10/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    
    @Environment(\.modelContext) private var context
    
    
    let completeMessage = "Task was completed"
    let deleteMessage = "Task was deleted"
    
    @Query private var  tasks:[Task]

    enum ToastType {
        case none, complete, delete
    }
    @State private var completed = UserDefaults().integer(forKey:"completed")
    @State private var deleted = UserDefaults().integer(forKey:"deleted")

    @State private var showToast = false
    @State private var currentToastType: ToastType = .none
    
    
    func saveNumbers(){
        UserDefaults().set(completed, forKey: "completed")
        UserDefaults().set(deleted, forKey: "deleted")
    }
    private func showToast(type: ToastType) {
        if (!showToast){
            currentToastType = type
            showToast = true
        }
        
    }
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                    Text("Tap to add a task")
                    NavigationLink(destination: NewTaskView()) {
                        Image(systemName: "plus.app")
                    }
                    HStack{
                        Text("completed: ")
                        Text(String(completed))
                        Text("deleted: ")
                        Text(String(deleted))
                    }
                    List{
                        ForEach(tasks){task  in
                            HStack{
                                Text(task.name)
                                Spacer()
                                Button(action: {
                                    context.delete(task)
                                    completed+=1
                                    showToast(type: .complete)
                                    saveNumbers()
                                }) {
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.green) // Adjust the color as needed
                                }
                                .frame(width: 50, height: 50)
                                .contentShape(Rectangle())
                                Button(action: {
                                    context.delete(task)
                                    deleted+=1
                                    showToast(type: .delete)
                                    saveNumbers()
                                }) {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.red) // Adjust the color as needed
                                }
                                .frame(width: 50, height: 50)
                                .contentShape(Rectangle())
                            }
                            .listRowInsets(EdgeInsets())
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        
                    }
                }
            }
        }
        .padding()
        .navigationBarTitle("Tasks", displayMode: .inline)
        if showToast {
            ToastMessage(message: currentToastType == .complete ? completeMessage : deleteMessage)
                .onTapGesture {
                    withAnimation {
                        currentToastType = .none
                        showToast = false
                    }
                }
                .onAppear {
                    // Schedule a timer to dismiss the toast after a delay
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                        withAnimation {
                            showToast = false
                        }
                    }
                }
        }
    }
}
   

struct ToastMessage: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 30) // Adjust the top margin as needed
    }
}



#Preview {
    ContentView()
}
