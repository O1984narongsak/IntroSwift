//
//  Section.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 14/12/2561 BE.
//  Copyright © 2561 ONaJa. All rights reserved.
//

import Foundation

struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}
