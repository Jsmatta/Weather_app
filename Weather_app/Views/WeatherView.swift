import SwiftUI

struct WeatherView: View {
    let weather: ResponseBody

    var body: some View {
        VStack(spacing: 16) {
            Text(weather.name)
                .font(.largeTitle).bold()
            if let first = weather.weather.first {
                Text(first.main + ": " + first.description)
                    .font(.headline)
            }
            Text("Temperature: \(Int(weather.main.temp))°C")
                .font(.title2)
            Text("Feels like: \(Int(weather.main.feels_like))°C")
                .foregroundStyle(.secondary)
            Text("Wind: \(Int(weather.wind.speed)) m/s")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ResponseBody: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind

    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }

    struct Weather: Decodable, Identifiable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }
}

#Preview {
    // Simple placeholder preview
    let sample = ResponseBody(
        coord: .init(lon: 0, lat: 0),
        weather: [.init(id: 0, main: "Clear", description: "clear sky", icon: "01d")],
        main: .init(temp: 22, feels_like: 22, temp_min: 18, temp_max: 26, pressure: 1013, humidity: 40),
        name: "Sample City",
        wind: .init(speed: 3, deg: 100)
    )
    return WeatherView(weather: sample)
}
