//
//  DetailViewController.swift
//  Kiosk
//
//  Created by imhs on 4/5/24.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - title 설정
    var titleTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - ScrollView 설정
    var productScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // MARK: - PageControl 설정
    var productScrollViewPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        //pageControl.numberOfPages = productImages.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        return pageControl
    }()
    
    // MARK: - detail 설정
    var detailTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var tempCategory: String?
    var tempProduct: [AppleProduct]?
    var productImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productScrollView.delegate = self
        
        if let category = tempCategory, let appleProduct = tempProduct {
            for product in appleProduct {
                if let image = product.image {
                    productImages.append(image)
                }
            }
            //PageControl 개수를 image 개수만큼
            productScrollViewPageControl.numberOfPages = productImages.count
            
            setContents(category)   //카테고리별 text 지정
            setAutoLayout()         //오토레이아웃 설정
            setImageView()          //Image 추가 및 오토레이아웃 설정
        }
    }
    
    // MARK: - 카테고리에 따른 셋팅
    func setContents(_ category: String) {
        switch category {
        case "맥북":
            titleTextView.text = """
            꿈꾸던 그 모든 것,
            Mac과 함께 현실로.
            """
            detailTextView.text = """
            완전히 급이 다른 새로운 GPU 아키텍처의 등장. Apple Silicon 사상 가장 혁신적으로 향상된 그래픽 성능을 구현합니다.\n\n고속 온 칩 메모리를 최적화해 평균 GPU 활용률을 극적으로 끌어올려 주는 Dynamic Caching 기술을 바탕으로 초고사양이 요구되는 프로용 앱과 게임도 거뜬히 구동하는 비약적인 성능 향상을 이뤄냈죠.
            """
        case "패드":
            titleTextView.text = """
            쓰다. 그리다. 빠져들다.
            """
            detailTextView.text = """
            컬러풀한 디자인으로 재탄생한 iPad는 더 다재다능하고, 더 직관적일 뿐만 아니라 더 큰 즐거움까지 선사합니다. \n\n전면 화면 디자인, 27.5cm Liquid Retina 디스플레이 그리고 4가지 아름다운 컬러로 선보이는 iPad는 다양한 일을 처리하고, 창의력을 뽐내고, 스마트하게 소통할 수 있는 강력한 방식들을 마련해 주죠. 여기에 iPad만을 위해 디자인된 필수 액세서리들까지 더하면, 당신이 즐겨 하는 모든 일을 위한 무한한 가능성이 펼쳐집니다.
            """
        case "아이폰":
            titleTextView.text = """
            사랑받기 위해 디자인되다.
            """
            detailTextView.text = """
            엄청나게 디테일한 배경과 살아 숨쉬는 듯한 캐릭터로 모바일 게임을 즐길 때도 생생한 그래픽과 몰입감 넘치는 플레이 경험을 만끽할 수 있게 해주죠. \n\n여기에 업계 최고 수준의 속도와 효율성까지 갖춘 A17 Pro. 무슨 일이든 쏜살같은 속도로 해치웁니다.
            """
        case "워치":
            titleTextView.text = """
            보다 똑똑. 보다 또렷. 보다 강력.
            """
            detailTextView.text = """
            최강의 내구성과 최고의 기능성을 자랑하는 Apple Watch 모델, 또다시 한계를 뛰어넘다. \n\n완전히 새로운 S9 SiP 탑재. 화면을 터치하지 않고도 시계를 다루는 신박한 방법. 역대 가장 밝은 Apple 디스플레이. 여기에 이제 탄소 중립 케이스 및 밴드를 조합할 수 있는 옵션까지.
            """
        case "악세사리":
            titleTextView.text = """
            MagSafe로 믹스앤매치.
            """
            detailTextView.text = """
            케이스, 카드지갑, 무선 충전기까지 간편하게 착.
            """
        default:
            titleTextView.text = ""
            detailTextView.text = ""
        }
    }
    
    // MARK: - 오토레이아웃 설정
    func setAutoLayout() {
        view.addSubview(titleTextView)
        view.addSubview(productScrollView)
        view.addSubview(productScrollViewPageControl)
        view.addSubview(detailTextView)
        
        // ScrollView contentSize 설정
        productScrollView.contentSize = CGSize(width: CGFloat(productImages.count) * view.bounds.width, height: productScrollView.bounds.height)
        
        //오토레이아웃 설정
        NSLayoutConstraint.activate([
            //타이틀 텍스트
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            //스크롤 뷰
            productScrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            productScrollView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            productScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productScrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            productScrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            
            //페이지 컨트롤
            productScrollViewPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productScrollViewPageControl.bottomAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 30),
            
            //디테일 텍스트
            detailTextView.topAnchor.constraint(equalTo: productScrollView.bottomAnchor, constant: 30),
            detailTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            detailTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            detailTextView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)
        ])
    }
    
    // MARK: - Image 추가 및 오토레이아웃 설정
    func setImageView() {
        for (index, image) in productImages.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            productScrollView.addSubview(imageView)
            
            // 이미지 뷰들을 가로로 배치
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: productScrollView.leadingAnchor, constant: CGFloat(index) * view.bounds.width),
                imageView.topAnchor.constraint(equalTo: productScrollView.topAnchor),
                imageView.widthAnchor.constraint(equalTo: productScrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: productScrollView.heightAnchor)
            ])
        }
    }
}

// MARK: - 스크롤뷰 델리게이트 채택
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.bounds.width)
        productScrollViewPageControl.currentPage = Int(pageIndex)
    }
}
