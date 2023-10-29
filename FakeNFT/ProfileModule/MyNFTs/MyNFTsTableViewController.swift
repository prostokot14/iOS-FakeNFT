//
//  MyNFTsTableViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 19/10/2023.
//

import UIKit

final class MyNFTsTableViewController: UIViewController {
    var profileViewModel: ProfileViewModel?
    var navTitle: String?
    
    private var profileObserver: NSObjectProtocol?
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activitiIndicator = UIActivityIndicatorView(style: .medium)
        activitiIndicator.color = .ypBlack
        return activitiIndicator
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .ypWhite
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.register(MyNFTsTableViewCell.self, forCellReuseIdentifier: MyNFTsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let label: UILabel = {
        let label = UILabel(text: "У Вас ещё нет NFT")
        label.textColor = .ypBlack
        label.font = UIFont.Bold.small
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        tabBarController?.tabBar.isHidden = true
        
        setupView()
        setupNavigationBar()
        setupTableView()
        setupLabel()
        setupActivityIndicator()

        reloadData()
    }
    
    private func setupNavigationBar() {
        title = navTitle
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Backward"),
            style: .plain,
            target: self,
            action: #selector(backButtonDidTap)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Sort"),
            style: .plain,
            target: self,
            action: #selector(sortButtonDidTap)
        )
    }
    
    private func setupView() {
        [activityIndicator, tableView, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLabel() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func reloadData() {
        let filterStatus = UserDefaults.standard.integer(forKey: "indexOfFilter")
        
        switch filterStatus {
        case 0:
            print(0)
            profileViewModel?.myNFTs?.sort { $0.price < $1.price }
        case 1:
            print(1)
            profileViewModel?.myNFTs?.sort { $0.rating < $1.rating }
        case 2:
            print(2)
            profileViewModel?.myNFTs?.sort { $0.name < $1.name }
        default:
            break
        }
        
        tableView.reloadData()
        activityIndicator.stopAnimating()
        reloadPlaceholderView()
    }
    
    private func reloadPlaceholderView() {
        if let nfts = profileViewModel?.myNFTs {
            if nfts.isEmpty {
                title = ""
                tableView.isHidden = true
                
                view.backgroundColor = .ypWhite
                label.isHidden = false
            }
        }
    }
    
    private func setFilterType(_ type: Int) {
        UserDefaults.standard.set(type, forKey: "indexOfFilter")
        reloadData()
    }
    
    @objc
    private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func sortButtonDidTap() {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .alertColor
        
        alertController.addAction(UIAlertAction(title: "По цене", style: .default) { [weak self] _ in
            self?.setFilterType(0)
        })
        alertController.addAction(UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
            self?.setFilterType(1)
        })
        alertController.addAction(UIAlertAction(title: "По названию", style: .default) { [weak self] _ in
            self?.setFilterType(2)
        })
        alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MyNFTsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileViewModel?.myNFTs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNFTsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MyNFTsTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .ypWhite
        
        guard
            let nft = profileViewModel?.myNFTs?[indexPath.row],
            let authorName = profileViewModel?.authors?[indexPath.row].name
        else {
            return UITableViewCell()
        }
        
        cell.updateNameLabel(nft.name)
        cell.updateRating(nft.rating)
        cell.updatePrice(nft.price)
        cell.updateAuthor(authorName)
        profileViewModel?.getPhoto(imageView: cell.nftImageView, index: indexPath.row, list: .my)
        
        return cell
    }
}