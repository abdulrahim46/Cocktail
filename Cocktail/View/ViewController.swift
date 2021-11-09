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
        //        let layoutSectionHeader = createSectionHeader()
        //        section.boundarySupplementaryItems = [layoutSectionHeader]
        //        return section
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView  = collectionView else { return }
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        collectionView.register(UINib(nibName: "DrinkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DrinkCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "StaticCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: StaticCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        ///tells the system we will define our own constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //
        /// Constraining the collection view to the 4 edges of the view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupView()
    }
    
    
    /// Creates a Layout for the SectionHeader
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        /// Define size of Section Header
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                             heightDimension: .estimated(80))
        
        /// Construct Section Header Layout
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    
    private func setupView() {
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
    
    //MARK: Fetching drinks
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            viewModel.fetchDrinks(query: searchText)
            collectionView.reloadData()
            collectionView.isHidden = false
        }
    }
}


//MARK:- collectionview delegates

extension ViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? 1 : viewModel.drinks?.drinks.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticCollectionViewCell.identifier, for: indexPath) as? StaticCollectionViewCell else {
                fatalError("Could not create StaticCollectionViewCell")
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCollectionViewCell.identifier, for: indexPath) as? DrinkCollectionViewCell else {
                fatalError("Could not create DrinkCollectionViewCell")
            }
            if let drink = viewModel.drinks?.drinks[indexPath.row] {
                cell.configure(with: drink)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 100)
        }  else {
            let size = (view.frame.size.width/2) - 1
            return CGSize(width: size, height: size)
        }
    }
    
    ///  Section Headers for collectionview
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifier, for: indexPath) as? SectionHeader else {
            fatalError("Could not dequeue SectionHeader")
        }
        if indexPath.section == 0 {
            headerView.titleLabel.isHidden = false
            headerView.subtitleLabel.isHidden = false
            headerView.titleLabel.text = "Near Restaurant"
        } else {
            headerView.titleLabel.isHidden = true
            headerView.subtitleLabel.isHidden = true
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 60)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
}



