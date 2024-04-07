//
//  MyPageViewController.swift
//  Kiosk
//
//  Created by imhs on 4/4/24.
//

import UIKit
import MobileCoreServices

class MyPageViewController: UIViewController {
    var topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var topLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pineappleLogo"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topSearch: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topBag: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bag"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topEqual: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "equal"))
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var accountView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var accountLoginStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "로그아웃"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.8078433871, blue: 0.8121486306, alpha: 1)
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    // MARK: - profile 뷰
    var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - profile 이미지
    var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemPink
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
        
    // MARK: - profile 이름
    var myNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - profile 메일
    var myEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 장바구니 테이블이 들어가는 뷰
    var cartListView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - 장바구니
    var cartName: UILabel = {
        let label = UILabel()
        label.text = "🖥️ 장바구니"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 테이블 뷰 추가
    var cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 15
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
                
    override func viewDidLoad() {
        super.viewDidLoad()
                
        profileUI()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)
        cartTableView.dataSource = self
        cartTableView.rowHeight = 90
        // 셀 클래스 등록
        cartTableView.register(MyPageCartTableViewCell.self, forCellReuseIdentifier: "CartCellId")
        
        getProfile()
    }
    
    // MARK: - 테이블 뷰 새로고침
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //마이페이지에 있다가 다시 상품으로 돌아가 카트를 추가하고 마이페이지로 돌아왔을때 화면변화가 없어서 추가해줘야함
        cartTableView.reloadData()
    }
    
    // MARK: - 프로필 가져오기
    func getProfile() {
        let myProfile = MyProfile(name: "파인애플", email: "fineapple@fineapple.com", image: UIImage(named: "myProfile"))
        myNameLabel.text = myProfile.name + " 님, 안녕하세요."
        myImageView.image = myProfile.image
        myEmail.text = myProfile.email
    }
    
    func profileUI() {
        //top
        view.addSubview(topView)
        view.addSubview(topLogo)
        view.addSubview(topSearch)
        view.addSubview(topBag)
        view.addSubview(topEqual)
        //계정
        view.addSubview(accountView)
        view.addSubview(accountLabel)
        view.addSubview(accountLoginStatusLabel)
        view.addSubview(lineView)
        //프로필
        view.addSubview(profileView)
        view.addSubview(myImageView)
        view.addSubview(myNameLabel)
        view.addSubview(myEmail)
        //장바구니
        view.addSubview(cartListView)
        view.addSubview(cartName)
        view.addSubview(cartTableView)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            topLogo.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topLogo.widthAnchor.constraint(equalToConstant: 50),
            topLogo.heightAnchor.constraint(equalToConstant: 50),
            topLogo.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.05),
            
            topSearch.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topSearch.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.6),
            
            topBag.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topBag.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.75),
            
            topEqual.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            topEqual.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: view.bounds.width * 0.9),
            
            accountView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            accountView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.075),
            
            accountLabel.centerYAnchor.constraint(equalTo: accountView.centerYAnchor),
            accountLabel.leadingAnchor.constraint(equalTo: accountView.leadingAnchor, constant: view.bounds.width * 0.05),
            
            accountLoginStatusLabel.centerYAnchor.constraint(equalTo: accountView.centerYAnchor),
            accountLoginStatusLabel.trailingAnchor.constraint(equalTo: accountView.trailingAnchor, constant: view.bounds.width * (-0.05)),
            
            lineView.topAnchor.constraint(equalTo: accountView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            //회원정보
            profileView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            //사진
            myImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 10),
            myImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 10),
            myImageView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -10),
            myImageView.widthAnchor.constraint(equalToConstant: 100),
            //이름
            myNameLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 40),
            myNameLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10),
            //이메일
            myEmail.topAnchor.constraint(equalTo: myNameLabel.bottomAnchor, constant: 5),
            myEmail.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 10),
            
            //장바구니 뷰
            cartListView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            cartListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cartListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cartListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            //장바구니 타이틀
            cartName.topAnchor.constraint(equalTo: cartListView.topAnchor, constant: 10),
            cartName.leadingAnchor.constraint(equalTo: cartListView.leadingAnchor, constant: 10),
            cartName.trailingAnchor.constraint(equalTo: cartListView.trailingAnchor, constant: -10),
            //장바구니 테이블뷰
            cartTableView.topAnchor.constraint(equalTo: cartName.bottomAnchor, constant: 10),
            cartTableView.leadingAnchor.constraint(equalTo: cartListView.leadingAnchor, constant: 10),
            cartTableView.trailingAnchor.constraint(equalTo: cartListView.trailingAnchor, constant: -10),
            cartTableView.bottomAnchor.constraint(equalTo: cartListView.bottomAnchor, constant: -10)
        ])
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListManager.shared.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellId", for: indexPath) as? MyPageCartTableViewCell
        
        cell?.productImage.image = ListManager.shared.list[indexPath.row].image
        cell?.productName.text = ListManager.shared.list[indexPath.row].name
        
        //자리수 구분 추가
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: ListManager.shared.list[indexPath.row].price)) {
            cell?.productPrice.text = formattedPrice + "원"
        }
        //cell?.productPrice.text = String(ListManager.shared.list[indexPath.row].price) + "원"
        cell?.productValue.text = String(ListManager.shared.list[indexPath.row].value) + "개"
 
        return cell ?? UITableViewCell()
    }
}
