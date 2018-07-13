class Alarm {
  init(hour: Int, minute: Int, podcast: Podcast, repeatDays: [Bool], enabled: Bool) {
    self.hour = hour
    self.minute = minute
    self.podcast = podcast
    self.repeatDays = repeatDays
    self.enabled = enabled
  }

  public var hour: Int
  public var minute: Int
  public var podcast: Podcast
  public var repeatDays: [Bool] = [false, false, false, false, false, false, false] // Sunday first
  public var enabled: Bool
}
