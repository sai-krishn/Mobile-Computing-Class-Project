//
//  SearchMoviesViewController.swift
//  IMDB Assignment
//
//  Created by sai krishan reddy avuthu on 11/22/20.
//

import UIKit
import NVActivityIndicatorView

class SearchMoviesViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var loader: NVActivityIndicatorView!
    
    private var selectedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func search(_ sender: Any) {
        if let year = self.year.text, let title = self.name.text, let type = self.type.text{
            if year == "" && type == "" && title == ""{
                self.showAlert(title: "Error", message: "Please fill atleast one field")
            }else{
                var link = "https://www.omdbapi.com/?apikey=748791d"
                if year != ""{
                    link = link + "&y=\(year)"
                }
                if title != ""{
                    link = link + "&s=\(title.lowercased())"
                }else{
                    link = link + "&s= "
                }
                if type != ""{
                    link = link + "&type=\(type.lowercased())"
                }
                link = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let url = URL(string: link)!
                self.loader.startAnimating()
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    DispatchQueue.main.async { [self] in
                        loader.stopAnimating()
                        if let error = error{
                            self.showAlert(title: "Error", message: error.localizedDescription)
                        }
                        guard let data = data else { return }
                        do{
                            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]{
                                if let resp = json["Response"] as? String{
                                    if resp == "False"{
                                        self.showAlert(title: "Error", message: "\(json["Error"] as! String)")
                                    }else{
                                        let movieArr = json["Search"] as! [[String: Any]]
                                        var movies = [Movie]()
                                        for i in movieArr{
                                            movies.append(Movie(data: i))
                                        }
                                        self.selectedMovies = movies
                                        self.performSegue(withIdentifier: "toSearchMovieResults", sender: nil)
                                    }
                                }
                            }
                        }catch{
                            self.showAlert(title: "Error", message: "Something went wrong")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchMovieResults"{
            let vc = segue.destination as! SearchMovieResultsViewController
            vc.movies = self.selectedMovies
        }
    }
    
}

extension SearchMoviesViewController{
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
