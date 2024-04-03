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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    let dataManager = DataManager()
    let cellMarginSize: CGFloat = 2.0
    
    var filteredProducts: [AppleProduct] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    

    var selectedList: [AppleProduct] = [AppleProduct]()
    var totalCount = 0
    var totalPrice = 0
    
    // MacBook 데이터
    let macBook = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "MacBook Pro", price: 2000000, category: "", value: 1)
    
    // iPhone 데이터
    let iPhone = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "iPhone 12", price: 1000000, category: "", value: 1)
    
    // iPad 데이터
    let iPad = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "iPad Pro", price: 800000, category: "", value: 1)
    
    // Apple Watch 데이터
    let appleWatch = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "Apple Watch Series 6", price: 500000, category: "", value: 1)
    
    // 기타 액세서리 데이터
    let etcAccessory = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "AirPods Pro", price: 300000, category: "", value: 1)
    
// MARK: - viewDidLoad 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
        
        
        tableView.rowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: Constants.cellName, bundle: nil), forCellReuseIdentifier: Constants.cellName)

        selectedList.append(macBook)
        selectedList.append(iPhone)
        selectedList.append(iPad)
        selectedList.append(appleWatch)
        selectedList.append(etcAccessory)
        
        tableView.reloadData()
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


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentLocation = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath) as? PriceCell else { return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.titleLabel.text = selectedList[currentLocation].name
        cell.itemImage.image = selectedList[currentLocation].image
        cell.priceLabel.text = String(selectedList[currentLocation].price)
        cell.valueLabel.text = String(selectedList[currentLocation].value)
        
        cell.minusBtn.tag = currentLocation
        cell.plusBtn.tag = currentLocation
        cell.deleteBtn.tag = currentLocation
        
        cell.minusBtn.addTarget(self, action: #selector(minusValue), for: .touchUpInside)
        cell.plusBtn.addTarget(self, action: #selector(plusValue), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(deleteValue), for: .touchUpInside)
        
        return cell
    }
    
    @objc func minusValue(sender: UIButton) {
        var currentValue = selectedList[sender.tag].value
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? PriceCell {
            if currentValue != 1 {
                currentValue -= 1
                selectedList[sender.tag].value = currentValue
                cell.valueLabel.text = String(currentValue)
                getData()
            } else {
                currentValue = 1
            }
        }
        
    }
    
    @objc func plusValue(sender: UIButton) {
        var currentValue = selectedList[sender.tag].value
        
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? PriceCell {
            currentValue += 1
            selectedList[sender.tag].value = currentValue
            cell.valueLabel.text = String(currentValue)
            
            getData()
        }
    }
    
    @objc func deleteValue(sender: UIButton) {
        selectedList.remove(at: sender.tag)
        tableView.reloadData()
        getData()
    }
}


