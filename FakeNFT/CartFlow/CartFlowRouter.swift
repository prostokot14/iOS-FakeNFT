//
//  CartFlowRouter.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 15.10.2023.
//

import UIKit

final class CartFlowRouter {
    static var shared = CartFlowRouter()
    weak var cartVC: CartViewController?
    weak var checkoutVC: CheckoutViewController?
    
    private init() {
        
    }
    
    func showPaymentError() {
        let alert = UIAlertController(title: "Упс! Что-то пошло не так :(",
                                      message: "Попробуйте ещё раз!",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        
        checkoutVC?.present(alert, animated: true)
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Упс! Что-то пошло не так :(",
                                      message: "Попробуйте ещё раз!",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        
        cartVC?.present(alert, animated: true)
    }
    
    func showSortSheet() {
        let sortSheet = UIAlertController(title: "Сортировка",
                                          message: nil,
                                          preferredStyle: .actionSheet)
        
        let price = UIAlertAction(title: "По цене", style: .default) {[weak self] _ in
            self?.cartVC?.setSorting(to: .price)
        }
        sortSheet.addAction(price)
        
        let rating = UIAlertAction(title: "По рейтингу", style: .default) {[weak self]  _ in
            self?.cartVC?.setSorting(to: .rating)
        }
        sortSheet.addAction(rating)
        
        let title = UIAlertAction(title: "По названию", style: .default) {[weak self] _ in
            self?.cartVC?.setSorting(to: .title)
        }
        sortSheet.addAction(title)
        
        let close = UIAlertAction(title: "Закрыть", style: .cancel)
        sortSheet.addAction(close)
        
        cartVC?.present(sortSheet, animated: true)
    }
    
    func showPaymentScreen() {
        let checkout = CheckoutViewController()
        checkoutVC = checkout
        cartVC?.show(checkout, sender: nil)
    }
}
