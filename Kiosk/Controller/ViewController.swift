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
    var totalCount = 0
    var totalPrice = 0
    
    
    // MARK: - viewDidLoad 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
        
        numberFormatter.numberStyle = .decimal
        
        addDimmingView()
        
    }
 
    @IBAction func questionAlert(_ sender: UIButton) {
        let qAlert = UIAlertController(title: "문의사항을 남겨주세요.", message: "", preferredStyle: .alert)
        let save = UIAlertAction(title: "저장", style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        qAlert.addAction(cancel)
        qAlert.addAction(save)
        qAlert.addTextField() { (UITextField) in
            UITextField.placeholder = "이곳에 입력해주세요."
        }
        self.present(qAlert, animated: true)
    }
    
    @IBAction func cancelAlert(_ sender: UIButton) {
        
        if selectedList.isEmpty {
            
            let cAlert = UIAlertController(title: "취소불가", message: "취소할 상품이 없습니다.", preferredStyle: .alert)
            let yes = UIAlertAction(title: "네", style: .default)
            
            cAlert.addAction(yes)
            
            self.present(cAlert, animated: true)
            
        } else {
            
            let cAlert = UIAlertController(title: "주문 취소", message: "상품을 모두 삭제하시겠습니까?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "네", style: .default) { action in
                self.selectedList = []
                self.getData()
                self.tableView.reloadData()
            }
            
            
            let no = UIAlertAction(title: "아니오", style: .cancel)
            
            cAlert.addAction(yes)
            cAlert.addAction(no)
            
            self.present(cAlert, animated: true)
            
        }
    }
    
    @IBAction func orderAlert(_ sender: UIButton) {
        
        if selectedList.isEmpty {
            
            let oAlert = UIAlertController(title: "주문불가", message: "장바구니에 담긴 상품이 없습니다. 상품을 추가해주세요.", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "네", style: .default)
            
            oAlert.addAction(yes)
            
            self.present(oAlert, animated: true)
            
        } else {
            
            let oAlert = UIAlertController(title: "주문하기", message: "담으신 상품을 결제하시겠습니까?", preferredStyle: .alert)
            
            let yes = UIAlertAction(title: "네", style: .default) { action in
                
                self.selectedList = []
                self.getData()
                self.tableView.reloadData()
            }
            
            let no = UIAlertAction(title: "아니오", style: .cancel)
            
            oAlert.addAction(yes)
            oAlert.addAction(no)
            
            self.present(oAlert, animated: true)
        }
    }
    
    func getData() {
        totalCount = selectedList.map{$0.value}.reduce(0, +)
        totalPrice = selectedList.map{Int($0.value * $0.price)}.reduce(0, +)
        priceLabel.text = "\(String(totalPrice)) 원"
        countLabel.text = "\(String(totalCount)) 개"
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
        }
    }
    
    
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

extension ViewController: sendList {
    func sendData(dataList: [AppleProduct]) {
        selectedList = dataList
    }
}
