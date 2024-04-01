//
//  ViewController.swift
//  Kiosk
//
//  Created by imhs on 4/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    var selectedList: [AppleProduct] = [AppleProduct]()
    
    
    var totalCount = 0
    var totalPrice = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // MacBook 데이터
    let macBook = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "MacBook Pro", price: 2000000, value: 1)
    
    // iPhone 데이터
    let iPhone = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "iPhone 12", price: 1000000, value: 1)
    
    // iPad 데이터
    let iPad = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "iPad Pro", price: 800000, value: 1)
    
    // Apple Watch 데이터
    let appleWatch = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "Apple Watch Series 6", price: 500000, value: 1)
    
    // 기타 액세서리 데이터
    let etcAccessory = AppleProduct(image: UIImage(named: "iPhone15ProMax"), name: "AirPods Pro", price: 300000, value: 1)
    
    func getData() {
        
        totalCount = selectedList.map{$0.value}.reduce(0, +)
        totalPrice = selectedList.map{Int($0.value * $0.price)}.reduce(0, +)
        
        priceLabel.text = "\(String(totalPrice)) 원"
        countLabel.text = "\(String(totalCount)) 개"
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


