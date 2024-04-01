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
    
    var filteredProducts: [AppleProduct] = [] {
        didSet {
            mainCollectionView.reloadData()
        }
    }

// MARK: - viewDidLoad 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
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


// MARK: - collectionview 내 셀 크기 커스텀
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }

}
