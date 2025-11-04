//
//  SuggestionManager.swift
//  WeatherApp
//
//  Created by Demna Koridze on 04.11.25.
//

import Foundation

class SuggestionManager {
    
    func getSuggestions(for iconName: String) -> [String] {
        return suggestionsForIcon(iconName)
    }
    
    private func suggestionsForIcon(_ iconName: String) -> [String] {
        switch iconName {
        case "rainIcon":
            return [
                "🌧️ Wear a stylish waterproof trench coat with matching umbrella",
                "💼 Protect your electronics with waterproof bags or cases",
                "☕ Enjoy hot chocolate or herbal tea at a cozy café",
                "🎵 Create a rainy day playlist for perfect ambiance",
                "📖 Visit a local library or bookstore for indoor exploration",
                "🍲 Cook a warm, comforting soup or stew for dinner",
                "🚗 Check your windshield wipers and tire tread depth",
                "🏠 Do indoor spring cleaning or organize your space"
            ]
            
        case "cloudyIcon":
            return [
                "💊 Take Vitamin D supplements to boost your mood",
                "🎨 Perfect lighting for photography without harsh shadows",
                "🧥 Layer with a fashionable light sweater or cardigan",
                "🏛️ Explore museums or art galleries with ideal indoor conditions",
                "📚 Start that book you've been meaning to read",
                "🍵 Host a tea tasting party with friends indoors",
                "🌿 Ideal weather for plant shopping and gardening",
                "🎬 Have a movie marathon with comfortable ambient light"
            ]
            
        case "sunIcon":
            return [
                "🌞 Apply SPF 50+ sunscreen and reapply every 2 hours",
                "💦 Carry a reusable water bottle and track your hydration",
                "🕶️ Wear polarized sunglasses for optimal eye protection",
                "👒 Style with a wide-brimmed hat and light, breathable fabrics",
                "🏊 Perfect day for swimming or water-based activities",
                "🌅 Plan an early morning or late evening outdoor exercise",
                "🍉 Enjoy hydrating fruits like watermelon and cucumbers",
                "🎪 Visit outdoor markets or festivals with sun protection"
            ]
            
        case "snowIcon":
            return [
                "❄️ Layer with thermal underwear and moisture-wicking fabrics",
                "🔥 Prepare hot cocoa bar with marshmallows and cinnamon",
                "⛷️ Try winter sports like skiing or build a snowman",
                "🚗 Winterize your car with emergency kit and snow tires",
                "🧦 Wear wool socks and insulated waterproof boots",
                "🍲 Make hearty meals like chili or fondue for warmth",
                "📸 Capture beautiful winter landscape photography",
                "🛁 Plan a relaxing evening with warm baths and cozy blankets"
            ]
            
        case "thunderIcon":
            return [
                "⚡ Unplug electronic devices to protect from power surges",
                "🏠 Create an emergency kit with flashlights and batteries",
                "🎲 Prepare board games or puzzles for indoor entertainment",
                "📚 Catch up on reading or start a new creative project",
                "🍿 Make homemade popcorn and have a cozy movie night",
                "🚫 Avoid using landline phones and plumbing during storms",
                "🕯️ Create a calming atmosphere with candles (safely)",
                "📞 Check on elderly neighbors or family members by phone"
            ]
            
        case "windyIcon":
            return [
                "💨 Style your hair with braids or updos to avoid tangles",
                "🧥 Wear close-fitting jackets and secure loose accessories",
                "🎐 Perfect day for flying kites or watching wind turbines",
                "🚴 Be extra cautious while cycling or driving high-profile vehicles",
                "🍃 Enjoy the sound of rustling leaves with a nature walk",
                "🏠 Secure outdoor furniture and close windows properly",
                "📖 Visit a quiet library or coffee shop away from gusts",
                "🌊 Watch waves at a nearby beach if safe to do so"
            ]
            
        case "foggyIcon":
            return [
                "🌫️ Use fog lights on your car and drive with extra caution",
                "🔦 Carry a flashlight or use phone light when walking",
                "🎭 Perfect atmosphere for mystery novels or thriller movies",
                "☕ Visit a cozy café with warm drinks and good company",
                "📸 Take dramatic, moody photographs in the mist",
                "🚶 Stick to familiar routes and avoid unfamiliar shortcuts",
                "🏠 Perfect day for indoor yoga or meditation sessions",
                "🍵 Enjoy warm, comforting foods like soup or oatmeal"
            ]
            
        default:
            return [
                "😊 Embrace the day with positive energy and smiles",
                "🌤️ Perfect conditions for trying something new",
                "🚶‍♂️ Explore your neighborhood and discover hidden gems",
                "📝 Plan your upcoming week or set new goals",
                "🎵 Listen to music that matches your current mood",
                "🍽️ Try a new recipe or visit a local restaurant",
                "💝 Practice random acts of kindness today",
                "🌿 Connect with nature in your local park or garden"
            ]
        }
    }
}
