//
//  ModerationResult.swift
//  Aperture
//
//  Created by Lilliana on 09/03/2023.
//

struct ModerationResult: Decodable {
    struct NestedModerationResult: Decodable {
        enum CodingKeys: String, CodingKey {
            case flagged
            case categories
            case scores = "category_scores"
        }

        let flagged: Bool
        let categories: ModerationCategories
        let scores: ModerationScores
    }

    struct ModerationCategories: Decodable {
        enum CodingKeys: String, CodingKey {
            case sexual
            case hate
            case violence
            case selfHarm = "self-harm"
            case sexualMinors = "sexual/minors"
            case hateThreatening = "hate/threatening"
            case violenceGraphic = "violence/graphic"
        }

        let sexual: Bool
        let hate: Bool
        let violence: Bool
        let selfHarm: Bool
        let sexualMinors: Bool
        let hateThreatening: Bool
        let violenceGraphic: Bool
    }

    struct ModerationScores: Decodable {
        enum CodingKeys: String, CodingKey {
            case sexual
            case hate
            case violence
            case selfHarm = "self-harm"
            case sexualMinors = "sexual/minors"
            case hateThreatening = "hate/threatening"
            case violenceGraphic = "violence/graphic"
        }

        let sexual: Double
        let hate: Double
        let violence: Double
        let selfHarm: Double
        let sexualMinors: Double
        let hateThreatening: Double
        let violenceGraphic: Double
    }

    let id: String
    let model: String
    let results: [NestedModerationResult]
}
