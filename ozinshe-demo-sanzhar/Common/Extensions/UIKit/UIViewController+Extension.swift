//
//  UIViewController+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
private var isTabBarHidden = false

extension UIViewController {
    
    /// Sets the visibility of the tab bar.
    ///
    /// - Parameter hidden: A Boolean value indicating whether the tab bar should be hidden.

    func setTabBarHidden(_ hidden: Bool) {
        guard hidden != isTabBarHidden else { return } 
        
        if hidden {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                if let tabBarFrame = self.tabBarController?.tabBar.frame {
                    self.tabBarController?.tabBar.frame.origin.y = self.navigationController?.view.frame.maxY ?? 0 - tabBarFrame.height
                }
                self.navigationController?.view.layoutIfNeeded()
            }
        } else {
            self.tabBarController?.tabBar.isHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                if let tabBarFrame = self.tabBarController?.tabBar.frame {
                    self.tabBarController?.tabBar.frame.origin.y = (self.navigationController?.view.frame.maxY ?? 0) - tabBarFrame.height
                }
                self.navigationController?.view.layoutIfNeeded()
            } completion: { _ in
                self.tabBarController?.tabBar.isHidden = hidden
            }
        }
        isTabBarHidden = hidden
    }

    
    /// Sets the navigation bar to be hidden and transparent.
    ///
    /// - Note: Only available on iOS 15 and later.
    func setNavigationBarHidden() {
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            navigationController?.navigationBar.compactAppearance = navigationBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            let backButton = UIBarButtonItem()
            backButton.title = ""
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }
    
    /// Presents a share pop-up with the specified title, message, and optional image.
    ///
    /// - Parameters:
    ///   - title: The title for the share pop-up.
    ///   - message: The message to be shared.
    ///   - image: The optional image to be shared.
    func presentSharePopup(title: String, message: String, image: UIImage? = nil) {
        var itemsToShare: [Any] = [ActivityItemSource(title: title, text: message)]
        
        if let image = image {
            itemsToShare.append(image)
        }
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // Customize the excluded activity types if needed
        activityViewController.excludedActivityTypes = [
            .assignToContact,
            .print,
            .addToReadingList,
            .saveToCameraRoll,
            .openInIBooks,
            UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"),
            UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension")
        ]
        
        // Present the share pop-up
        present(activityViewController, animated: true, completion: nil)
    }
    
    /// Dismisses the keyboard when tapped outside of the keyboard area.
    ///
    /// - Parameter sender: The gesture recognizer that triggers the dismissal.
    @objc func dismissKeyboardFromView(sender: UITapGestureRecognizer?) {
            let view = sender?.view
            view?.endEditing(true)
    }
    
    
}
