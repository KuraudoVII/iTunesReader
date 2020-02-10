//
//  AlbumListVC.swift
//  ItunesReader
//
//  Created by Licheng Zheng on 2020/2/7.
//  Copyright © 2020 Licheng Zheng. All rights reserved.
//

import UIKit

class AlbumListVC: UIViewController {

    var tableView = UITableView()
    var albums = [results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top 100"
        albums = fetchData()
        configureTableView()
    }
    
    //Configure the table view
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        setTableViewConstraint()
        tableView.rowHeight = 80
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "albumCell")
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setTableViewConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}

//Formats the cells with the custom AlbumCell
extension AlbumListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell") as? AlbumCell
        let album = albums[indexPath.row]
        
        cell?.set(album: album)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumDisplayVC()
        let album = albums[indexPath.row]
        
        vc.AlbumInit(album: album)

        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//Fetch the data from the provided json file from rss.itunes.apple.com
extension AlbumListVC {
        
    func fetchData() -> [results] {
        let urlString =  "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()

                if let jsonAlbums = try? decoder.decode(Album.self, from: data) {
                    if let topResults = jsonAlbums.feed.results {
                        return topResults
                    }
                }
            }
        }
        return albums
    }
}

//Extension function to load image from an url to image view
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
