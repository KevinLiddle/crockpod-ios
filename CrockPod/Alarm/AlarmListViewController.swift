import UIKit

class AlarmListViewController: UIViewController {

  @IBOutlet weak var alarmTableView: UITableView!
  var alarmList = [Alarm]()

  override func viewDidLoad() {
    super.viewDidLoad()
    alarmList.append(Alarm(hour: 12, minute: 55, podcast: Podcast(name: "Harry and the Hendersons and all the other stuff"), repeatDays: [true, true, true, false, true, true, true], enabled: true))
    alarmList.append(Alarm(hour: 12, minute: 17, podcast: Podcast(name: "The Office"), repeatDays: [true, false, true, false, true, false, true], enabled: false))
    alarmList.append(Alarm(hour: 3, minute: 9, podcast: Podcast(name: "NPR Hourly News"), repeatDays: [true, false, false, false, false, false, true], enabled: true))
    alarmList.append(Alarm(hour: 18, minute: 33, podcast: Podcast(name: "Lore"), repeatDays: [false, true, true, true, true, true, false], enabled: false))
    alarmList.append(Alarm(hour: 7, minute: 42, podcast: Podcast(name: "NBA Jam or something"), repeatDays: [true, true, true, true, true, true, true], enabled: true))
    alarmList.append(Alarm(hour: 1, minute: 2, podcast: Podcast(name: "Radiolab"), repeatDays: [false, true, false, false, false, false, false], enabled: true))
    alarmList.append(Alarm(hour: 6, minute: 45, podcast: Podcast(name: "Big Third Down"), repeatDays: [true, false, false, false, false, false, false], enabled: true))
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alarmList.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmTableViewCell
    let alarm = alarmList[indexPath.row]

    cell.alarmTime.text = formatTimeFor(alarm)
    cell.repeatDays.text = getRepeatDaysText(alarm)
    cell.podcastTitle.text = alarm.podcast.name
    cell.enabledSwitch.isOn = alarm.enabled

    return cell
  }

  private func formatTimeFor(_ alarm: Alarm) -> String {
    var dateComponents = DateComponents()
    dateComponents.hour = alarm.hour
    dateComponents.minute = alarm.minute

    let time = Calendar.current.date(from: dateComponents)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mma"

    return dateFormatter.string(from: time!)
  }

  private func getRepeatDaysText(_ alarm: Alarm) -> String {
    if (!alarm.repeatDays.contains(false)) {
      return "Every day"
    }

    if (alarm.repeatDays == [false, true, true, true, true, true, false]) {
      return "Weekdays"
    }

    if (alarm.repeatDays == [true, false, false, false, false, false, true]) {
      return "Weekends"
    }

    return (0..<7)
      .filter({ alarm.repeatDays[$0] })
      .map({ Calendar.current.shortWeekdaySymbols[$0] })
      .joined(separator: ", ")
  }
}
