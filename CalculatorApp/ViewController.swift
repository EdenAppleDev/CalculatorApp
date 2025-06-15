//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 김이든 on 6/14/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //레이블
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.text = "12345"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 60, weight: .bold)
        return label
    }()
    
    //버튼 색상
    static let grayColor: UIColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    static let orangeColor: UIColor = .orange
    
    //버튼 튜플
    let firstBtns: [(String, UIColor)] = [
        ("7", grayColor),("8", grayColor),("9", grayColor),("+", orangeColor)
    ]
    let secondBtns: [(String, UIColor)] = [
        ("4", grayColor),("5", grayColor),("6", grayColor),("+", orangeColor)
    ]
    let thirdBtns: [(String, UIColor)] = [
        ("1", grayColor),("2", grayColor),("3", grayColor),("+", orangeColor)
    ]
    let fourthBtns: [(String, UIColor)] = [
        ("AC", orangeColor),("0", grayColor),("=", orangeColor),("/", orangeColor)
    ]
    
    //버튼 스타일 UIButton
    func makeButtonStyle(_ title: String, _ color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        //다른 속성
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        //같은 속성
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        //height, width 80 에 다 중복인데 어떻게하지..
        button.layer.cornerRadius = 40
        return button
    }
    
    //버튼 만들기 4개 배열
    //버튼을 만드는 func makeButton 이라는 메서드가 있었고 인자로 titleValue: String, action: Selector, backgroundColor: UIColor 를 받을 수 있으면 편했겠죠.
    func makeButton(_ btns: [(String, UIColor)]) -> [UIButton] {
        var buttons: [UIButton] = []
        
        for (title, color) in btns {
            let button = makeButtonStyle(title, color)
            buttons.append(button)
            print(buttons)
        }
            
        return buttons
    }
    
    //HStack 만들기 안에 버튼 4개
    func makeHorizontalStackView(_ views: [UIButton]) -> UIStackView {
        let buttonStackView = UIStackView(arrangedSubviews: views) 
        buttonStackView.axis = .horizontal
        buttonStackView.backgroundColor = .black
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }
    
    //VStack 만들기 안에 HStack 4개
    func makeVerticalStackView(_ views: [UIStackView]) -> UIStackView {
        let verticalStackView = UIStackView(arrangedSubviews: views)
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        return verticalStackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        //4줄 4개씩 버튼 생성
        let firstButtons = makeButton(firstBtns)
        let secondButtons = makeButton(secondBtns)
        let thirdButtons = makeButton(thirdBtns)
        let fourthButtons = makeButton(fourthBtns)
        
        //HStack 4개 생성
        let firstHStack = makeHorizontalStackView(firstButtons)
        let secondHStack = makeHorizontalStackView(secondButtons)
        let thirdHStack = makeHorizontalStackView(thirdButtons)
        let fourthHStack = makeHorizontalStackView(fourthButtons)
        
        //VStack 생성
        let verticalStack = makeVerticalStackView([firstHStack, secondHStack, thirdHStack, fourthHStack])
        
        [label, verticalStack]
            .forEach { view.addSubview($0) }
        
        label.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
            $0.height.equalTo(100)
        }
        
        firstHStack.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        secondHStack.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        thirdHStack.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        fourthHStack.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
        verticalStack.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
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
