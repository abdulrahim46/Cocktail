//
//  ViewController.swift
//  Cocktail
//
//  Created by Abdul Rahim on 08/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties & Views

    var collectionView: UICollectionView!
    @IBOutlet var searchBarView: UISearchBar!
    private(set) var loadingIndicator = UIActivityIndicatorView(style: .large)

    
    //MARK:- Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
        collectionView.backgroundColor = .black
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
    }


}



extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.identifier, for: indexPath) as? DrinkCollectionViewCell else {
            fatalError("Could not create ImageCollectionViewCell")
        }
        loadingIndicator.stopAnimating()
        //cell.configureView(cat: cat)
        return cell
    }
}



