//
//  DetailVC.swift
//  TheMovieDB
//
//  Created by Egemen Inceler on 14.07.2021.
//

import UIKit

class DetailVC: UIViewController {

    let imageView  = UIImageView()
    let headerText = UITextView()
    let text       = UITextView()
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.title = "Content Details"
        
        view.backgroundColor = .systemBackground
        configureImageView()
        configureHeaderText()
        configureText()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = "Content Details"
        
        setStar()
    }
    
    private func setStar(){
        if self.movie!.isFavoried{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.starfill, style: .plain, target: self, action: #selector(didFavoriteButtonClicked))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.star, style: .plain, target: self, action: #selector(didFavoriteButtonClicked))
        }
    }
    
    
    func setValues(movie: Movie){
        guard let imageData = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w200/"+movie.imageURL)!) else { return }
        
        self.movie = movie
        imageView.image = UIImage(data: imageData)
        NetworkManager.shared.getMovieDetail(movieID: movie.id) { (response) in
            guard let response   = response else { return }
            DispatchQueue.main.async {
                self.headerText.text = response.original_title
                self.text.text       = response.overview
                
            }
        }
        DispatchQueue.main.async {
            DatabaseManager.shared.searchData(id: movie.id) { (success) in
                if success{
                    movie.isFavoried = true
                }
            }
        }
    }
    
    @objc private func didFavoriteButtonClicked(){
        if self.movie!.isFavoried{
            DatabaseManager.shared.deleteData(id: self.movie!.id) { (success) in
                if success{
                    self.movie?.isFavoried = false
                    setStar()
                }else{
                    print("silinemedi")
                }
            }
        }else{
            DatabaseManager.shared.insertData(movie: self.movie!) { (success) in
                if success{
                    self.movie?.isFavoried = true
                    setStar()
                }else{
                    print("olmadı")
                }
            }
        }
    }
    
    private func configureImageView(){
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureHeaderText(){
        view.addSubview(headerText)
        headerText.backgroundColor = .systemBackground
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerText.font = .boldSystemFont(ofSize: 24)
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            headerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureText(){
        view.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .systemBackground
        text.font = UIFont(name: "Helvetica", size: 15)
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: padding),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            text.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    

}
