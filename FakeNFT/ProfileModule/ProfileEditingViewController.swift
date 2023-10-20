//
//  ProfileEditingViewController.swift
//  FakeNFT
//
//  Created by Антон Кашников on 13/10/2023.
//

import UIKit

final class ProfileEditingViewController: UIViewController {
    private let closeButton: UIButton = {
       let button = UIButton()
        button.frame.size = CGSize(width: 42, height: 42)
        button.setImage(UIImage(named: "Close"), for: .normal)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserPic")
        imageView.frame.size = CGSize(width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        return imageView
    }()
    
    private let profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .blackUniversal.withAlphaComponent(0.6)
        view.frame.size = CGSize(width: 70, height: 70)
        view.layer.cornerRadius = view.frame.size.width / 2
        return view
    }()
    
    private let changeProfileImageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .whiteUniversal
        label.text = "Сменить фото"
        label.font = UIFont.Medium.medium
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel = UILabel(text: "Имя")
    
    private let nameTextView = UITextView(text: "Joaquin Phoenix")
    
    private let bioLabel = UILabel(text: "Описание")
    
    private let bioTextView = UITextView(text: "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям.")
    
    private let siteLabel = UILabel(text: "Сайт")
    
    private let siteTextView = UITextView(text: "Joaquin Phoenix.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypWhite
        
        setupView()
        setupCloseButton()
        setupProfileImageView()
        setupProfileView()
        setupChangeProfileImageLabel()
        setupLabel(nameLabel, under: profileImageView)
        setupTextView(nameTextView, under: nameLabel)
        setupLabel(bioLabel, under: nameTextView)
        setupTextView(bioTextView, under: bioLabel)
        setupLabel(siteLabel, under: bioTextView)
        setupTextView(siteTextView, under: siteLabel)
    }
    
    private func setupView() {
        [closeButton, profileImageView, profileView, changeProfileImageLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupProfileImageView() {
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupProfileView() {
        profileImageView.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.widthAnchor.constraint(equalToConstant: 70),
            profileView.heightAnchor.constraint(equalToConstant: 70),
            profileView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            profileView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    private func setupChangeProfileImageLabel() {
        profileImageView.addSubview(changeProfileImageLabel)
        
        NSLayoutConstraint.activate([
            changeProfileImageLabel.leadingAnchor.constraint(
                equalTo: profileImageView.leadingAnchor,
                constant: 12
            ),
            changeProfileImageLabel.trailingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: -13
            ),
            changeProfileImageLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor)
        ])
    }
    
    private func setupLabel(_ label: UILabel, under topView: UIView) {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupTextView(_ textView: UITextView, under topView: UIView) {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc
    private func closeButtonDidTap() {
        dismiss(animated: true)
    }
}