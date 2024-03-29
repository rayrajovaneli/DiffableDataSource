//
//  ViewController.swift
//  DiffableDataSource
//
//  Created by user218260 on 5/26/22.
//

import UIKit

struct User: Hashable{
    var name: String
    var backgroundColor: UIColor
    var section: Section
}


enum Section: String, CaseIterable{
    case main = "Geral"
    case vip = "VIP"
    case work = "Trabalho"
}

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        
        return tableView
    }()
    
    typealias UserDataSource = UITableViewDiffableDataSource<Section, User>
    typealias UserSnapshot = NSDiffableDataSourceSnapshot<Section, User>
    
    private lazy var dataSource: UserDataSource = createDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let data = setupMockData()
        updateSnapshot(with: data)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAdd))
    }
    
    @objc func handleAdd(){
        guard let randowSection = Section.allCases.randomElement()
        else{
            return 
        }
        let user = User(name: UUID().uuidString, backgroundColor: .randow(), section: randowSection)
        addItemSnapshot(with: [user], section: randowSection)
    }

    func createDataSource() -> UserDataSource{
        UITableViewDiffableDataSource(tableView: tableView) {tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = user.name
            cell.backgroundColor = user.backgroundColor
            return cell
        }
    }
    
    func updateSnapshot(with values:[User]){
        var snapshot = UserSnapshot()
        snapshot.appendSections(Section.allCases)
        Section.allCases.forEach{ section in
            let filterUsers = values.filter {$0.section == section}
                snapshot.appendItems(filterUsers, toSection: section)
            
        }
        //
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func addItemSnapshot(with user: [User], section: Section){
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(user, toSection: section)
        dataSource.apply(snapshot)
    }
    func remove(_ user: User){
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([user])
        dataSource.apply(snapshot)
    }
}

extension ViewController: ViewCode{
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func addConstraints() {
        tableView.fillSuperView()
    }
    
}
extension ViewController{
    func setupMockData() -> [User]{
        [User(name: "Rayra", backgroundColor: .systemBlue, section: .main),
         User(name: "Jade", backgroundColor: .systemRed, section: .vip),
         User(name: "Pedro", backgroundColor: .systemCyan, section: .work)]
    }
}

extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else {return}
        remove(user)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section.allCases[section]
        let label = UILabel()
        label.text = section.rawValue
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
