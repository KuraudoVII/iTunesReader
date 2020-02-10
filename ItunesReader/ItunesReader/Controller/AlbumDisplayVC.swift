//
//  AlbumDisplayVC.swift
//  ItunesReader
//
//  Created by Licheng Zheng on 2020/2/7.
//  Copyright © 2020 Licheng Zheng. All rights reserved.
//

import UIKit

class AlbumDisplayVC: UIViewController {

    var albumImage = UIImageView()
    var albumTitle = UILabel()
    var albumArtist = UILabel()
    var albumGenre = UILabel()
    var albumReleaseDate = UILabel()
    var albumCopyRight = UILabel()
    var goToItunesButton = UIButton()
    var itunesURL = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        configureSubviews()
        setSubviewConstraints()
        checkForDarkMode()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        checkForDarkMode()
    }
    
    //To make sure the background and button colors conforms to Dark Mode
    func checkForDarkMode() {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        if userInterfaceStyle == .dark {
            view.backgroundColor = .black
            goToItunesButton.backgroundColor = .darkGray
        } else if userInterfaceStyle == .light {
            view.backgroundColor = .white
            goToItunesButton.backgroundColor = .systemGray5
        }
    }
    
    //Initializing all the variables in this view with data passed from the corresponding cell
    func AlbumInit(album: results) {
        if let url = URL(string: album.artworkUrl100) {
            albumImage.load(url: url)
        }
        albumTitle.text = album.name
        albumArtist.text = album.artistName
        albumGenre.text = album.genres?[0].name ?? "N/A"
        albumReleaseDate.text = album.releaseDate
        albumCopyRight.text = album.copyright
        itunesURL = album.url.absoluteString
    }
    
    //Add all the components to the view
    func addSubviews() {
        view.addSubview(albumImage)
        view.addSubview(albumTitle)
        view.addSubview(albumArtist)
        view.addSubview(albumGenre)
        view.addSubview(albumReleaseDate)
        view.addSubview(albumCopyRight)
        view.addSubview(goToItunesButton)
    }
    
    //Configure all the components of this view
    func configureSubviews() {
        configureImage()
        configureTitle()
        configureArtist()
        configureGenre()
        configureReleaseDate()
        configureCopyRight()
        configureButton()
    }
    
    //Setup all the constraints of each components of this view
    func setSubviewConstraints() {
        setImageConstraint()
        setTitleConstraint()
        setArtistConstraint()
        setGenreConstraint()
        setReleaseDateConstraint()
        setButtonConstraint()
        setCopyRightConstraint()
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
        albumTitle.font = UIFont.systemFont(ofSize: 20)
    }
    
    func configureArtist() {
        albumArtist.numberOfLines = 0
        albumArtist.adjustsFontSizeToFitWidth = true
        albumArtist.font = UIFont.systemFont(ofSize: 20)
        albumArtist.textColor = .red
    }
    
    func configureGenre() {
        albumGenre.numberOfLines = 0
        albumGenre.adjustsFontSizeToFitWidth = true
        albumGenre.font = UIFont.systemFont(ofSize: 20)
        albumGenre.textColor = .gray
    }
    
    func configureReleaseDate() {
        albumReleaseDate.numberOfLines = 0
        albumReleaseDate.adjustsFontSizeToFitWidth = true
        albumReleaseDate.font = UIFont.systemFont(ofSize: 20)
        albumReleaseDate.textColor = .gray
    }
    
    func configureCopyRight() {
        albumCopyRight.numberOfLines = 1
//        albumCopyRight.adjustsFontSizeToFitWidth = true
        albumCopyRight.font = UIFont.systemFont(ofSize: 10)
        albumCopyRight.textColor = .gray
        albumCopyRight.lineBreakMode = .byTruncatingTail
    }
    
    func configureButton() {
        goToItunesButton.layer.cornerRadius = 10
        goToItunesButton.setTitle("Go to itunes", for: .normal)
        goToItunesButton.setTitleColor(.red, for: .normal)
        goToItunesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        goToItunesButton.backgroundColor = .systemGray5
        
        goToItunesButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func setImageConstraint() {
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        albumImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        albumImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        albumImage.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func setTitleConstraint() {
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        albumTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        albumTitle.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    func setArtistConstraint() {
        albumArtist.translatesAutoresizingMaskIntoConstraints = false
        albumArtist.topAnchor.constraint(equalTo: albumTitle.bottomAnchor).isActive = true
        albumArtist.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumArtist.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    func setGenreConstraint() {
        albumGenre.translatesAutoresizingMaskIntoConstraints = false
        albumGenre.topAnchor.constraint(equalTo: albumArtist.bottomAnchor).isActive = true
        albumGenre.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
        albumGenre.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
    }
    
    func setReleaseDateConstraint() {
        albumReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        albumReleaseDate.topAnchor.constraint(equalTo: albumGenre.bottomAnchor).isActive = true
        albumReleaseDate.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 20).isActive = true
    }
    
    func setCopyRightConstraint() {
        albumCopyRight.translatesAutoresizingMaskIntoConstraints = false
        albumCopyRight.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 5).isActive = true
        albumCopyRight.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        albumCopyRight.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func setButtonConstraint() {
        goToItunesButton.translatesAutoresizingMaskIntoConstraints = false
        goToItunesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goToItunesButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        goToItunesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        goToItunesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        goToItunesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    //When clicked, jumps to the corresponding page in itunes (does not work in stimulation)
    @objc func buttonAction() {
        if let url = URL(string: itunesURL) {
            print(url.absoluteString)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
