//
//  BottomSheetViewController.swift
//  WhatToDo
//
//  Created by Ivan Volokitin on 03.05.2020.
//  Copyright © 2020 Ivan Volokitin. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 130, width: view.frame.width, height: view.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func panGestureRecognizer(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: view)
        
        if (view.frame.minY + translation.y >= 100) && (view.frame.minY + translation.y <= (UIScreen.main.bounds.height - 130)) {
            view.frame = CGRect(x: 0, y: view.frame.minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
        
        if recognizer.state == .ended {
            let velocity = recognizer.velocity(in: view)
            UIView.animate(withDuration: 1, delay: 0.0, options: [.allowUserInteraction], animations: {
                if velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 130, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height)
                }
            }, completion: nil)
        }
    }
}
