//
//  ViewController.swift
//  LoaderAnimation
//
//  Created by Murtaza Mehmood on 22/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var indicatorView: IndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.indicatorView.color = UIColor.black
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else {return}
            
            self.indicatorView.startAnimation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
                self.indicatorView.color = UIColor.gray
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.indicatorView.color = UIColor.blue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.indicatorView.color = UIColor.purple
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.indicatorView.color = UIColor.gray
                            self.indicatorView.stopAnimation()
                        }
                    }
                }
            }
        }
    }


}

