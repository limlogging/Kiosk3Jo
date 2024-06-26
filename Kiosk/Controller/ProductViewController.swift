//
//  ViewController.swift
//  Kiosk
//
//  Created by imhs on 4/1/24.
//



import UIKit

class ProductViewController: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var productSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
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
    
    
    // MARK: - viewDidLoad 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notiLabel.backgroundColor = .red
        notiLabel.textColor = .white
        notiLabel.layer.masksToBounds = true
        notiLabel.layer.cornerRadius = notiLabel.frame.width/2
        
        searchBar.placeholder = "상품을 검색하세요."
        searchBar.backgroundColor = .systemGray5
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        
        searchBar.delegate = self
        setupCollectionView()
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
        numberFormatter.numberStyle = .decimal
        addDimmingView()
        setLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainCollectionView.reloadData()
    }
    
    func setLabel () {
        if ListManager.shared.list.count == 0 {
            notiLabel.isHidden = true
        } else {
            notiLabel.text = String(ListManager.shared.list.map{$0.value}.reduce(0, +))
            notiLabel.isHidden = false
        }
    }
    
    func setupCollectionView() {
        let flowLayout = createFlowLayout()
        mainCollectionView.collectionViewLayout = flowLayout
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: Constants.contentName)
        mainCollectionView.alwaysBounceVertical = true
    }
    
    // MARK: - sege, 컬렉션 뷰 연결
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchBar.text = ""
            filteredProducts = dataManager.products.filter { $0.category == "맥북" }
        case 1:
            searchBar.text = ""
            filteredProducts = dataManager.products.filter { $0.category == "아이폰" }
        case 2:
            searchBar.text = ""
            filteredProducts = dataManager.products.filter { $0.category == "패드" }
        case 3:
            searchBar.text = ""
            filteredProducts = dataManager.products.filter { $0.category == "워치" }
        case 4:
            searchBar.text = ""
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
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.7)
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
        if !ListManager.shared.list.isEmpty {
            let modalVC = self.modalViewController
            // 사이드 메뉴 뷰 컨트롤러를 자식으로 추가하고 뷰 계층 구조에 추가.
            self.addChild(modalVC)
            self.view.addSubview(modalVC.view)
            
            let menuWidth = self.view.frame.width // 가로는 현재 화면과 동일하게
            let menuHeight = self.view.frame.height * 0.6 // 높이만 60%로 설정
            
            // 사이드 메뉴의 시작 위치를 화면 아래로 설정.
            modalVC.view.frame = CGRect(x: 0, y: view.frame.height, width: menuWidth, height: menuHeight)
            
            // 어두운 배경 뷰를 보이게 한다.
            self.dimmingView?.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
                // 사이드 메뉴를 화면에 표시.
                modalVC.view.frame = CGRect(x: 0, y: self.view.frame.height - menuHeight, width: menuWidth, height: menuHeight)
                self.dimmingView?.alpha = 0.7
            })
        } else { // 제품이 없을때 장바구니 클릭시 alert 발생
            let alert = UIAlertController(title: "현재 상품이 없습니다", message: "제품을 담아주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    // MARK: - collectionview cell 크기 조절
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 170, height: 100)
        layout.estimatedItemSize = CGSize(width: 170, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return layout
    }
}

// MARK: - collectionView delegate, datasource 확장
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - 컬렉션 뷰 선택하면 디테일 화면으로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailViewID") as? DetailViewController {
            
            detailVC.tempCategory = filteredProducts[indexPath.item].category   //카테고리명 전달
            detailVC.tempProduct = filteredProducts //제품 정보 전달
            
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    // MARK: - collectionView 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.contentName, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        
        let product = filteredProducts[indexPath.item]
        cell.configure(with: product)
        
        if product.isNew {
            cell.newLabel.isHidden = false
        } else {
            cell.newLabel.isHidden = true
        }
        
        cell.cartDelegate = self //장바구니 추가버튼 이벤트 처리를 위한 대리자 지정
        
        return cell
    }
}

// MARK: - SearchBar
extension ProductViewController: UISearchBarDelegate {
    // 입력 취소시
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    // 활성화된 키보드에서 검색을 눌렀을때 키보드 사라짐.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    // 검색어의 변화가 있을때
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 지웠을때
        if searchBar.text?.count == 0 {
            productSegment.selectedSegmentIndex = 0 // 인덱스 mac으로 되돌리기
            filteredProducts = dataManager.products.filter { $0.category == "맥북" }
            mainCollectionView.reloadData()
            
            // 타이핑 하고 있을때
        } else {
            filteredProducts = dataManager.products.filter{$0.name.contains(searchText)}
            mainCollectionView.reloadData()
        }
    }
}

// MARK: - 장바구니 추가 이벤트를 처리할 Delegate 채택
extension ProductViewController: AddToCartDelegate {
    func addToCart(_ cell: ProductCell) {
        guard let indexPath = mainCollectionView.indexPath(for: cell) else { return }
        
        ListManager.shared.list.append(filteredProducts[indexPath.item])
        
        if ListManager.shared.list.map({$0.name}).filter({$0 == filteredProducts[indexPath.item].name}).count == 2 {
            let alert = UIAlertController(title: "중복 선택 확인", message: "중복으로 선택 되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            ListManager.shared.list.removeLast()
            
            self.present(alert, animated: true)
        }
        setLabel()
    }
}
