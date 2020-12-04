//
//  movies.swift
//  IMDB Assignment
//
//  Created by sai krishna reddy avuthu on 11/22/20.
//

import Foundation

class Movie{
    
    var link: String
    var genre: String
    var year: String
    var imageName: String
    var name: String
    
    init(dict: [String: Any]){
        self.link = dict["link"] as! String
        self.genre = dict["genre"] as! String
        self.year = dict["year"] as! String
        self.imageName = dict["imageName"] as! String
        self.name = dict["name"] as! String
    }
    
    init(data: [String: Any]){
        self.link = data["imdbID"] as! String
        self.genre = ""
        self.year = data["Year"] as! String
        self.imageName = data["Poster"] as! String
        self.name = data["Title"] as! String
    }
    
}
