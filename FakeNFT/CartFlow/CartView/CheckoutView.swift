//
//  PaymentView.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 11.10.2023.
//

import UIKit

final class CheckoutView: UIView {
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity) NFT"
        }
    }
    
    private var price: String = "?" {
        didSet {
            totalPriceLabel.text = price + " ETH"
        }
    }
    
    private let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("К оплате", for: .normal)
        button.tintColor = .ypWhite
        button.titleLabel?.font = .Bold.small
        button.backgroundColor = .ypBlack
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let quantityLabel = UILabel()
        quantityLabel.text = "\(quantity) NFT"
        quantityLabel.font = .Regular.medium
        quantityLabel.textColor = .ypBlack
        return quantityLabel
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "\(price) ETH"
        priceLabel.font = .Bold.small
        priceLabel.textColor = .greenUniversal
        return priceLabel
    }()
    
    //MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI setup
    
    private func setupUI() {
        backgroundColor = .ypLightGrey
        
        addSubview(payButton)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payButton.widthAnchor.constraint(equalToConstant: 240),
            payButton.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            payButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(insets.bottom)),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(insets.right))
        ])
        
        addSubview(quantityLabel)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quantityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            quantityLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        ])
        
        addSubview(totalPriceLabel)
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            totalPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(insets.bottom))
        ])
    }
    
    @objc private func payButtonTapped() {
        
    }
    
    func setQuantity(_ newQuantity: Int) {
        quantity = newQuantity
    }
    
    func setTotalprice(_ newPrice: Double) {
        let priceString = String (format: "%.2f", newPrice)
        price = priceString
    }
}