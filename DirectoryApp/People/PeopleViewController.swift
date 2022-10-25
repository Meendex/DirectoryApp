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
    let viewModel = PeopleViewModel()
    @IBOutlet weak var tableView: UITableView!
    var bag: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        Task {
            await viewModel.getPeopleAsync()
        }
        
        let cancellable = viewModel.$peopleDetails.receive(on: RunLoop.main).sink { _ in
            self.tableView.reloadData()

        }
//        let cancellable = viewModel.$peopleList.sink(receiveValue: { _ in
//            DispatchQueue.main.async {
//            }
//        })
        
        bag.insert(cancellable)

    }
}
extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peopleRecordCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as? PeopleTableViewCell else {
            return UITableViewCell()
        }
        let people = viewModel.getPeopleModel(index: indexPath.row)
        cell.updateDisplayData(with: people)
        
        viewModel.getPeopleImage(for: indexPath.row) { imageData in
            DispatchQueue.main.async {
                cell.avatarImageView.image = UIImage(data: imageData)
            }
        }
        return cell
    }
}
