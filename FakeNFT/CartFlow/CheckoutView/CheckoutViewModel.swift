//
//  CheckoutViewModel.swift
//  FakeNFT
//
//  Created by Aleksey Yakushev on 17.10.2023.
//

import Foundation

final class CheckoutViewModel {
    private var router: CartFlowRouter = CartFlowRouter.shared
    private var orderService: CheckoutServiceProtocol
    private var currencyID: String?
    @Observable private(set) var currencyList: [Currency] = []
    
    init(orderService: CheckoutServiceProtocol = OrderAndPaymentService.shared, currency: Currency? = nil) {
        self.orderService = orderService
        self.orderService.checkoutVM = self
        self.currencyID = currency?.id
    }
    
    func getCurrencyList() {
        currencyID = nil
        orderService.getAllCurrencies()
    }
    
    func setCurrencyList(to newCurrencyList: [Currency]) {
        currencyList = newCurrencyList
    }
    
    func setCurrencyTo(id: String) {
        currencyID = id
    }
    
    func makePayment() {
        guard let id = currencyID else {return}
        orderService.payWith(currecyID: id)
    }
    
    func paymentSuccessfull() {
        router.paymentSuccessfull()
    }
    
    func paymentFailed() {
        router.showPaymentError()
    }
    
    func networkError() {
        self.router.showNetworkError(action: { [weak self] in
            self?.orderService.retry()
        })
    }
}
