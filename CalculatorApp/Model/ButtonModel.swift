//
//  ButtonModel.swift
//  CalculatorApp
//
//  Created by 김이든 on 6/17/25.
//

import UIKit

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

//버튼 배열
let buttonRows: [[ButtonModel]] = [
    row1,
    row2,
    row3,
    row4
]
