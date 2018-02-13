//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Eugis on 1/27/18.
//  Copyright © 2018 EugeniaSakuda. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift

private enum ContactSection: Int {
    case header
    case information
    
    var cellClass: UITableViewCell.Type {
        switch self {
        case .header: return ContactHeaderViewCell.self
        case .information: return InformationViewCell.self
        }
    }

}

internal class ContactDetailViewController: UIViewController {
    
    static let StoryboardIdentifier = "ContactDetailViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favoriteButton: UIBarButtonItem!
    private var contactViewModel: ContactViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        initializeNavBar()
        bindViewModel()
    }
    
    func initialize(with viewModel: ContactViewModel) {
        contactViewModel = viewModel
    }
    
}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contactViewModel = contactViewModel else { return 0 }
        return section == 0 ? 1 : contactViewModel.informationRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ContactSection(rawValue: indexPath.section) else { return UITableViewCell() }
        guard let cell = tableView.dequeue(cell: section.cellClass, for: indexPath) else { return UITableViewCell() }
        switch section {
        case .header: configureHeader(cell as! ContactHeaderViewCell)
        case .information: configureInformation(cell as! InformationViewCell, row: indexPath.row)
        }
        return cell
    }
    
}

fileprivate extension ContactDetailViewController {
    
    func configureHeader(_ cell:ContactHeaderViewCell) {
        guard let contactViewModel = contactViewModel else { return }
        cell.bind(viewModel: contactViewModel)
    }
    
    func configureInformation(_ cell: InformationViewCell, row: Int) {
        guard let contactViewModel = contactViewModel else { return }
        guard let informationViewModel = contactViewModel.informationViewModel(for: row) else { return }
        cell.bind(information: informationViewModel)
    }
}


fileprivate extension ContactDetailViewController {
    
    func bindViewModel() {
        //Bind action
        if let action = contactViewModel?.favoriteAction {
            favoriteButton.reactive.pressed = CocoaAction(action)
        }
        
        contactViewModel?.contactClass.producer.startWithResult() { [weak self] result in
            guard let value = result.value else { return }
            guard let strongSelf = self else { return }
            strongSelf.favoriteButton.image = UIImage(named: value.imageName)
        }
    }
    
    fileprivate func initializeNavBar() {
        favoriteButton = UIBarButtonItem(image: UIImage(named: "icon-favorite-false"),
                                         style: .plain,
                                         target: .none,
                                         action: .none)
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    fileprivate func initializeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.register(cell: ContactHeaderViewCell.self)
        tableView.register(cell: InformationViewCell.self)
    }
}
