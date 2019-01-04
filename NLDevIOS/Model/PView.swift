//
//  PView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 21/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//


import Foundation
import UIKit

class PView {
    var genre: String!
    var type: UIImage!
    var subgenre: [PView]!
    var expanded: Bool!
    
    init(genre: String, type: UIImage, expanded: Bool ,subgenre: [PView]) {
        self.genre = genre
        self.type = type
        self.expanded = expanded
        self.subgenre = subgenre
    }
}
