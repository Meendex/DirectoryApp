//
//  PeopleViewController.swift
//  DirectoryApp
//
//  Created by Mindaugas Balakauskas on 23/10/2022.
//

import UIKit
import Combine

class PeopleViewController: UIViewController {
    private var isLoading = false
    var viewModel: PeopleViewModel?
    @IBOutlet weak var tableView: UITableView!
    var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let cancellable = viewModel?.$peopleList.sink(receiveValue: { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        guard let cancellable = cancellable
        else {
            return
        }
        bag.insert(cancellable)
        Task {
            await viewModel?.getPeopleAsync()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.peopleRecordCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        if let viewModel = viewModel {
            let people = viewModel.getPeopleModel(index: indexPath.row)
            cell.updateDisplayData(with: people)
            Task {
                let imageData = await viewModel.getPeopleImage(for: indexPath.row)
                if let imageData = imageData {
                    cell.avatarImageView.image = UIImage(data: imageData)
                }
            }
        }
        return cell
    }
}
