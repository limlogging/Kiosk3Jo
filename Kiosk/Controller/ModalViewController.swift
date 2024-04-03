//
//  ModalViewController.swift
//  Kiosk
//
//  Created by Dongik Song on 4/3/24.
//

import UIKit

class ModalViewController: UIViewController {
    

    private lazy var tableView : UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: Constants.cellName, bundle: nil), forCellReuseIdentifier: Constants.cellName)
        
        return table
    }()
    
    private lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var countLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    let numberFormatter = NumberFormatter()
    
    var totalCount = 0
    var totalPrice = 0
    
    var selectedList: [AppleProduct] = [AppleProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        numberFormatter.numberStyle = .decimal
        
        applyConstraints()
        
        priceLabel.text = "0 원"
        countLabel.text = "0 개"
        
        tableView.rowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        
    }
    
    func applyConstraints () {

        view.addSubview(priceLabel)
        view.addSubview(countLabel)
        view.addSubview(tableView)
        
        let priceLabelConstraints = [
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        
        ]
        
        let countLabelConstraints = [
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            countLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            tableView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ]
        
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(countLabelConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func getData() {
        totalCount = selectedList.map{$0.value}.reduce(0, +)
        totalPrice = selectedList.map{$0.value * $0.price}.reduce(0, +)
        //priceLabel.text = "\(numberFormatter.string(from: totalPrice as NSNumber) ?? "0") 원"
        //countLabel.text = "\(String(totalCount)) 개"
    }
    
}

extension ModalViewController: UITableViewDelegate, UITableViewDataSource {
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
        cell.priceLabel.text = numberFormatter.string(from: selectedList[currentLocation].price as NSNumber)
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
