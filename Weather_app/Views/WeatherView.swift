import SwiftUI

// Custom Shape for rounded corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Extension to make corner radius work with specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// Tokyo Night Color Scheme
extension Color {
    static let tokyoNight = TokyoNightColors()
    
    struct TokyoNightColors {
        let background = Color(red: 0.09, green: 0.09, blue: 0.12) // #16161e
        let surface = Color(red: 0.15, green: 0.15, blue: 0.21) // #24283b
        let surfaceLight = Color(red: 0.18, green: 0.20, blue: 0.25) // #2f334d
        let primary = Color(red: 0.45, green: 0.69, blue: 1.0) // #7aa2f7
        let secondary = Color(red: 0.73, green: 0.73, blue: 0.78) // #bbb5c6
        let accent = Color(red: 0.67, green: 0.31, blue: 0.93) // #ab4ded
        let success = Color(red: 0.45, green: 0.77, blue: 0.49) // #73daca
        let warning = Color(red: 0.90, green: 0.66, blue: 0.31) // #e0af68
        let error = Color(red: 0.96, green: 0.38, blue: 0.38) // #f7768e
        let text = Color(red: 0.75, green: 0.78, blue: 0.85) // #c0caf5
        let textMuted = Color(red: 0.55, green: 0.58, blue: 0.66) // #9094a8
        let purple = Color(red: 0.73, green: 0.55, blue: 1.0) // #bb9af7
        let cyan = Color(red: 0.45, green: 0.85, blue: 0.79) // #73daca
        let orange = Color(red: 1.0, green: 0.65, blue: 0.31) // #ff9e64
    }
}

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                        .foregroundColor(.tokyoNight.text)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                        .foregroundColor(.tokyoNight.textMuted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: getWeatherIcon(for: weather.weather[0].main))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(getWeatherIconColor(for: weather.weather[0].main))
                                .font(.system(size: 40))
                                .shadow(color: .black.opacity(0.3), radius: 4)
                            
                            Text("\(weather.weather[0].main)")
                                .foregroundColor(.tokyoNight.text)
                                .font(.headline)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100, weight: .ultraLight, design: .rounded))
                            .foregroundColor(.tokyoNight.text)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                            .opacity(0.8)
                    } placeholder: {
                        ProgressView()
                            .tint(.tokyoNight.primary)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.tokyoNight.text)
                        .padding(.bottom, 5)
                    
                    HStack {
                        WeatherRow(logo: "thermometer.low", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                        Spacer()
                        WeatherRow(logo: "thermometer.high", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .padding(.bottom, 20)
                .background(
                    Color.tokyoNight.surface
                        .opacity(0.95)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        colors: [Color.tokyoNight.primary.opacity(0.3), Color.tokyoNight.accent.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        )
                )
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.4), radius: 16, x: 0, y: -4)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            LinearGradient(
                colors: [
                    .tokyoNight.background,
                    Color.tokyoNight.surface.opacity(0.8),
                    .tokyoNight.primary.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .preferredColorScheme(.dark)
    }
    
    private func getWeatherIcon(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain", "drizzle":
            return "cloud.rain.fill"
        case "thunderstorm":
            return "cloud.bolt.rain.fill"
        case "snow":
            return "cloud.snow.fill"
        case "mist", "fog":
            return "cloud.fog.fill"
        default:
            return "cloud.sun.fill"
        }
    }
    
    private func getWeatherIconColor(for condition: String) -> Color {
        switch condition.lowercased() {
        case "clear":
            return .tokyoNight.warning
        case "clouds":
            return .tokyoNight.secondary
        case "rain", "drizzle":
            return .tokyoNight.primary
        case "thunderstorm":
            return .tokyoNight.accent
        case "snow":
            return .tokyoNight.text
        case "mist", "fog":
            return .tokyoNight.textMuted
        default:
            return .tokyoNight.cyan
        }
    }
}

#Preview {
    let sample = ResponseBody(
        coord: .init(lon: 0.0, lat: 0.0),
        weather: [.init(id: 800.0, main: "Clear", description: "clear sky", icon: "01d")],
        main: .init(temp: 22.0, feels_like: 22.0, temp_min: 18.0, temp_max: 26.0, pressure: 1013.0, humidity: 40.0),
        name: "Sample City",
        wind: .init(speed: 3.5, deg: 120.0)
    )
    return WeatherView(weather: sample)
}

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: logo)
                .font(.title3)
                .frame(width: 32, height: 32)
                .foregroundColor(.tokyoNight.primary)
                .padding(8)
                .background(
                    Color.tokyoNight.surfaceLight
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.tokyoNight.primary.opacity(0.2), lineWidth: 1)
                        )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.caption)
                    .foregroundColor(.tokyoNight.textMuted)
                Text(value)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.tokyoNight.text)
            }
        }
    }
}

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
