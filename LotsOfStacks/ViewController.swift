//
//  ViewController.swift
//  LotsOfStacks
//
//  Created by Don Mag on 5/18/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}


}

class LotsOfStacksViewController: UIViewController {
	
	var myArray: [UIView] = [UIView]()
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// get array of all stack views
		let allStacks: [UIStackView] = view.subviews(ofType: UIStackView.self)
		// loop through all stack views
		allStacks.forEach { sv in
			// loop through arrangedSubviews
			sv.arrangedSubviews.forEach { subview in
				// if it's NOT another UIStackView
				if subview.classForCoder != UIStackView.self {
					// append the arrangedSubview to myArray
					myArray.append(subview)
				}
			}
		}

		print("Found", myArray.count, "arranged Subviews")

	}
	
	@IBAction func didTap(_ sender: Any) {
		
		calculateTime {
			
			// randomly set .isHidden property on all arrangedSubviews
			//	and the two buttons that are outside stack views
			myArray.forEach { v in
				v.isHidden = Bool.random()
			}
			
		}
		
	}
	
	func calculateTime(block : (() -> Void)) {
		let start = DispatchTime.now()
		block()
		let end = DispatchTime.now()
		let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
		let timeInterval = Double(nanoTime) / 1_000_000_000
		print("Time: \(timeInterval) seconds")
	}
	
}

extension UIView {

	// from: https://stackoverflow.com/a/58138866/6257435
	func subviews<T:UIView>(ofType WhatType:T.Type) -> [T] {
		var result = self.subviews.compactMap {$0 as? T}
		for sub in self.subviews {
			result.append(contentsOf: sub.subviews(ofType:WhatType))
		}
		return result
	}

}

