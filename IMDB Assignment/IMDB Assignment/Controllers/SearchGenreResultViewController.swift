//
//  SearchGenreResultViewController.swift
//  IMDB Assignment
//
//  Created by sai krishna reddy avuthu on 11/22/20.
//

import UIKit
import SafariServices

class SearchGenreResultViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var SearchGenreResultTableView: UITableView!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SearchGenreResultTableView.delegate = self
        self.SearchGenreResultTableView.dataSource = self
        self.SearchGenreResultTableView.tableFooterView = UIView()
        self.SearchGenreResultTableView.reloadData()
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SearchGenreResultViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "normalCell") as! NormalCellTableViewCell
        cell.name.text = self.movies[indexPath.row].name
        cell.poster.image = UIImage(named: self.movies[indexPath.row].imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let safariBrowser = SFSafariViewController(url: URL(string: self.movies[indexPath.row].link)!)
        self.present(safariBrowser, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        var numOfSections: Int = 0
        if self.movies.count != 0{
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }else{
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No movies found."
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numOfSections
    }
    
}
