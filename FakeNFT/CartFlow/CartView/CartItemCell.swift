//
//  CartItemCell.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit
import Kingfisher

protocol CartItemCellDelegate {
    func removeItem(id: String)
}

final class CartItemCell: UITableViewCell, ReuseIdentifying {
    private var nft: ItemNFT? = nil
    var delegate: CartItemCellDelegate?
    
    private let insets = UIEdgeInsets(top: 16,
                              left: 16,
                              bottom: 16,
                              right: 16)
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Cart_Delete"), for: .normal)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        button.tintColor = .ypBlack
        button.adjustsImageWhenHighlighted = true
        return button
    }()
    
    private let nftPreview: UIImageView = {
        let nftView = UIImageView()
        nftView.contentMode = .scaleAspectFill
        nftView.clipsToBounds = true
        nftView.layer.cornerRadius = 16
        return nftView
    }()
    
    private let ratingView = RatingView()
    
    private let titleLabel: UILabel = {
       let title = UILabel()
        title.textColor = .ypBlack
        title.font = .Bold.small
        title.text = "Title"
        return title
    }()
    private let priceHeaderLabel: UILabel = {
        let title = UILabel()
         title.textColor = .ypBlack
        title.font = .Regular.small
         title.text = "Цена"
         return title
    }()
    private let priceLabel: UILabel = {
       let title = UILabel()
        title.textColor = .ypBlack
        title.font = .Bold.small
        title.text = "1,23 ETH"
        return title
    }()

//MARK: - UI setup
    func setupCellUI() {
        selectionStyle = .none
        isUserInteractionEnabled = true
        contentView.isHidden = true
        
        addSubview(nftPreview)
        nftPreview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nftPreview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            nftPreview.centerYAnchor.constraint(equalTo: centerYAnchor),
            nftPreview.heightAnchor.constraint(equalToConstant: 108),
            nftPreview.widthAnchor.constraint(equalToConstant: 108)
        ])
        
        addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removeButton.heightAnchor.constraint(equalToConstant: 44),
            removeButton.widthAnchor.constraint(equalToConstant: 44),
            removeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: nftPreview.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets.top + 8)
        ])
        
        addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingView.heightAnchor.constraint(equalToConstant: 12),
            ratingView.widthAnchor.constraint(equalToConstant: 68)
        ])
        ratingView.setRating(to: 4)
        
        addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: nftPreview.trailingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: removeButton.leadingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(insets.bottom) - 8)
        ])
        
        addSubview(priceHeaderLabel)
        priceHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceHeaderLabel.leadingAnchor.constraint(equalTo: nftPreview.trailingAnchor, constant: 20),
            priceHeaderLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -2)
        ])
    }
    
    //MARK: - Configure content
    
    func configureCellFor(nft: ItemNFT) {
        self.nft = nft
        setPrice(nft.price)
        setName(nft.name)
        setRating(UInt(nft.rating))
        setPreviewImage(nft.images.first)
    }
    
    private func setPrice(_ price: Double) {
        priceLabel.text = "\(price) ETH"
    }
    
    private func setRating(_ rating: UInt) {
        ratingView.setRating(to: rating)
    }
    
    private func setName(_ name: String) {
        titleLabel.text = name
    }
    
    private func setPreviewImage(_ imageURLString: String?) {
        if let imageURLString {
            nftPreview.kf.setImage(with: URL(string: imageURLString)!,
                                   placeholder: UIImage(named: "NFT_Placeholder"),
                                   options: [.transition (.fade (0.3))])
        }
    }
    
    //MARK: - Navigation
    
    @objc private func removeButtonTapped() {
        CartFlowRouter.shared.showDeleteConfirmationForNFT(nft,
                                                           removalAction: removeItem)
    }
}

//MARK: - Remove item

extension CartItemCell {
    func removeItem() {
        delegate?.removeItem(id: nft?.id ?? "")
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.25, delay: 0, animations: {
                self.alpha = 0.2
            }, completion: { _ in
                UIView.animate(withDuration: 0.55, delay: 0, options: [.autoreverse, .repeat], animations: {
                    self.alpha = 0.5
                })
            })
        }
    }
}