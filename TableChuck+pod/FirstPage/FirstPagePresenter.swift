//
//  FirstPagePresenter.swift
//  TableChuck+pod
//
//  Created Vladislav Pashkevich on 25.10.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import Alamofire

// MARK: Presenter -
protocol FirstPagePresenterProtocol {
    var view: FirstPageViewProtocol? { get set }
    func viewDidLoad()
    
    func categoryName(for indexPath: IndexPath) -> String
    func numberOfCategories() -> Int
    
    func saveCoreData()
}

class FirstPagePresenter: FirstPagePresenterProtocol {
    
    weak var view: FirstPageViewProtocol?
    
    private var categoriesNow: [Categories] = []
    
    func viewDidLoad() {
        saveCoreData()
    }
    
    func saveCoreData() {
        //        из базы данных закинуть в массив
        DatabaseService.shared.entitiesFor(
            type: Categories.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { value in
                self.categoriesNow = value
                
                if self.categoriesNow.count == 0 {
                    self.view?.activeMBProgressHUD()
                    guard let url = URL(string: "https://api.chucknorris.io/jokes/categories") else {
                        return
                    }
                    // [String].self -  если возвращается с сервера конкретные данные - если возвращается в формате json ключ: значение - то надо делать структуру и возвращаться только то что нам надо и проиписывать вместо string  - name struct
                    
                    AF.request(url, method: .get).responseDecodable(of: [String].self) { response in
                        switch response.result {
                        case .success(let result):
                            var categoriesValue = result
                            //сохран в CoreData
                            categoriesValue.insert("Random", at: 0)
                            // пробигаемся по полученному массиву
                            for value in categoriesValue {
                                DatabaseService.shared.insertEntityFor(
                                    type: Categories.self,
                                    context: DatabaseService.shared.persistentContainer.mainContext,
                                    closure: { nameCategory in
                                        nameCategory.note = value
                                        self.categoriesNow.append(nameCategory)
                                        DatabaseService.shared.saveMain(nil)
                                        print(self.categoriesNow)
                                        self.view?.reloadData()
                                        self.view?.deactiveMBProgressHUD()
                                    }
                                )
                                //в CoreData хранится не массив а элементы --- а получаем из CoreData массив
                            }
                            
                        case .failure(let err):
                            self.view?.showAlert(message: err.localizedDescription)
                        }
                    }
                } else {
                    print("CoreData categories is not Empty")
                    self.view?.reloadData()
                    self.view?.deactiveMBProgressHUD()
                }
            }
        )
        
        
    }
    
    func categoryName(for indexPath: IndexPath) -> String {
        return categoriesNow[indexPath.row].note
        
    }
    func numberOfCategories() -> Int {
        return categoriesNow.count
    }
    
    
    
    
}

