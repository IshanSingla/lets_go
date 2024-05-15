
import UIKit

class MyRideViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var data: [Rides] = []
    private var userRepo: UserRepository!
    private var rideService: RideService!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        userRepo = UserRepository()
        rideService = RideService()
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchMyRides()
    }
        
    private func fetchMyPublishedRides() {
            data = rideService.getAllRidesPublishedByCurrentUser()
            tableView.reloadData()
    }
    
    
    public func fetchMyRides () {
        data = rideService.getAllRidesBookedByCurrentUser()
        tableView.reloadData()
        
    }
    
    @IBAction func onTabChnage(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fetchMyRides()
            
        }else {
            fetchMyPublishedRides()
            
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let publish = data[indexPath.row]
        print(publish)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ridecell") as! MyRideTableViewCell
        
        cell.FromLocation.text = publish.from!.address
        cell.ToLocation.text = publish.to!.address
        cell.RideAmount.text = "Rs \(publish.costPerSeet)"
        cell.RideTime.text = publish.dateTime.description
        cell.UserName.text = publish.user!.name
        cell.Seat1.image = publish.noOfSeetsAvailable < 1 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat2.image = publish.noOfSeetsAvailable < 2 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        cell.Seat3.image = publish.noOfSeetsAvailable < 3 ? UIImage(systemName: "carseat.right"): UIImage(systemName: "carseat.right.fill")
        
//
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MyPublishesSegue", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let BookRideVC = segue.destination as! BookingByRideViewController
//       BookRideVC.publish = data[(tableView.indexPathForSelectedRow?.row)!]
//
//    }


}
