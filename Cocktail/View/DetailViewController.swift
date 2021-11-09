//
//  DetailViewController.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import UIKit


class DetailViewController: UIViewController {
    
    // MARK: - Properties & View
    
    var drink: Drinks? = nil
    
    private var imageView = UIImageView()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 20)
        return label
    }()
    
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private var ingredientLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate let descriptionLb: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private var scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollview)
        setConstraints()
        setupView()
        navigationController?.navigationBar.isHidden = false
    }
    
    func setConstraints() {
        [contentView,imageView, descriptionLb, categoryLabel, ingredientLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollview.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollview.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollview.topAnchor.constraint(equalTo: view.topAnchor),
            scrollview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollview.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollview.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.35),
            
            descriptionLb.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            descriptionLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            categoryLabel.topAnchor.constraint(equalTo: descriptionLb.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30),
            
            ingredientLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ingredientLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    
    func setupView() {
        title = drink?.drink
        descriptionLb.text = "Instruction: \(drink?.instruction ?? "")"
        categoryLabel.text = "Category: \(drink?.category ?? "")"
        ingredientLabel.text = "Ingredient: \(drink?.ingredient1 ?? ""), \(drink?.ingredient2 ?? ""), \(drink?.ingredient3 ?? ""), \(drink?.ingredient4  ?? ""), \(drink?.ingredient5 ?? "")"
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let imageData = drink?.image {
            imageView.sd_setImage(with:  URL(string: imageData),
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: .continueInBackground,
                                  completed: nil)
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
