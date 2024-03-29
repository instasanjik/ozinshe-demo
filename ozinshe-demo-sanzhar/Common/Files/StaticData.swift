//
//  ConstantData.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import Foundation
import UIKit

struct CardContent {
    let name: String
    let image: UIImage
    
    init(name: String, imageName: String) {
        self.name = name
        self.image = UIImage(named: imageName) ?? UIImage()
    }
}

enum CellType {
    case labelAndChevron
    case chevronOnly
    case switchOnly
}

struct StaticData {
    static let genres: [CardContent] = [
        CardContent(name: NSLocalizedString("Genres-Comedy", comment: ""), imageName: "comedia"),
        CardContent(name: NSLocalizedString("Genres-Family", comment: ""), imageName: "family"),
        CardContent(name: NSLocalizedString("Genres-Science", comment: ""), imageName: "science"),
        CardContent(name: NSLocalizedString("Genres-Entertainment", comment: ""), imageName: "entertainment"),
        CardContent(name: NSLocalizedString("Genres-Fantasy", comment: ""), imageName: "fantasy"),
        CardContent(name: NSLocalizedString("Genres-Adventure", comment: ""), imageName: "adventure"),
        CardContent(name: NSLocalizedString("Genres-Short", comment: ""), imageName: "short"),
        CardContent(name: NSLocalizedString("Genres-Musically", comment: ""), imageName: "musically"),
        CardContent(name: NSLocalizedString("Genres-Sport", comment: ""), imageName: "sport")
    ]
    
    static let ageCategories: [CardContent] = [
        CardContent(name: "8-10 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "8-10"),
        CardContent(name: "10-12 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "10-12"),
        CardContent(name: "12-14 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "12-14"),
        CardContent(name: "14-16 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "14-16"),
        CardContent(name: "16-18 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "16-18")
    ]
    
    static let contentCategories: [String] = [
        "Телехикая",
        "Ситком",
        "Көркем фильм",
        "Мультфильм",
        "Мультсериал",
        "Аниме",
        "Тв-бағдарлама және реалити-шоу",
        "Деректі фильм",
        "Музыка",
        "Шетел фильмдері"
    ]
    
    static let profileSettings: [(String, CellType)] = [
        ("Жеке деректер", .labelAndChevron),
        ("Құпия сөзді өзгерту", .chevronOnly),
        ("Тіл", .labelAndChevron),
        ("Ережелер мен шарттар", .chevronOnly),
        ("Хабарландырулар", .switchOnly),
        ("Қараңғы режим", .switchOnly)
    ]
    
    static let termOfUse: String = """
        What is Lorem Ipsum?
        Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

        Why do we use it?
        It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).


        Where does it come from?
        Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

        The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.

        Where can I get some?
        There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.
    """
}
