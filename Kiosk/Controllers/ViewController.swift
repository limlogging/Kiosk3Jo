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
    
    var filteredProducts: [AppleProduct] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    
    
// MARK: - viewDidLoad 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
        
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
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

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


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingBetweenCells: CGFloat = 10
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        let height = width
        return CGSize(width: width, height: height)
    }
}
