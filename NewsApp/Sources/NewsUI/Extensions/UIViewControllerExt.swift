//
//  UIViewControllerExt.swift
//  
//
//  Created by Egor Yanukovich on 21.08.24.
//

import UIKit

public extension UIViewController {
  func showAlert(
    alertText: String,
    alertMessage: String
  ) {
    let alert = UIAlertController(
      title: alertText,
      message: alertMessage,
      preferredStyle: UIAlertController.Style.alert
    )
    alert.addAction(
      UIAlertAction(
        title: "Ok",
        style: UIAlertAction.Style.default,
        handler: nil
      )
    )

    self.present(alert, animated: true, completion: nil)
  }
}
