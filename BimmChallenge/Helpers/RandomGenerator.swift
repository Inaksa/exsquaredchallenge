//
//  RandomGenerator.swift
//  BimmChallenge
//
//  Created by Alex Maggio on 18/01/2025.
//
import Foundation

class RandomGenerator {
    static private let names: [String] = [
        "NebulaJoker",
        "SonicGiggles",
        "QuantumQuipster",
        "PixelPunchline",
        "ZestyZapper",
        "LaughRiotX",
        "WittyWavelength",
        "CheekyCraze",
        "JovialByte",
        "FunkyFizz",
        "ChuckleCatalyst",
        "EmojiEnigma",
        "HilariousHydra",
        "SnazzySnicker",
        "GroovyGrinster",
        "QuasarQuip",
        "SassySpectacle",
        "CosmicChuckle",
        "WhizKidWitticism",
        "GuffawGalaxy",
        "DandyDose",
        "MemeMingle",
        "GrinGadget",
        "QuipQuest",
        "LaughLagoon",
        "GiddyGizmo",
        "PrismPunch",
        "JesterJet",
        "CleverComet",
        "ZanyZenith",
        "LightheartedLyric",
        "JokeJazz",
        "ChuckleChampion",
        "MirthMatrix",
        "HahaHarbor",
        "PunnyPixel",
        "JocularJive",
        "WittyWhisperer",
        "HumorHarmony",
        "JoltJester",
        "BubblyBanter",
        "QuirkQuotient",
        "LaughLinx",
        "SnickerSculptor",
        "ZingZone",
        "WhoopeeWave",
        "BanterBolt",
        "BlissfulBlurt",
        "SizzleSmirk",
        "HahaHustler",
        "nacho_average_joe",
        "cereal_chiller",
        "toasted_marshmellow",
        "tickle_me_emoji",
        "napping_ninja",
        "lettuce_pray",
        "sir_loin_of_beef",
        "smarty_pants_dance",
        "taco_belle",
        "wingman_wednesday",
        "pasta_la_vista",
        "quack_attack",
        "puns_of_steel",
        "muffin_top_boss",
        "sassy_sardine",
        "kung_fu_grampa",
        "tearex",
        "cookiecrumblin",
        "chillinlikeavillain",
        "sofakingcool",
        "jellowrestler",
        "laughinglatte",
        "picklericky",
        "buzzwordbee",
        "captainobviousreturns",
        "cheesewhizkid",
        "fignewtonjohn",
        "punslinger",
        "baguetteaboutit",
        "wordnerdbird",
    ]

    private static let tags: [String] = [
        "kitten",
        "several",
        "gif",
        "manspreading",
        "closed eyes",
        "sleepy",
        "bed",
        "gif",
        "tuxedo",
        "vending machine",
        "stuck",
        "glass",
        "trapped",
        "norwegian forest cat",
        "daisy",
        "gaming",
        "pc",
        "small cat",
        "brazilian",
        "brazilian cat",
        "brasileira",
        "female cat",
        "female",
        "black & white",
        "donna",
        "londrinense",
        "londrina",
        "cute cat",
        "cute",
    ]

    static func getName() -> String? {
        if Bool.random() {
            return names.randomElement()
        }

        return nil
    }

    static func getTag() -> String {
        tags.randomElement()!
    }
}
