//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 11/10/2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let containerView = UIView()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserPic")
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Joaquin Phoenix"
        label.font = UIFont.Bold.medium
        return label
    }()
    
    private let profileBioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        let text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 18
        
        let attrString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, attrString.length)
        
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttribute(.font, value: UIFont.Regular.small ?? UIFont.systemFont(ofSize: 13), range: range)
        
        label.attributedText = attrString
        return label
    }()
    
    private let siteLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        let attributedString = NSMutableAttributedString(string: "Joaquin Phoenix.com")
        attributedString.addAttribute(.link, value: "JoaquinPhoenix.com", range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.font = UIFont.Regular.medium
        return label
    }()
    
    private let profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.rowHeight = 54
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        return tableView
    }()
    
    private let cells = ["Мои NFT", "Избранные NFT", "О разработчике"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        setupView()
        setupNavigationBar()
        setupContainerView()
        setupProfileImageView()
        setupProfileNameLabel()
        setupBioTextField()
        setupSiteLabel()
        setupProfileTableView()
        
        addGesture()
    }
    
    func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        tap.numberOfTapsRequired = 1
        siteLabel.isUserInteractionEnabled = true
        siteLabel.addGestureRecognizer(tap)
    }

    @objc
    func labelTapped(_ tap: UITapGestureRecognizer) {
        let webViewController = WebViewController()
        webViewController.selectedWebSite = "hackingwithswift.com"
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    private func setupView() {
        [containerView, profileImageView, profileNameLabel, profileBioLabel, siteLabel, profileTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "Edit"),
            style: .done,
            target: self,
            action: #selector(editButtonDidTap)
        )
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 162),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupProfileImageView() {
        containerView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupProfileNameLabel() {
        containerView.addSubview(profileNameLabel)
        
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 21),
            profileNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -113),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    private func setupBioTextField() {
        containerView.addSubview(profileBioLabel)
        
        NSLayoutConstraint.activate([
            profileBioLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 90),
            profileBioLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            profileBioLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            profileBioLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18)
        ])
    }
    
    private func setupSiteLabel() {
        view.addSubview(siteLabel)
        
        NSLayoutConstraint.activate([
            siteLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 12),
            siteLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            siteLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupProfileTableView() {
        profileTableView.separatorStyle = .none
        profileTableView.dataSource = self
        profileTableView.delegate = self
        view.addSubview(profileTableView)
        
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: siteLabel.bottomAnchor, constant: 40),
            profileTableView.heightAnchor.constraint(
                equalToConstant: profileTableView.rowHeight * CGFloat(cells.count)
            ),
            profileTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    private func editButtonDidTap() {
        present(ProfileEditingViewController(), animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron.forward"))
        cell.selectionStyle = .none
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = cells[indexPath.row]
            content.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = cells[indexPath.row]
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let myNFTsTableViewController = MyNFTsTableViewController()
            myNFTsTableViewController.navTitle = cells[indexPath.row]
            navigationController?.pushViewController(myNFTsTableViewController, animated: true)
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
}