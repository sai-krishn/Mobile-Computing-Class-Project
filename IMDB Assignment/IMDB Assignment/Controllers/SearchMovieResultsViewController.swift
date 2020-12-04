//
//  SearchMovieResultsViewController.swift
//  IMDB Assignment
//
//  Created by sai krishna reddy avuthu on 11/22/20.
//

import UIKit
import SDWebImage
import SafariServices

class SearchMovieResultsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var SearchMovieResultsTableView: UITableView!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchMovieResultsTableView.delegate = self
        self.SearchMovieResultsTableView.dataSource = self
        self.SearchMovieResultsTableView.reloadData()
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchMovieResultsViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") as! ButtonCellTableViewCell
        cell.name.text = self.movies[indexPath.row].name
        cell.year.text = self.movies[indexPath.row].year
        cell.poster.sd_setImage(with: URL(string: self.movies[indexPath.row].imageName), placeholderImage: UIImage(named: "poster"), context: nil)
        cell.imdbBtn.tag = indexPath.row
        cell.imdbBtn.addTarget(self, action: #selector(openIMDB(sender:)), for: .touchUpInside)
        let v = UIView()
        v.backgroundColor = .clear
        cell.selectedBackgroundView = v
        return cell
    }
    
    @objc func openIMDB(sender: UIButton){
        let safariBrowser = SFSafariViewController(url: URL(string: "https://www.imdb.com/title/"+self.movies[sender.tag].link)!)
        self.present(safariBrowser, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
