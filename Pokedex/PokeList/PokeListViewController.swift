import UIKit

class PokeListViewController: UIViewController {
    private let viewModel = PokeListViewModel()
    private lazy var tableView: PokeListTableView = {
        PokeListTableView.setup(delegate: self,
                                dataSource: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToViewModel()
        
        view.addSubview(tableView)
        tableView.anchor(to: view)
        load()
    }
    
    private func subscribeToViewModel() {
        viewModel.onUpdate = { [weak self] in self?.onUpdate() }
        viewModel.onError = { [weak self] in self?.onError($0) }
    }
    
    private func onUpdate() {
        tableView.reloadData()
    }
    
    private func onError(_ error: Error) {
        
    }
    
    private func load() {
        viewModel.load()
    }
}

extension UIView {
    func anchor(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: view.topAnchor),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     leftAnchor.constraint(equalTo: view.leftAnchor),
                                     rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
}

extension PokeListViewController: UITableViewDelegate {
    
}

extension PokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PokeListTableViewCell.self)") as? PokeListTableViewCell
        cell?.setup(viewModel: viewModel.viewModels[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
