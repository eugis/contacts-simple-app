//
//  ViewController.swift
//  Contacts
//
//  Created by Eugis on 1/27/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import UIKit

class ContactListTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy private var contactListViewModel = ContactListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }

}

extension ContactListTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactListViewModel.sectionCounts
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contactClass = ContactsClass(rawValue: UInt(section)) else { return 0 }
        return contactListViewModel.rows(in: contactClass)
    }
    
}

extension ContactListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contactClass = ContactsClass(rawValue: UInt(indexPath.section)) else { return }
        guard let contactViewModel = contactListViewModel.contactViewModel(for: indexPath.row, in: contactClass) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: .none)
        let viewController = storyboard.instantiateViewController(withIdentifier: ContactDetailViewController.StoryboardIdentifier)
        if let detailViewController = viewController as? ContactDetailViewController {
            detailViewController.initialize(with: contactViewModel)
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactViewCell.reuseIdentifier, for: indexPath) as? ContactViewCell else { return UITableViewCell() }
        guard let contactClass = ContactsClass(rawValue: UInt(indexPath.section)) else { return UITableViewCell() }
        guard let viewModel = contactListViewModel.contactViewModel(for: indexPath.row, in: contactClass) else { return UITableViewCell() }
        cell.bind(viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContactsClass(rawValue: UInt(section))?.title.uppercased()
    }
}

fileprivate extension ContactListTableViewController {
    
    fileprivate func bindViewModel() {
        title = contactListViewModel.title
        // This should be in viewWillAppear if it were necessary to update every time
        contactListViewModel.contacts.producer
                                        .on(value: { [weak self] _ in self?.tableView.reloadData() })
                                        .start()
        
        contactListViewModel.fetchContacts()
    }
    
    fileprivate func configureTableView() {
        tableView.register(cell: ContactViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = ContactViewCell.cellHeight
        
        // Remove unused rows
        tableView.tableFooterView = UIView()
    }
}
