//
//  Task.swift
//  ToDoSwiftData
//
//  Created by Rotem Nevgauker on 28/10/2023.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    var id:String
    var name:String
    var infotmation:String
    
    init(name:String,infotmation:String){
        self.id = UUID().uuidString
        self.name = name
        self.infotmation = infotmation
    }
}
