# Table of Contents
1. [Description](#description)
2. [Period](#period)
3. [Demo](#Demo)
4. [Main Feature](#main-feature)
5. [Requirements](#requirements)
6. [Stacks](#stacks)
7. [Project Structure](#project-structure)
8. [Developer](#developer)

# 🍍Fine Apple Store🍍

<img src="https://i.ibb.co/s5rg8Y5/image-removebg-preview.png" alt="image-removebg-preview" width="300">

Apple 제품을 빠르고 간편하게 쇼핑하자! Fine Apple Store!

## Description

Apple 제품에대한 소식을 빠르게, 편하게, 싸게 구입 할 수 있는 Fine Apple Store입니다.

새로나온 제품은 물론 제품 정보도 한눈에 간편하게!

## Period

- 24.04.01
    - Project 아이디어 회의 및 기본 기능 구현
        - 상품 표시, 담은 물품 표시

- 24.04.02
    - 각종 버튼 기능 구현 (주문하기, 문의하기, 주문취소)
    - 추가 기능 회의

- 24.04.03
    - 기존 UI 디자인 변경 및 추가 기능 구현
        - TabBar 추가 (홈, 상품, 마이페이지, 고객센터로 세분화)
        - Modal View로 장바구니 화면 별도 구현
        - Notification Badge형식 구현
        - App Icon 등록

- 24.04.04
    - 홈 화면 기능 및 디자인
    - 고객센터 페이지 구현
    - 상품페이지 SearchBar 기능 구현

- 24.04.05
    - 고객센터 내 매장찾기 기능 추가 (지도구현)
    - 마이페이지 구현
    - 새로 출시된 제품 구분 기능 추가

- 24.04.06
    - 제품 상세페이지 기능 구현
    - Launch Screen 디자인

- 24.04.07
    - UI 및 기능 최종 점검 

## Demo
<p float="left">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/e6b01d7e-54dc-4600-8889-123024f2898c" alt="Home" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/9fafc311-eca5-4a22-a80f-33009d31ef75" alt="상품디테일" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/80a231de-0286-49ac-a445-857d01da4042" alt="상품" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/7f828eab-c4ba-4335-9f92-64f7417abfd9" alt="상품장바구니" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/5cee3de6-458e-446d-98b6-ce73b8dca496" alt="상품문의하기" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/db3d9be6-f866-4916-9238-159d101c3c80" alt="상품주문하기" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/8ed4944d-c4a8-4919-b7a9-46257a26565b" alt="상품주문취소" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/6a6129c0-7e1c-4416-830b-fc380ce10088" alt="마이페이지" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/9509f5c3-7b55-4a88-b06b-4aa5c156fe5a" alt="상품검색하기" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/6073cac6-db75-4fa0-8be5-56a40517d39f" alt="고객센터매장찾기" width="200">
    <img src="https://github.com/limlogging/Kiosk3Jo/assets/156410026/fd020794-1e03-43de-96d3-4391cb1ef671" alt="고객센터" width="200">
</p>


## Main Feature
### 간편한 주문
- 터치 한번으로 주문도 한번에!

### 상품검색도 한번에
- 상품이 어디있는지 헤메지말고 검색으로 한번에 찾자

### 직관적인 장바구니
- 원터치로 간편하고 빠르게

### 신상 정보도 한번에
- 새로나온 상품 더이상 찾아보고 사지 말고 확인도 한번에

### 마이페이지 기능
- 나만의 페이지에서 주문정보와 프로필 관리

### 고객센터 문의도 간편하게
- 문의도 원터치로 심플하게

### 매장 찾기
- 간편하게 지도로 매장 위치도 한번에

## Requirements
- App requires **iOS 15 or above**

## Stacks
- **Environment**

    <img src="https://img.shields.io/badge/-Xcode-147EFB?style=flat&logo=xcode&logoColor=white"/> <img src="https://img.shields.io/badge/-git-F05032?style=flat&logo=git&logoColor=white"/> <img src="https://img.shields.io/badge/-github-181717?style=flat&logo=github&logoColor=white"/>

- **Language**

    <img src="https://img.shields.io/badge/-swift-F05138?style=flat&logo=swift&logoColor=white"/> 

- **Communication**

    <img src="https://img.shields.io/badge/-slack-4A154B?style=flat&logo=slack&logoColor=white"/> <img src="https://img.shields.io/badge/-notion-000000?style=flat&logo=notion&logoColor=white"/> 


## Project Structure

```markdown
Fine Apple Store Kiosk
├── Model
│   ├── AppleProduct
│   ├── CallCenterMenu
│   ├── DataManager
│   ├── HomeDataManager
│   ├── HomeItem
│   ├── ListManager
│   └── MyProfile
│
├── View
│   ├── MainStoryBoard
│   ├── PriceCell
│   ├── ProductCell
│   ├── HeaderCollectionReusableView
│   ├── HomeCollectionViewCell
│   ├── CallCenterTableViewCell
│   └── MyPageCartTableViewCell
│
├── controller
│   ├── ProductViewController
│   ├── ModalViewController
│   ├── HomeViewController
│   ├── MyPageViewController
│   ├── CallCenterViewController
│   ├── DetailViewController
│   └── MapViewController
└ 
```

## Developer
*  **임형섭** ([limlogging](https://github.com/limlogging))
    - merge 담당
    - TabBar, Navigation 기능
    - 마이페이지 구현
    - 제품 상세 페이지 구현
*  **금세미** ([pond1225](https://github.com/pond1225))
    - 버튼 , 알럿 기능 구현
    - 컬렉션 뷰와 이미지 연결
    - launch screen 디자인
*  **김시종** ([SijongKim93](https://github.com/SijongKim93))
    - 데이터 모델링
    - 상품 컬렉션뷰, 세그먼트컨트롤러 기능 구현
    - 홈 탭 고객센터 탭 구현
    - 이미지 및 레이아웃 상세 디자인 수정
*  **송동익** ([Haroldfromk](https://github.com/Haroldfromk/))
    - 테이블 뷰 기능 구현
    - 장바구니 기능, Modal View 구현
    - Notification Badge 구현, Search Bar 구현
    - 매장 위치 지도 기능 구현
    - 그 외 기타 에러 해결
