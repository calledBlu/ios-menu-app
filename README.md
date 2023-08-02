# 🗓️ 식단 캘린더
## 목차
1. [프로젝트 소개](#프로젝트-소개)
2. [프로젝트 구조](#프로젝트-구조)
3. [실행 화면](#실행-화면)
4. [트러블 슈팅](#트러블-슈팅)
5. [추후 개선사항](#추후-개선사항)
6. [참고 링크](#참고-링크)

<br>

# 프로젝트 소개
- **기간**: 2023.05.18 ~ 2023.05.30
- **주요 내용**: 캘린더를 통해 식단을 등록, 확인, 수정, 삭제할 수 있는 앱
    - 스토리보드, 디자인 시안을 가지고 혼자 진행한 첫 개인 프로젝트
    - 스플래시 / 캘린더 / 일별 상세 / 메뉴 상세 / 메뉴 수정·삭제 / 리스트 등의 화면으로 구성되어 있음
- **기술 스택**: `Swift`, `UIKit`, `GitHub`, `Figma`
- **사용한 Skill, 지식, 배운 점**
    - AutoLayout, CollectionView, StackView, CoreData, Delegate-Protocol 패턴 사용
        - 외부 라이브러리 없이 기본 컴포넌트를 최대한 활용
    - UIView에 animation을 적용하여 간단한 스플래시 뷰 구현
    - 기능명세서상 기능은 존재하나 디자인 시안에 없는 화면을 직접 설계·디자인하여 개발함(메뉴 상세, 메뉴 수정·삭제 화면)
    - GitHub의 Issue, Project와 SwiftLint를 사용해 보며 협업 도구의 사용방법 숙지

<br>

# 프로젝트 구조
## File Tree

<details>
<summary> 파일 트리 보기 (클릭) </summary>
<div markdown="1">

```swift
├── MenuApp
│   ├── FoodMO+CoreDataClass.swift
│   ├── FoodMO+CoreDataProperties.swift
│   ├── LikeDayMO+CoreDataClass.swift
│   ├── LikeDayMO+CoreDataProperties.swift
│   ├── MenuApp
│   │   ├── Controller
│   │   │   ├── HalfSizePresentationController.swift
│   │   │   ├── MenuTabBarController.swift
│   │   │   └── ViewController
│   │   │       ├── Calendar
│   │   │       │   ├── CalendarPickerViewController.swift
│   │   │       │   └── CalendarViewController.swift
│   │   │       ├── Detail
│   │   │       │   ├── AddMenuViewController.swift
│   │   │       │   ├── DayDetailViewController.swift
│   │   │       │   └── MenuDetailViewController.swift
│   │   │       ├── Launch
│   │   │       │   └── LaunchViewController.swift
│   │   │       ├── List
│   │   │       │   └── ListViewController.swift
│   │   │       └── PushAlert
│   │   │           └── PushAlertViewController.swift
│   │   ├── Extension
│   │   │   ├── DateFormatter+Extension.swift
│   │   │   ├── UIButton+Extension.swift
│   │   │   ├── UICollectionReusableView+Extension.swift
│   │   │   ├── UICollectionView+Extension.swift
│   │   │   ├── UILabel+Extension.swift
│   │   │   ├── UITabBarController+Extension.swift
│   │   │   ├── UIView+Extension.swift
│   │   │   └── UNUserNotificationCenter+Extension.swift
│   │   ├── Model
│   │   │   ├── Calendar
│   │   │   │   ├── CalendarDateFormat.swift
│   │   │   │   ├── DateProvider
│   │   │   │   │   ├── Interface
│   │   │   │   │   │   └── DateProvidable.swift
│   │   │   │   │   └── implementation
│   │   │   │   │       └── DateProvider.swift
│   │   │   │   ├── Day.swift
│   │   │   │   ├── LikeDay.swift
│   │   │   │   ├── MenuCalendar.swift
│   │   │   │   └── MonthMetadata.swift
│   │   │   ├── CoreData
│   │   │   │   ├── FoodCoreDataManager.swift
│   │   │   │   ├── LikeDayCoreDataManager.swift
│   │   │   │   └── Model.xcdatamodeld
│   │   │   │       └── Model.xcdatamodel
│   │   │   │           └── contents
│   │   │   ├── Error
│   │   │   │   └── CalendarDataError.swift
│   │   │   ├── Menu
│   │   │   │   └── Food.swift
│   │   │   ├── MenuAlert
│   │   │   │   ├── AlertKind.swift
│   │   │   │   ├── Implementation
│   │   │   │   │   ├── MenuReadyAlert.swift
│   │   │   │   │   └── MenuStartAlert.swift
│   │   │   │   └── Interface
│   │   │   │       └── AlertSendable.swift
│   │   │   └── ViewCategory.swift
│   │   └── View
│   │       ├── Calendar
│   │       │   ├── CalendarCollectionViewCell.swift
│   │       │   ├── CalendarTitleStackView.swift
│   │       │   ├── CircleView.swift
│   │       │   └── WeekStackView.swift
│   │       ├── Detail
│   │       │   ├── ButtonStackView.swift
│   │       │   ├── DetailTitleStackView.swift
│   │       │   ├── MenuListCell.swift
│   │       │   ├── MenuListCellView.swift
│   │       │   └── PopupView.swift
│   │       ├── List
│   │       │   └── LikeListCell.swift
│   │       ├── PushAlert
│   │       │   └── PushAlertCell.swift
│   │       └── RoundedStackView.swift
│   └── MenuAppTests
│       ├── CoreDataTests.swift
│       └── MenuAppTests.swift
└── README.md
```
    
</div>
</details>

<br>

# 실행 화면

|<center>초기 화면<br>푸시알림 권한요청</center>|<center>메뉴추가 화면</center>|<center>메뉴수정 화면</center>|
|--| -- | -- |
|<img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/7137b83b-c9a7-4a8a-8d31-fdae556a9ea2" width=250> | <img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/ab0b636c-3d9a-4df3-ba28-0566bdafdb75" width=250> | <img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/f4997d15-8e2c-428b-9a08-6194524a8952" width=250> |

|<center>메뉴삭제 화면</center> |<center>저장된 날짜 리스트</center>|<center>알림설정 화면</center> |
| -- | -- | -- |
|<img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/93bb9fa4-b96c-4ac6-aac4-19fda2d817ef" width=250> | <img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/520b9813-12a5-4a37-9adc-59f12cca76aa" width=250> | <img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/72f58b97-d708-4949-8fb5-bf10addefb9c" width=250> |

<br>

# 트러블 슈팅

## 1️⃣ Custom vs Original
     
### 🔍 문제점

디자인 시안에 맞추어 Navigation bar를 구현하려고 하였으나, Navigaion bar의 height가 기본적으로 제공되는 `UINavigationBar`의 height와 다름

<img src= "https://github.com/calledBlu/ios-menu-app/assets/71758542/6db4ad28-0e0d-4dd5-b5c4-2a56814127be" width=250>

### ⚒️ 해결방안

iOS 11 이후부터 `sizeThatFits(_:)` 메서드를 통한 내비게이션 바 높이 조절이 제한되었고 이를 대체하기 위해 다양한 방법을 고안해 보았음
```
1. Navigation Bar 뒤에 동일한 색상의 UIView를 배치하기
2. largeTitleDisplayMode 사용하기
3. Collection View, Stack View 등 UIView를 사용하여 Navigation Bar 영역을 커스텀하기
4. Prompt를 추가하기
5. SafeAreaInset을 추가하기
6. 커스텀하지 않은 상태의 Navigation Bar 사용하기
```

디자인 시안의 높이를 분석한 결과, Android의 Material Design의 상단 앱 바의 높이와 동일함을 확인, 디자이너가 디자인 시 iOS 내비게이션 바의 기본 높이를 고려하지 못함을 인지하였음

<img src="https://github.com/calledBlu/ios-menu-app/assets/71758542/f40bceba-c11e-4c5f-b60e-fcb48b0ea163" width=500>

사용자의 관점에서 고려할 때 앱을 사용하며 색다른 경험을 제공하는 것도 중요하지만, 익숙하게 사용해 오던 구조를 굳이 바꾸는 것은 사용자 경험(UX)을 저해한다는 결론을 내림

위의 방법 중 최종적으로 **커스텀하지 않은 상태의 Navigation Bar를 사용하기**로 결정

<br>

# 추후 개선사항
## UI
- lottie를 사용여 스플래시 화면 개선
- Apple에서 제공하는 Human Interface Guidlines를 참고하여 UI 개선
- 캘린더가 좌우로 스크롤되는 경우 자연스럽게 이전·다음달이 미리 보이도록 개선

## Code
- 보일러플레이트 코드 제거 및 컨벤션 통일
- 메뉴 삭제 시 사용자에게 메뉴 삭제에 대한 재확인을 요청하는 로직 추가
- 식사 준비 및 시작 알림에 시간을 지정할 수 있는 기능 추가
- Flow Layout -> Compositional Layout으로 개선

<br>

# 참고 링크
## 블로그
- [UI/UX 디자인 가이드_ 내비게이션 바](https://brunch.co.kr/@dalgudot/98)

## 공식 문서
- [Navigation bars](https://developer.apple.com/design/human-interface-guidelines/navigation-bars)
- [UINavigationBar](https://developer.apple.com/documentation/uikit/uinavigationbar)
- [UINavigationController](https://developer.apple.com/documentation/uikit/uinavigationcontroller)
- [UINavigationItem](https://developer.apple.com/documentation/uikit/uinavigationitem)
- [leftBarButtonItems](https://developer.apple.com/documentation/uikit/uinavigationitem/1624946-leftbarbuttonitems)
- [UIBarButtonItem](https://developer.apple.com/documentation/uikit/uibarbuttonitem)
- [UITabBar](https://developer.apple.com/documentation/uikit/uitabbar)
- [Calendar](https://developer.apple.com/documentation/foundation/calendar)
- [User Notifications](https://developer.apple.com/documentation/usernotifications/)
- [Showing and hiding view controllers](https://developer.apple.com/documentation/uikit/view_controllers/showing_and_hiding_view_controllers)
- [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
- [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout)
- [Core Data](https://developer.apple.com/documentation/coredata)

