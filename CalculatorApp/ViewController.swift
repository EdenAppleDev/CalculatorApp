//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 김이든 on 6/14/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let numLabel: UILabel = {
        let numLabel = UILabel()
        numLabel.backgroundColor = .black
        numLabel.textColor = .white
        numLabel.text = "12345"
        numLabel.textAlignment = .right
        numLabel.font = .systemFont(ofSize: 60, weight: .bold)
        return numLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        [numLabel]
            .forEach { view.addSubview($0) }
        
        numLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
            $0.height.equalTo(100)
        }
    }
}


// MARK: - ViewController Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
  ViewController()
}

#endif
