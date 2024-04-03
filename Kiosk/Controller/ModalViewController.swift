//
//  ModalViewController.swift
//  Kiosk
//
//  Created by Dongik Song on 4/3/24.
//

protocol sendList: AnyObject {
    func sendData (dataList: [AppleProduct])
}

import UIKit

class ModalViewController: UIViewController {
    // MARK: - 장바구니 목록 테이블뷰
    private lazy var tableView : UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UINib(nibName: Constants.cellName, bundle: nil), forCellReuseIdentifier: Constants.cellName)
        
        return table
    }()
    
    // MARK: - 가격
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 수량
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - 버튼 뷰
    private var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - 문의하기 버튼
    private lazy var questionButton: UIButton = {
        let button = UIButton()
        button.setTitle("문의하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(questionAlert(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 주문하기 버튼
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("주문하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderAlert(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - 취소하기 버튼
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cancelAlert(_:)), for: .touchUpInside)
        return button
    }()
    
    let numberFormatter = NumberFormatter()
    
    weak var delegate: sendList?
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
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        getData()
    }
    
    func getData() {
        totalCount = selectedList.map{$0.value}.reduce(0, +)
        totalPrice = selectedList.map{$0.value * $0.price}.reduce(0, +)
        priceLabel.text = "\(numberFormatter.string(from: totalPrice as NSNumber) ?? "0") 원"
        countLabel.text = "\(String(totalCount)) 개"
    }
    
    func applyConstraints () {
        view.addSubview(priceLabel)
        view.addSubview(countLabel)
        view.addSubview(tableView)
        
        view.addSubview(buttonView)
        view.addSubview(questionButton)
        view.addSubview(orderButton)
        view.addSubview(cancelButton)
        
        let priceLabelConstraints = [
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let countLabelConstraints = [
            countLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            countLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ]
        
        let tableViewConstraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            //tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            tableView.bottomAnchor.constraint(equalTo: buttonView.topAnchor, constant: -10)
        ]
        let buttonViewConstraints = [
            buttonView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buttonView.heightAnchor.constraint(equalToConstant: 50)
        ]
        let questionButtonConstraints = [
            questionButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            questionButton.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            questionButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.3) //width를 viwe의 30%로 지정
        ]
        let orderButtonConstraints = [
            orderButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            orderButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            orderButton.leadingAnchor.constraint(equalTo: questionButton.trailingAnchor, constant: buttonView.bounds.width * 0.05),     //왼쪽 간격 5%
            orderButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.3)    //width를 viwe의 30%로 지정
        ]
        let cancelButtonConstraints = [
            cancelButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: orderButton.trailingAnchor, constant: buttonView.bounds.width * 0.05),   //왼쪽 간격 5%
            cancelButton.widthAnchor.constraint(equalTo: buttonView.widthAnchor, multiplier: 0.3)   //width를 viwe의 30%로 지정
        ]
        
        
        NSLayoutConstraint.activate(priceLabelConstraints)
        NSLayoutConstraint.activate(countLabelConstraints)
        NSLayoutConstraint.activate(tableViewConstraints)
        
        NSLayoutConstraint.activate(buttonViewConstraints)
        NSLayoutConstraint.activate(questionButtonConstraints)
        NSLayoutConstraint.activate(orderButtonConstraints)
        NSLayoutConstraint.activate(cancelButtonConstraints)
    }
    
    // MARK: - 문의하기 버튼 이벤트
    @objc func questionAlert(_ sender: UIButton) {
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
    
    // MARK: - 주문하기 버튼 이벤트
    @objc func orderAlert(_ sender: UIButton) {
        if selectedList.isEmpty {
            let oAlert = UIAlertController(title: "주문불가", message: "장바구니에 담긴 상품이 없습니다. 상품을 추가해주세요.", preferredStyle: .alert)
            let yes = UIAlertAction(title: "네", style: .default)
            oAlert.addAction(yes)
            self.present(oAlert, animated: true)
        } else {
            let oAlert = UIAlertController(title: "주문하기", message: "담으신 상품을 결제하시겠습니까?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "네", style: .default) { action in
                self.selectedList.removeAll()
                self.delegate?.sendData(dataList: self.selectedList)
                self.getData()
                self.tableView.reloadData()
            }
            let no = UIAlertAction(title: "아니오", style: .cancel)
            oAlert.addAction(yes)
            oAlert.addAction(no)
            self.present(oAlert, animated: true)
        }
    }
    
    // MARK: - 취소하기 버튼 이벤트
    @objc func cancelAlert(_ sender: UIButton) {
        if selectedList.isEmpty {
            let cAlert = UIAlertController(title: "취소불가", message: "취소할 상품이 없습니다.", preferredStyle: .alert)
            let yes = UIAlertAction(title: "네", style: .default)
            cAlert.addAction(yes)
            self.present(cAlert, animated: true)
        } else {
            let cAlert = UIAlertController(title: "주문 취소", message: "상품을 모두 삭제하시겠습니까?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "네", style: .default) { action in
                self.selectedList.removeAll()
                self.delegate?.sendData(dataList: self.selectedList)
                self.getData()
                self.tableView.reloadData()
            }
            let no = UIAlertAction(title: "아니오", style: .cancel)
            cAlert.addAction(yes)
            cAlert.addAction(no)
            self.present(cAlert, animated: true)
        }
    }
}

// MARK: - TableView Handler
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
    
    // MARK: - - 버튼 이벤트
    @objc func minusValue(sender: UIButton) {
        var currentValue = selectedList[sender.tag].value
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? PriceCell {
            if currentValue != 1 {
                currentValue -= 1
                selectedList[sender.tag].value = currentValue
                cell.valueLabel.text = String(currentValue)
                self.delegate?.sendData(dataList: selectedList)
                getData()
            } else {
                currentValue = 1
            }
        }
        
    }
    
    // MARK: - + 버튼 이벤트
    @objc func plusValue(sender: UIButton) {
        var currentValue = selectedList[sender.tag].value
        
        if let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? PriceCell {
            currentValue += 1
            selectedList[sender.tag].value = currentValue
            cell.valueLabel.text = String(currentValue)
            self.delegate?.sendData(dataList: selectedList)
            getData()
        }
    }
    
    // MARK: - x 버튼 이벤트
    @objc func deleteValue(sender: UIButton) {
        selectedList.remove(at: sender.tag)
        tableView.reloadData()
        self.delegate?.sendData(dataList: selectedList)
        getData()
    }
}
