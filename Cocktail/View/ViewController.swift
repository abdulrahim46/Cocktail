//
//  ViewController.swift
//  Cocktail
//
//  Created by Abdul Rahim on 08/11/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    // MARK: - Properties & Views
    
    var collectionView: UICollectionView!
    @IBOutlet var searchBarView: UISearchBar!
    private(set) var loadingIndicator = UIActivityIndicatorView(style: .large)
    
    let viewModel = CocktailViewModel()
    var anyCancelable = Set<AnyCancellable>()
    
    //MARK:- Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchDrinks()
    }
    
    
    
    //MARK:- View Setup
    
    /// setup collectionview
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = (view.frame.size.width/2) - 1
        layout.itemSize = CGSize(width: size, height: size)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView  = collectionView else { return }
        collectionView.register(UINib(nibName: "DrinkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DrinkCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        // collectionView.frame = view.bounds
        
        //        ///tells the system we will define our own constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //
        /// Constraining the collection view to the 4 edges of the view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        //        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        //        collectionView.register(TopSectionCollectionViewCell.self, forCellWithReuseIdentifier: TopSectionCollectionViewCell.reuseIdentifier)
        //        collectionView.register(BottomSectionCollectionViewCell.self, forCellWithReuseIdentifier: BottomSectionCollectionViewCell.reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        searchBarView.sizeToFit()
        searchBarView.delegate = self
        searchBarView.placeholder = "Search drinks"
    }
    
    
    private func fetchDrinks() {
        viewModel.fetchDrinks(query: "")
        viewModel.$drinks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] drinks in
                self?.collectionView.reloadData()
                self?.loadingIndicator.stopAnimating()
            }
            .store(in: &anyCancelable)
        
    }
    
    
}

//MARK:- Searchbar delegates

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        collectionView.isHidden = true
        //print("Search bar editing did begin..")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        collectionView.isHidden = false
        //print("Search bar editing did end..")
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        search(shouldShow: false)
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            viewModel.fetchDrinks(query: searchText)
            collectionView.reloadData()
            collectionView.isHidden = false
        }
    }
}



extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drinks?.drinks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.identifier, for: indexPath) as? DrinkCollectionViewCell else {
            fatalError("Could not create ImageCollectionViewCell")
        }
        if let drink = viewModel.drinks?.drinks[indexPath.row] {
            cell.configure(with: drink)
        }
        return cell
    }
}



