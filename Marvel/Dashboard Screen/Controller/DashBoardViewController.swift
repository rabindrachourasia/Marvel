
//
//  DashBoardViewController.swift
//  Marvel
//
//  Created by Rabi Chourasia on 12/03/22.
//

import UIKit

class DashBoardViewController: UIViewController, AlertPresenter {
    
    @IBOutlet private weak var listTableView: UITableView!
    private var viewModel : MarvelCharacterListViewModel = MarvelCharacterListViewModel()
    private var detailsViewModel : MarvelDetailsViewModel = MarvelDetailsViewModel()
    private var marvelList : [MarvelListResult] = []
    private var detailsData : [MarvelListResult] = []
    private let spinner = UIActivityIndicatorView(style: .large)
    private var offset : Int = 0
    private var loadingStatus : Bool = false
    private var pullControl = UIRefreshControl()
    var titleLabel : UILabel {
        let title = UILabel(frame: .init(x: 0, y: 0, width: 80.0, height: 22))
        title.text = "Marvel List"
        title.font = UIFont(name: "AvenirNext-DemiBold", size: 16.0)
        title.textColor = UIColor(red: 26.0/255.0, green: 34.0/255.0, blue: 88.0/255.0, alpha: 1.0)
        return title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        loadCharacterListData()
        pulltoRefreshSetup()
        apiresponseSetup()
    }
    private func initialSetup(){
        self.navigationItem.titleView = titleLabel
        spinner.startAnimating()
        listTableView.backgroundView = spinner
        let cellName = String(describing: ProductListCell.self)
        self.listTableView.register(UINib.init(nibName: cellName, bundle: .main), forCellReuseIdentifier: cellName)
        //Register Loading Cell
        let loadercellName = String(describing: LoadingCell.self)
        self.listTableView.register(UINib.init(nibName: loadercellName, bundle: .main), forCellReuseIdentifier: loadercellName)
        
    }
    private func pulltoRefreshSetup(){
        pullControl.backgroundColor = UIColor.clear
        pullControl.tintColor = UIColor.black
        pullControl.addTarget(self, action: #selector(refreshListData(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            listTableView.refreshControl = pullControl
        } else {
            listTableView.addSubview(pullControl)
        }
    }
    
    //MARK:- Pull to Refresh Actions
    @objc private func refreshListData(_ sender: Any) {
        self.pullControl.endRefreshing() // You can stop after API Call
        //MARK:- Call API
        loadingStatus = false
        offset = 0
        loadCharacterListData()
    }
    
    private func loadCharacterListData(){
        if !loadingStatus {
            loadingStatus = true
            spinner.startAnimating()
            listTableView.backgroundView = spinner
            viewModel.getMarvelList(offset: offset)
        }
    }
    
    private func apiresponseSetup(){
        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                guard let data = self?.viewModel.marvelList, data.count > 0 else {
                    self?.loadingStatus = true
                    return }
                self?.loadingStatus = false
                self?.marvelList.append(contentsOf: data)
                self?.listTableView.reloadData()
                self?.listTableView.isHidden = false
                self?.spinner.stopAnimating()
                self?.listTableView.backgroundView = nil
            }
        }
        
        viewModel.onFailure = { [weak self] netError in
            DispatchQueue.main.async {
                self?.loadingStatus = false
                self?.spinner.stopAnimating()
                self?.listTableView.reloadData()
                self?.listTableView.backgroundView = nil
                switch netError{
                case ErrorType.noInternet:
                    self?.showErrorAlert(message: Constants.alertMsg.no_internet)
                case .other:
                    self?.showErrorAlert(message: Constants.alertMsg.server_not_responding)
                case .missingAPIKey:
                    self?.showErrorAlert(message: Constants.alertMsg.api_keys_not_found)
                }
            }
        }
    }
}

//MARK:- UITableview Datasource & Deletgate
extension DashBoardViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return marvelList.count
        } else if section == 1 {
            // loading cell
            return 1
        } else {
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductListCell.self)) as? ProductListCell
            cell?.wrapView(model: marvelList[indexPath.row])
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            
            if self.loadingStatus && marvelList.count > 0 {
                cell.activityIndicator.isHidden = false
                cell.activityIndicator.startAnimating()
            } else {
                cell.activityIndicator.isHidden = true
                cell.activityIndicator.stopAnimating()
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return UITableView.automaticDimension  //Item Cell height
        } else {
            return 55 //Loading Cell height
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = self.marvelList[indexPath.row].id else { return }
        self.detailsViewModel.getListDetails(id: id)
        self.detailsViewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.detailsData = self?.detailsViewModel.marvelCharacterDetails ?? []
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: String(describing: MarvelCharacterDetailsViewController.self)) as? MarvelCharacterDetailsViewController else { return }
                vc.model = self?.detailsViewModel.marvelCharacterDetails ?? []
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

//MARK:- UIScrollViewDelegate
extension DashBoardViewController : UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            offset += 1
            loadCharacterListData()
            self.listTableView.reloadData()
        }
    }
}
