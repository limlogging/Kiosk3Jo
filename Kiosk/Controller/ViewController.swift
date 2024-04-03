//
//  ViewController.swift
//  Kiosk
//
//  Created by imhs on 4/1/24.
//



import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var productSegment: UISegmentedControl!
    
    @IBOutlet weak var notiLabel: UILabel!
    
    let dataManager = DataManager()
    let cellMarginSize: CGFloat = 2.0
    let numberFormatter = NumberFormatter()
    
    var filteredProducts: [AppleProduct] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    var modalViewController = ModalViewController()
    var dimmingView: UIView?
    
    
    var selectedList: [AppleProduct] = [AppleProduct]()
     
    // MARK: - viewDidLoad 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
        
        numberFormatter.numberStyle = .decimal
        
        
        addDimmingView()
        setLabel()
    }

    func setLabel () {
        notiLabel.backgroundColor = .red
        notiLabel.textColor = .white
        notiLabel.layer.masksToBounds = true
        notiLabel.layer.cornerRadius = notiLabel.frame.width/2
        
        if selectedList.count == 0 {
            notiLabel.isHidden = true
        } else {
            notiLabel.text = String(selectedList.map{$0.value}.reduce(0, +))
            notiLabel.isHidden = false
        }
    }
    
    
    func setupCollectionView() {
        let flowLayout = createFlowLayout()
        mainCollectionView.collectionViewLayout = flowLayout
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        mainCollectionView.alwaysBounceVertical = true
    }
    
    // MARK: - sege, 컬렉션 뷰 연결
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filteredProducts = dataManager.products.filter { $0.category == "맥북" }
        case 1:
            filteredProducts = dataManager.products.filter { $0.category == "아이폰" }
        case 2:
            filteredProducts = dataManager.products.filter { $0.category == "패드" }
        case 3:
            filteredProducts = dataManager.products.filter { $0.category == "워치" }
        case 4:
            filteredProducts = dataManager.products.filter { $0.category == "악세사리" }
        default:
            break
        }
        mainCollectionView.reloadData()
    }
    
    // MARK: - ModalVC 구현
    private func addDimmingView() {
        // 어둑해지는 화면을 구현
        dimmingView = UIView(frame: self.view.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView?.isHidden = true
        view.addSubview(dimmingView!)
        
        // 어두운 화면을 탭했을때 이벤트 발생
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmingViewTap))
        dimmingView?.addGestureRecognizer(tapGesture)
    }
    
    // 어두운 화면 탭했을때 사라지게 하기
    @objc private func handleDimmingViewTap() {
        let modalVC = self.modalViewController
        
        UIView.animate(withDuration: 0.3, animations: {
            modalVC.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
            self.dimmingView?.alpha = 0
        }) { (finished) in
            modalVC.view.removeFromSuperview()
            modalVC.removeFromParent()
            self.dimmingView?.isHidden = true
            self.setLabel()
        }
        
    }
    
    // MARK: - 장바구니 선택
    @IBAction func openCart(_ sender: UIButton) {
        let modalVC = self.modalViewController
        modalVC.delegate = self
        modalVC.selectedList.removeAll()
        modalVC.selectedList = selectedList
       
        // 사이드 메뉴 뷰 컨트롤러를 자식으로 추가하고 뷰 계층 구조에 추가.
        self.addChild(modalVC)
        self.view.addSubview(modalVC.view)
        
        let menuWidth = self.view.frame.width // 가로는 현재 화면과 동일하게
        let menuHeight = self.view.frame.height * 0.3 // 높이만 30%로 설정
        
        // 사이드 메뉴의 시작 위치를 화면 아래로 설정.
        modalVC.view.frame = CGRect(x: 0, y: view.frame.height, width: menuWidth, height: menuHeight)
        
        // 어두운 배경 뷰를 보이게 한다.
        self.dimmingView?.isHidden = false
        self.dimmingView?.alpha = 0.6
        
        UIView.animate(withDuration: 0.3, animations: {
            // 사이드 메뉴를 화면에 표시.
            modalVC.view.frame = CGRect(x: 0, y: self.view.frame.height - menuHeight, width: menuWidth, height: menuHeight)
            // 어두운 배경 뷰의 투명도를 조절.
            self.dimmingView?.alpha = 0.5
        })
        
    }
    
    // MARK: - collectionview cell 크기 조절
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 100)
        layout.estimatedItemSize = CGSize(width: 160, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return layout
    }
}

// MARK: - collectionView delegate, datasource 확장
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedList.append(filteredProducts[indexPath.item])
        
        if selectedList.map({$0.name}).filter({$0 == filteredProducts[indexPath.item].name}).count == 2 {
            let alert = UIAlertController(title: "중복 선택 확인", message: "중복으로 선택 되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            selectedList.removeLast()
           
            self.present(alert, animated: true)
        }
        setLabel()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    // MARK: - collectionView 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = filteredProducts[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}

// MARK: - Delegate를 통한 데이터 전달 (From ModalVC)
extension ViewController: sendList {
    func sendData(dataList: [AppleProduct]) {
        selectedList = dataList
    }
}
