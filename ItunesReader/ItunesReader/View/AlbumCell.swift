//
//  AlbumCell.swift
//  ItunesReader
//
//  Created by Licheng Zheng on 2020/2/7.
//  Copyright © 2020 Licheng Zheng. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    var albumImage = UIImageView()
    var albumTitle = UILabel()
    var albumArtist = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        configureCell()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Initializing cell data
    func set(album: results) {
        if let url = URL(string: album.artworkUrl100) {
            albumImage.load(url: url)
        }
        albumTitle.text = album.name
        albumArtist.text = album.artistName
    }
    
    //Add all the components to the cell
    func addSubviews() {
        addSubview(albumImage)
        addSubview(albumTitle)
        addSubview(albumArtist)
    }
    
    //Configure the components of the cell
    func configureCell() {
        configureImage()
        configureTitle()
        configureArtist()
        configureSeparator()
    }
    
    //Setup the constraints for the components of the cell
    func setConstraints() {
        setImageConstrains()
        setTitleConstrains()
        setArtistConstrains()
    }
    
    func configureImage() {
        albumImage.layer.cornerRadius = 10
        albumImage.clipsToBounds = true
        albumImage.layer.borderWidth = 0.1
        albumImage.layer.borderColor = UIColor.gray.cgColor
    }
    
    func configureTitle() {
        albumTitle.numberOfLines = 0
        albumTitle.adjustsFontSizeToFitWidth = true
    }
    
    func configureArtist() {
        albumArtist.numberOfLines = 0
        albumArtist.adjustsFontSizeToFitWidth = true
        albumArtist.font = UIFont.systemFont(ofSize: 14)
        albumArtist.textColor = .gray
    }

    func configureSeparator() {
        self.separatorInset.left = 90
    }
    
    func setImageConstrains() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        albumImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setTitleConstrains() {
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        albumTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        albumTitle.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }

    func setArtistConstrains() {
        albumArtist.translatesAutoresizingMaskIntoConstraints = false
        albumArtist.topAnchor.constraint(equalTo: albumTitle.bottomAnchor).isActive = true
        albumArtist.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumArtist.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
