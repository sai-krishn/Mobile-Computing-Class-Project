//
//  ViewController.swift
//  IMDB App
//
//  Created by sai krishan reddy avuthu on 11/19/20.
//

import UIKit
import DropDown

class BrowseByGenreViewController: UIViewController {
    
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var genre: UITextField!
    
    private var dropDownYear:DropDown = DropDown()
    private var dropDownGenre:DropDown = DropDown()
    
    private var movies = [Movie]()
    private var movieResults = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    private func setup(){
        self.prepareData()
        self.setupYear()
        self.setupGenre()
    }

    @IBAction func selectYear(_ sender: Any) {
        self.dropDownYear.show()
    }
    
    @IBAction func selectGenre(_ sender: Any) {
        self.dropDownGenre.show()
    }
    
    @IBAction func search(_ sender: Any) {
        if let year = self.year.text, let genre = self.genre.text{
            if year != "" && genre != ""{
                let genre = genre.lowercased()
                let movieResults = self.movies.filter({$0.genre == genre && $0.year == year})
                self.movieResults = movieResults
                self.performSegue(withIdentifier: "toSearchGenreResults", sender: nil)
            }else{
                self.showAlert(title: "Error", message: "Please fill all fields")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchGenreResults"{
            let vc = segue.destination as! SearchGenreResultViewController
            vc.movies = self.movieResults
        }
    }
    
}

extension BrowseByGenreViewController{
    
    private func prepareData(){
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            if let movies = NSArray(contentsOfFile: path){
                for i in movies{
                    self.movies.append(Movie(dict: i as! [String: String]))
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupYear(){
        let dropDown = DropDown()
        dropDown.anchorView = self.year
        dropDown.dismissMode = .automatic
        var yrs = [String]()
        yrs.append("2019")
        yrs.append("2020")
        dropDown.dataSource = yrs
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.year.text = item
        }
        self.dropDownYear = dropDown
    }
    
    private func setupGenre(){
        let dropDown = DropDown()
        dropDown.dismissMode = .automatic
        dropDown.anchorView = self.genre
        if let path = Bundle.main.path(forResource: "genre", ofType: "plist") {
            if let movies = NSArray(contentsOfFile: path){
                for i in movies{
                    dropDown.dataSource.append(i as! String)
                }
            }
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.genre.text = item
        }
        self.dropDownGenre = dropDown
    }
    
}
