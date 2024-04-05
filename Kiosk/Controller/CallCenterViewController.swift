//
//  CallCenterViewController.swift
//  Kiosk
//
//  Created by imhs on 4/4/24.
//

import UIKit

class CallCenterViewController: UIViewController {
    
    private let tableView = UITableView()
    var callCenter: [Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableViewConstraints()
        setupNaviBar()
        setupTableView()
        setupData()
    }

// MARK: - 셀 내 데이터
    func setupData() {
        callCenter = [
            Menu(title: "매장찾기", leftImage: "checkmark.circle", rightImage: "greaterthan.circle"),
            Menu(title: "마이 페이지", leftImage: "person.circle", rightImage: "greaterthan.circle"),
            Menu(title: "이용 약관", leftImage: "list.bullet.rectangle", rightImage: "greaterthan.circle"),
            Menu(title: "개인정보 처리 방침", leftImage: "list.bullet.rectangle", rightImage: "greaterthan.circle"),
            Menu(title: "고객문의", leftImage: "phone.fill", rightImage: "greaterthan.circle"),
            Menu(title: "자주 묻는 질문", leftImage: "tray.2.fill", rightImage: "greaterthan.circle"),
            Menu(title: "국가/언어 변경", leftImage: "globe.asia.australia.fill", rightImage: "greaterthan.circle")
        ]
        tableView.reloadData()
    }
    
// MARK: - 네비게이션 바 옵션
    func setupNaviBar() {
        title = "고객센터"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        tableView.register(CallCenterTableViewCell.self, forCellReuseIdentifier: "CallCenterCell")
    }

    
// MARK: - 테이블 뷰 옵션
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10), // 수정
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10), // 수정
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - 테이블 뷰 델리게이트 , 데이터소스 확장
extension CallCenterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callCenter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CallCenterCell", for: indexPath) as! CallCenterTableViewCell
        let menu = callCenter[indexPath.row]
        cell.selectionStyle = .none
        
        //이미지 블랙으로 변경
        cell.mainLabel.text = menu.title
        if let leftImageName = menu.leftImage {
            cell.leftImageView.image = UIImage(systemName: leftImageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        } else {
            cell.leftImageView.image = nil
        }
        
        if let rightImageName = menu.rightImage {
            cell.rightImageView.image = UIImage(systemName: rightImageName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        } else {
            cell.rightImageView.image = nil
        }
        
        
        return cell
    }
}
