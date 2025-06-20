//
//  ViewController.swift
//  CalculatorApp
//
//  Created by 김이든 on 6/14/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let label = UILabel()
    private var buttons: [[UIButton]] = []
    private var horizontalStackViews: [UIStackView] = []
    private var verticalStack = UIStackView()
    
    private let operators: Set<String> = ["+", "-", "*", "/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 라벨에 텍스트 추가하기
    @objc
    func buttonTapped(_ sender: UIButton) {
        guard let input = sender.currentTitle else { return }
        
        let currentText = label.text ?? "0"
        
        // 처음 글자가 0인데 연산자 입력하면 0에 연산자 추가
        if currentText == "0" && operators.contains(input) {
            label.text = currentText + input
        }
        
        // 마지막 글자가 연산자인데 또 연산자 입력하면 무시
        if let last = currentText.last,
           operators.contains(String(last)) {
            // 같은 연산자면 무시
            if String(last) == input {
                return
            } else if operators.contains(input) {// 다른 연산자면 교체
                let newText = currentText.dropLast() + input// 새 연산자 추가
                label.text = String(newText)
                return
            }
        }
        
        // 숫자가 들어오면 기존 "0" 제거
        if currentText == "0" && !operators.contains(input)  {
            label.text = input
        } else {
            label.text = currentText + input
        }
        
    }
    
    // 라벨 초기화
    @objc
    func resetButtonTapped(_ sender: UIButton) {
        label.text = "0"
    }
    
    // 계산 하기
    @objc
    func equalButtonTapped(_ sender: UIButton) {
        guard let expressionText = label.text, !expressionText.isEmpty else {
            return
        }
        
        //마지막 글자가 연산자면 계산 무시
        if let last = expressionText.last {
            if operators.contains(String(last)) {
                return
            }
        }
        
        // NSExpression으로 계산
        let expression = NSExpression(format: expressionText)
        
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            label.text = result.stringValue
        } else {
            label.text = "Error"
        }
    }
}

// MARK: - Extension

private extension ViewController {
    
    func setupUI() {
        // 배경색상 설정
        view.backgroundColor = .black
        // 레이블 설정
        setupLabel()
        // 버튼 및 스택뷰 구성
        setButtonsArray()
        setupHorizontalStackViews()
        setupVerticalStackView()
        //레이아웃 설정
        setupLayout()
    }
    // 레이아웃 설정
    func setupLayout() {
        [label, verticalStack]
            .forEach { view.addSubview($0) }
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.directionalHorizontalEdges.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(200)
        }
        
        horizontalStackViews.forEach {
            $0.snp.makeConstraints { $0.height.equalTo(80) }
        }
        
        verticalStack.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }
    // 레이블 설정
    func setupLabel() {
        label.backgroundColor = .black
        label.textColor = .white
        label.text = "0"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 60, weight: .bold)
    }
    // 버튼 생성
    func createButton(from model: ButtonModel) -> UIButton {
        let button = CircleButton(model: model)
        // 액션
        button.addTarget(self, action: model.action, for: .touchUpInside)
        return button
    }
    // 배열에서 받은 데이터로 버튼생성
    func createButtons(from models: [ButtonModel]) -> [UIButton] {
        return models.map { createButton(from: $0) }
        //ButtonModel row1을 받으면 row1을 UIButton 배열로 전환
    }
    // 버튼 배열 만들기
    func setButtonsArray() {
        buttons = buttonRows.map { createButtons(from: $0) }
    }
    // 버튼 배열 받아서 HStack 생성
    func buildHorizontalStackView(_ views: [UIButton]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .horizontal
        stack.backgroundColor = .black
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }
    // HStack 설정
    func setupHorizontalStackViews() {
        horizontalStackViews = buttons.map { buildHorizontalStackView($0) }
    }
    // HStack 배열 받아서 VStack 생성
    func buildVerticalStackView(_ views: [UIStackView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        stack.backgroundColor = .black
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }
    // VStack 설정
    func setupVerticalStackView() {
        verticalStack = buildVerticalStackView(horizontalStackViews)
    }
}

// MARK: - Button class

// 버튼 클래스
class CircleButton: UIButton {
    // 애니메이션 설정
    private let originalAlpha: CGFloat = 1.0
    private let highlightedAlpha: CGFloat = 0.8
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? self.highlightedAlpha : self.originalAlpha
            }
        }
    }
    
    init(model: ButtonModel) {
        super.init(frame: .zero)
        // 다른 속성
        setTitle(model.title, for: .normal)
        backgroundColor = model.color
        // 같은 속성
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        layer.cornerRadius = 40
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - ViewController Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
    ViewController()
}

#endif
