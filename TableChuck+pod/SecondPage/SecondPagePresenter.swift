//
//  SecondPagePresenter.swift
//  TableChuck+pod
//
//  Created Vladislav Pashkevich on 2.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import Alamofire

// MARK: Presenter -
protocol SecondPagePresenterProtocol {
    var view: SecondPageViewProtocol? { get set }
    func viewDidLoad()
    
    func categoryValue(category: String)
}

class SecondPagePresenter: SecondPagePresenterProtocol {
    
    weak var view: SecondPageViewProtocol?
    
    private let nameCategories: String = ""
    
    func viewDidLoad() {
        
    }
    
    func categoryValue(category: String) {
        if category == "Random" {
            self.view?.activeMBProgressHUD()
            guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
                return
            }
            AF.request(url, method: .get).responseDecodable(of: Joke.self) { response in
                switch response.result {
                case .success(let result):
                    self.view?.setValueJoke(joke: result.value, imageUrl: result.iconURL)
                    self.view?.deactiveMBProgressHUD()
                case .failure(let err):
                    self.view?.showAlert(message: err.localizedDescription)
                }
            }
        } else {
            self.view?.activeMBProgressHUD()
            guard let url = URL(string: "https://api.chucknorris.io/jokes/random?category=\(category)") else { return }
            AF.request(url, method: .get).responseDecodable(of: Joke.self) { response in
                switch response.result {
                case .success(let result):
                    self.view?.setValueJoke(joke: result.value, imageUrl: result.iconURL)
                    self.view?.deactiveMBProgressHUD()
                case .failure(let err):
                    self.view?.showAlert(message: err.localizedDescription)
                }
            }
        }
    }
}



