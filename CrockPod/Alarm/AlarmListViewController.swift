import UIKit

class AlarmListViewController: UIViewController {

  @IBOutlet weak var alarmCollectionView: UICollectionView!
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
    alarmList.append(Alarm(hour: 8, minute: 00, podcast: Podcast(name: "Simpsons Christmas Boogie"), repeatDays: [false, false, true, false, true, false, false], enabled: true))
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.alarmCollectionView.contentInset.bottom = 75
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

extension AlarmListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return alarmList.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alarmCell", for: indexPath) as! AlarmCollectionViewCell
    let alarm = alarmList[indexPath.row]

    cell.alarmTime.text = formatTimeFor(alarm)
    cell.repeatDays.text = getRepeatDaysText(alarm)
    cell.podcastTitle.text = alarm.podcast.name
    cell.enabledSwitch.isOn = alarm.enabled

    return cell
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.size.width, height: CGFloat(75))
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
    let repeatDayIndices = (0..<7).filter({ alarm.repeatDays[$0] })

    if (repeatDayIndices.count == 7) {
      return "Every day"
    }

    if ((1..<6).elementsEqual(repeatDayIndices)) {
      return "Weekdays"
    }

    if (repeatDayIndices == [0, 6]) {
      return "Weekends"
    }

    if (repeatDayIndices.count == 1) {
      return Calendar.current.weekdaySymbols[repeatDayIndices[0]] + "s"
    }

    return (0..<7)
      .filter({ alarm.repeatDays[$0] })
      .map({ Calendar.current.shortWeekdaySymbols[$0] })
      .joined(separator: ", ")
  }
}
