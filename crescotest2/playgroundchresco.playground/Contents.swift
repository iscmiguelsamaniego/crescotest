
import Foundation

func lastSundays(of year: Int) -> [Date] {
    
    let calendar = Calendar.current
    var dates = [Date]()
    
    for month in 1...12 {
        
        var dateComponents = DateComponents(calendar: calendar,
                                            year: year,
                                            month: month + 1,
                                            day: 0,
                                            hour: 12)
        
        let date = calendar.date(from: dateComponents)!
        let weekday = calendar.component(.weekday, from: date)
        
        if weekday != 1 {
            dateComponents.day! -= weekday - 1
        }
        
        dates.append(calendar.date(from: dateComponents)!)
    }
    return dates
}

func getLeapYears(_ years: [Int]){
    
    for year in years {
        if year % 4 == 0 {
            if year % 100 == 0 && year % 400 != 0 {
                print("No es un año bisiesto")
            } else {
                print("\(year) Es bisiesto")
            }
        } else {
            print(year, terminator: " @ ")
            print("No es una año bisiesto")
        }
    }
}

func getLettersRepeating(word: String){
    let dict = word.reduce([:]) { (d, c) -> Dictionary<Character,Int> in
        var d = d
        let i = d[c] ?? 0
        d[c] = i+1
        return d
    }
    print(dict)
}

func getFullContent(path: String){
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    do {
        let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
        print(fileURLs)
    } catch {
        print("Error al enumerar archivos \(documentsURL.path): \(error.localizedDescription)")
    }
   
}

var dateFormatter = DateFormatter()
dateFormatter.dateStyle = .short
print(lastSundays(of: 2018).map(dateFormatter.string).joined(separator: "\n"))

getLeapYears([2001, 2002, 2003, 2004, 2005])

getLettersRepeating(word: "qbbzhggfdwvezeepvzqiyytfessddv")

getFullContent(path: ".")

