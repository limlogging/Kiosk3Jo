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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        
        productSegment.selectedSegmentIndex = 0
        segmentValueChanged(productSegment)
    }
    

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                print("맥북탭")
                mainCollectionView.backgroundColor = .yellow
                filteredProducts = dataManager.products.filter { $0.category == "맥북" }
            case 1:
                print("아이폰탭")
                mainCollectionView.backgroundColor = .blue
                filteredProducts = dataManager.products.filter { $0.category == "아이폰" }
            case 2:
                print("패드탭")
                mainCollectionView.backgroundColor = .green
                filteredProducts = dataManager.products.filter { $0.category == "패드" }
            case 3:
                print("애플워치탭")
                mainCollectionView.backgroundColor = .gray
                filteredProducts = dataManager.products.filter { $0.category == "워치" }
            case 4:
                print("악세사리탭")
                mainCollectionView.backgroundColor = .brown
                filteredProducts = dataManager.products.filter { $0.category == "악세사리" }
            default:
                break
            }
            
            mainCollectionView.reloadData()
        }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = filteredProducts[indexPath.item]
        cell.configure(with: product)
        
        //컬렉션 뷰 레이아웃 (콜렉션뷰의 사이즈 확인)
        // cell 크기 확인
        return cell
        
    }

}

//상위 위드헤이트로 조절
//현재는 레이블기준으로만 되ㅏ어있는ㅅ ㅏㅇ태

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = mainCollectionView.bounds.width
        
        // 가로 방향에는 한 번에 하나의 셀만 표시되도록 설정
        let width = collectionViewWidth
        
        // 세로 방향에는 컬렉션 뷰의 전체 높이에 맞게 셀의 크기를 조절
        let height = mainCollectionView.bounds.height
        
        return CGSize(width: width, height: height)
    }
}
