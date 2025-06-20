# CalculatorApp

Swift로 작성한 **코드베이스 UI 계산기 앱**입니다.  
`UILabel`, `UIButton`, `UIStackView`, `AutoLayout` 등을 직접 활용해 iOS UI를 구성하고, `NSExpression`을 통해 수식 계산을 수행합니다.

---

## Features

- **정수 계산만 지원**
- **코드베이스로 구성된 UI**
- **수식 입력 시 직관적인 버튼 동작 처리**
- **`=` 버튼 클릭 시 수식 계산**
- **`AC` 버튼 클릭 시 초기화**
- **연산자 중복 입력 방지 로직 적용**

---

## UI 구성

| 요소 | 설명 |
|------|------|
| `UILabel` | 현재 수식을 표시 |
| `UIButton` | 숫자 및 연산 입력 버튼 |
| `UIStackView` | 버튼들을 수직·수평으로 정렬 |
| `SnapKit` | AutoLayout 제약 조건 설정 |

---

## 주요 로직

- **버튼 입력 처리**
  - 연산자 중복 방지
  - 첫 숫자 0 제거
  - 입력 문자열 조합

- **계산 처리**
  ```swift
  let expression = NSExpression(format: expressionText)
  expression.expressionValue(with: nil, context: nil) as? NSNumber
