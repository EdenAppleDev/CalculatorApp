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

    //버튼 배열
    let row1: [ButtonModel] = [
        ButtonModel(title: "7", color: Color.grayColor, action: nil),
        ButtonModel(title: "8", color: Color.grayColor, action: nil),
        ButtonModel(title: "9", color: Color.grayColor, action: nil),
        ButtonModel(title: "+", color: Color.orangeColor, action: nil)
    ]
    let row2: [ButtonModel] = [
        ButtonModel(title: "4", color: Color.grayColor, action: nil),
        ButtonModel(title: "5", color: Color.grayColor, action: nil),
        ButtonModel(title: "6", color: Color.grayColor, action: nil),
        ButtonModel(title: "-", color: Color.orangeColor, action: nil)
    ]
    let row3: [ButtonModel] = [
        ButtonModel(title: "1", color: Color.grayColor, action: nil),
        ButtonModel(title: "2", color: Color.grayColor, action: nil),
        ButtonModel(title: "3", color: Color.grayColor, action: nil),
        ButtonModel(title: "*", color: Color.orangeColor, action: nil)
    ]
    let row4: [ButtonModel] = [
        ButtonModel(title: "AC", color: Color.orangeColor, action: nil),
        ButtonModel(title: "0", color: Color.grayColor, action: nil),
        ButtonModel(title: "=", color: Color.orangeColor, action: nil),
        ButtonModel(title: "/", color: Color.orangeColor, action: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        //버튼 배열
        let buttonRows: [[ButtonModel]] = [
            row1,
            row2,
            row3,
            row4
        ]
        //HStack 생성
        let horizontalStackView = buttonRows.map { row in
            let buttons = createButtons(from: row)
            return buildHorizontalStackView(buttons)
        }

        //VStack 생성
        let verticalStack = buildVerticalStackView(horizontalStackView)
        
        [label, verticalStack]
            .forEach { view.addSubview($0) }
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.directionalHorizontalEdges.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
        }
        
        horizontalStackView
            .forEach { $0.snp.makeConstraints { $0.height.equalTo(80) } }
        
        verticalStack.snp.makeConstraints {
            $0.width.equalTo(350) 
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    //버튼 만들기
//    func createButton(from model: ButtonModel) -> UIButton {
//        let button = UIButton(type: .system)
//        //다른 속성
//        button.setTitle(model.title, for: .normal)
//        button.backgroundColor = model.color
//        //같은 속성
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
//        button.layer.cornerRadius = 40
//        //액션
//        if let action = model.action {
//            button.addTarget(self, action: action, for: .touchUpInside)
//        }
//        return button
//    }
    
    func createButton(from model: ButtonModel) -> UIButton {
        return CircleButton(model: model)
    }
    
    //버튼 4개 배열에 넣기
    func createButtons(from models: [ButtonModel]) -> [UIButton] {
        return models.map { createButton(from: $0) }
    }
    
    //HStack 만들기 안에 버튼 4개
    func buildHorizontalStackView(_ views: [UIButton]) -> UIStackView {
        let buttonStackView = UIStackView(arrangedSubviews: views)
        buttonStackView.axis = .horizontal
        buttonStackView.backgroundColor = .black
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        return buttonStackView
    }
    
    //VStack 만들기 안에 HStack 4개
    func buildVerticalStackView(_ views: [UIStackView]) -> UIStackView {
        let verticalStackView = UIStackView(arrangedSubviews: views)
        verticalStackView.axis = .vertical
        verticalStackView.backgroundColor = .black
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
        return verticalStackView
    }
    
}

//버튼 클래스
class CircleButton: UIButton {
    init(model: ButtonModel) {
        super.init(frame: .zero)
        //다른 속성
        setTitle(model.title, for: .normal)
        backgroundColor = model.color
        //같은 속성
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        layer.cornerRadius = 40
        //액션
        if let action = model.action {
            addTarget(self, action: action, for: .touchUpInside)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//버튼 모델
struct ButtonModel {
    let title: String
    let color: UIColor
    let action: Selector?
}

//버튼 색상
enum Color {
    static let grayColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
    static let orangeColor = UIColor.orange
}


// MARK: - ViewController Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
  ViewController()
}

#endif
