//
//  FirstPageViewController.swift
//  TableChuck+pod
//
//  Created Vladislav Pashkevich on 25.10.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import MBProgressHUD

// MARK: View -
protocol FirstPageViewProtocol: AnyObject {
    
    func reloadData()
    
    func activeMBProgressHUD()
    func deactiveMBProgressHUD()
    func showAlert(message:  String)

}

class FirstPageViewController: UIViewController {
    
    @IBOutlet private weak var tableCategories: UITableView!

	var presenter: FirstPagePresenterProtocol = FirstPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Экран категории"


        presenter.view = self
        presenter.viewDidLoad()
        
        tableCategories.register(UINib(nibName: "FirstTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FirstTableViewCell")
        
    
    }
}

extension FirstPageViewController: FirstPageViewProtocol {
    
    func reloadData() {
        tableCategories.reloadData()
    }
    
    func activeMBProgressHUD() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func deactiveMBProgressHUD() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showAlert(message:  String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Remind Me Tomorrow", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension FirstPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as? FirstTableViewCell else {
            return UITableViewCell()
        }
        cell.update(with: presenter.categoryName(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if presenter.numberOfCategories() == 0 {
            let storyboard = UIStoryboard(name: "SecondPage", bundle: Bundle.main)
            guard let secondPageViewController = storyboard.instantiateViewController(withIdentifier: "SecondPageViewController") as? SecondPageViewController else { return }
            navigationController?.pushViewController(secondPageViewController, animated: true)
            secondPageViewController.presenter.categoryValue(category: presenter.categoryName(for: indexPath))
        } else {
            let storyboard = UIStoryboard(name: "SecondPage", bundle: Bundle.main)
            guard let secondPageViewController = storyboard.instantiateViewController(withIdentifier: "SecondPageViewController") as? SecondPageViewController else { return }
            navigationController?.pushViewController(secondPageViewController, animated: true)
            secondPageViewController.presenter.categoryValue(category: presenter.categoryName(for: indexPath))
        }
    }
    
}
