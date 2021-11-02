//
//  SecondPageViewController.swift
//  TableChuck+pod
//
//  Created Vladislav Pashkevich on 2.11.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import MBProgressHUD
import SDWebImage

// MARK: View -
protocol SecondPageViewProtocol: AnyObject {
    func activeMBProgressHUD()
    
    func deactiveMBProgressHUD()
    
    func showAlert(message:  String)
    
    func setValueJoke(joke: String, imageUrl: String)

}

class SecondPageViewController: UIViewController {
    
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    

	var presenter: SecondPagePresenterProtocol = SecondPagePresenter()

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
    }
}

extension SecondPageViewController: SecondPageViewProtocol {
    
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
    
    func setValueJoke(joke: String, imageUrl: String) {
        textLabel.text = joke
        //с помощью SDWebImage сразу вставляем картинку по url в imageView
        imageView.sd_setImage(with: URL(string: imageUrl))
    }
}
