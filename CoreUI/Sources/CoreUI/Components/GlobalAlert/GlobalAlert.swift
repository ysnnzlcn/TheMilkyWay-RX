//
//  GlobalAlert.swift
//  
//
//  Created by Yasin Nazlican on 18.11.2021.
//

import Core
import UIKit

public typealias AlertAction = (title: String, action: VoidClosure?)

public enum GlobalAlert {

    // MARK: Cases

    case simpleAlert(title: String = "", message: String, actionTitle: String)
    case alert(title: String = "", message: String, action: AlertAction)
    case complexAlert(title: String = "", message: String, firstAction: AlertAction, secondAction: AlertAction)

    // MARK: Public Methods

    public func show(on vc: UIViewController) {
        switch self {
        case .simpleAlert(let title, let message, let actionTitle):
            showAlert(on: vc, title: title, message: message, firstAction: AlertAction(actionTitle, action: nil))

        case .alert(let title, let message, let action):
            showAlert(on: vc, title: title, message: message, firstAction: action)

        case .complexAlert(let title, let message, let firstAction, let secondAction):
            showAlert(on: vc, title: title, message: message, firstAction: firstAction, secondAction: secondAction)

        }
    }

    public func show() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        show(on: rootViewController)
    }

    // MARK: Private Methods

    private func showAlert(
        on viewController: UIViewController,
        title: String, message: String,
        firstAction: AlertAction,
        secondAction: AlertAction? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: firstAction.title, style: .default) { (_) in
            firstAction.action?()
        }
        alert.addAction(firstAlertAction)

        if let secondAction = secondAction {
            let secondAlertAction = UIAlertAction(title: secondAction.title, style: .default) { (_) in
                secondAction.action?()
            }
            alert.addAction(secondAlertAction)
        }

        viewController.present(alert, animated: true, completion: nil)
    }
}
