//
//  VehicleDetailInfo.swift
//  Cepik
//
//  Created by Maksymilian Stan on 17/11/2022.
//

import Foundation

struct VehicleDetailInfo: Codable {
    
    var data: VehiclesDetailData
}

struct VehiclesDetailData: Codable {
    
    var id: String?
    var type: String?
    var attributes: VehiclesDetailDataAttributes?
}

struct VehiclesDetailDataAttributes: Codable {
    var rejestracjaGmina: String?
    var rejestracjaPowiat: String?
    var rejestracjaWojewodztwo: String?
    var dataOstatniejRejestracjiWKraju: String?
    var dataPierwszejRejestracji: String?
    var dataPierwszejRejestracjiwkraju: String?
    var dataPierwszejRejestracjiZaGranica: String?
    var dataWprowadzeniaDanych: String?
    var dataWyrejestrowaniaPojazdu: String?
    var dopuszczalnaLadownosc: Int?
    var dopuszczalnaMasaCalkowita: Int?
    var dopuszczalnaMasaCalkowitaZespoluPojazdow: Int?
    var poziomEmisjiCo2: Double?
    var poziomEmisjiCo2PierwszePaliwoAlternatwne: Double?
    var poziomEmisjiCo2DrugiePaliwoAlternatwne: Double?
    var kategoriaPojazdu: String?
    var kodInstytutuTransportuSamochodowego: String?
    var kodRodzajPodrodzajPrzeznaczenie: String?
    var liczbaMiejscOgolem: Int?
    var liczbaMiejscSiedzacych: Int?
    var liczbaMiejscStojacych: Int?
    var liczbaOsi: Int?
    var maksymalnaLadownosc: Int?
    var maksymalnaMasaCalkowita: Int?
    var maxMasaCalkowitaCiagnietejPrzyczepyBezHamulca: Int?
    var maxMasaCalkowitaPrzyczepyBezHamulca: Int?
    var maxMocNettoSilnikowPojazduHybrydowego: Double?
    var maxRozstawKol: Int?
    var mocNettoSilnika: Double?
    var marka: String?
    var masaPojazduGotowegoDoJazdy: Int?
    var masaWlasna: Int?
    var minRozstawKol: Int?
    var model: String?
    var dopuszczalnyNaciskOsi: Double?
    var maksymalnyNaciskOsi: Double?
    var nazwaProducenta: String?
    var pochodzeniePojazdu: String?
    var podrodzajPojazdu: String?
    var pojemnoscSkokowaSilnika: Double?
    var przeznaczeniePojazdu: String?
    var przyczynaWyrejestrowaniaPojazdu: String?
    var redukcjaEmisjiSpalin: Double?
    var rodzajDrugiegoPaliwaAlternatywnego: String?
    var rodzajKodowaniaRodzajPodrodzajPrzeznaczenie: String?
    var rodzajPaliwa: String?
    var rodzajPierwszegoPaliwaAlternatywnego: String?
    var rodzajPojazdu: String?
    var rodzajTabliczkiZnamionowej: String?
    var rodzajZwieszenia: String?
    var rokProdukcji: String?
    var rozstawKolOsiKierowanejPozostalychOsi: String?
    var wlascicielGmina: String?
    var wlascicielPowiat: String?
    var wlascicielWojewodztwo: String?
    var sposobProdukcji: String?
    var avgRozstawKol: Int?
    var avgZuzyciePaliwa: Double?
    var stosunekMocySilnikaDoMasyWlasnejMotocykle: Double?
    var typ: String?
    var wariant: String?
    var wersja: String?
    var wyposazenieIRodzajUrzadzeniaRadarowego: String?
    var kierownicaPoPrawejStronie: Bool?
    var kierownicaPoPrawejStroniePierwotnie: Bool?
    var hak: Bool?
    var katalizatorPochlaniacz: Bool?
    var wojewodztwoKod: String?
    var wlascicielWojewodztwoKod: String?
    
    private enum CodingKeys: String, CodingKey {
        case rejestracjaGmina = "rejestracja-gmina"
        case rejestracjaPowiat = "rejestracja-powiat"
        case rejestracjaWojewodztwo = "rejestracja-wojewodztwo"
        case dataOstatniejRejestracjiWKraju = "data-ostatniej-rejestracji-w-kraju    "
        case dataPierwszejRejestracji = "data-pierwszej-rejestracji"
        case dataPierwszejRejestracjiwkraju = "data-pierwszej-rejestracjiwkraju"
        case dataPierwszejRejestracjiZaGranica = "data-pierwszej-rejestracji-za-granica"
        case dataWprowadzeniaDanych = "data-wprowadzenia-danych"
        case dataWyrejestrowaniaPojazdu = "data-wyrejestrowania-pojazdu"
        case dopuszczalnaLadownosc = "dopuszczalna-ladownosc"
        case dopuszczalnaMasaCalkowita = "dopuszczalna-masa-calkowita"
        case dopuszczalnaMasaCalkowitaZespoluPojazdow = "dopuszczalna-masa-calkowita-zespolu-pojazdow"
        case poziomEmisjiCo2 = "poziom-emisji-co2"
        case poziomEmisjiCo2PierwszePaliwoAlternatwne = "poziom-emisji-co2-pierwsze-paliwo-alternatwne"
        case poziomEmisjiCo2DrugiePaliwoAlternatwne = "poziom-emisji-co2-drugie-paliwo-alternatwne"
        case kategoriaPojazdu = "kategoria-pojazdu"
        case kodInstytutuTransportuSamochodowego = "kod-instytutu-transportu-samochodowego"
        case kodRodzajPodrodzajPrzeznaczenie = "kod-rodzaj-podrodzaj-przeznaczenie"
        case liczbaMiejscOgolem = "liczba-miejsc-ogolem    "
        case liczbaMiejscSiedzacych = "liczba-miejsc-siedzacych"
        case liczbaMiejscStojacych = "liczba-miejsc-stojacych"
        case liczbaOsi = "liczba-osi"
        case maksymalnaLadownosc = "maksymalna-ladownosc"
        case maksymalnaMasaCalkowita = "maksymalna-masa-calkowita"
        case maxMasaCalkowitaCiagnietejPrzyczepyBezHamulca = "max-masa-calkowita-ciagnietej-przyczepy-bez-hamulca"
        case maxMasaCalkowitaPrzyczepyBezHamulca = "max-masa-calkowita-przyczepy-bez-hamulca"
        case maxMocNettoSilnikowPojazduHybrydowego = "max-moc-netto-silnikow-pojazdu-hybrydowego    "
        case maxRozstawKol = "max-rozstaw-kol"
        case mocNettoSilnika = "moc-netto-silnika"
        case marka = "marka"
        case masaPojazduGotowegoDoJazdy = "masa-pojazdu-gotowego-do-jazdy"
        case masaWlasna = "masa-wlasna"
        case minRozstawKol = "min-rozstaw-kol    "
        case model = "model"
        case dopuszczalnyNaciskOsi = "dopuszczalny-nacisk-osi"
        case maksymalnyNaciskOsi = "maksymalny-nacisk-osi"
        case nazwaProducenta = "nazwa-producenta"
        case pochodzeniePojazdu = "pochodzenie-pojazdu"
        case podrodzajPojazdu = "podrodzaj-pojazdu"
        case pojemnoscSkokowaSilnika = "pojemnosc-skokowa-silnika"
        case przeznaczeniePojazdu = "przeznaczenie-pojazdu"
        case przyczynaWyrejestrowaniaPojazdu = "przyczyna-wyrejestrowania-pojazdu"
        case redukcjaEmisjiSpalin = "redukcja-emisji-spalin"
        case rodzajDrugiegoPaliwaAlternatywnego = "rodzaj-drugiego-paliwa-alternatywnego"
        case rodzajKodowaniaRodzajPodrodzajPrzeznaczenie = "rodzaj-kodowania-rodzaj-podrodzaj-przeznaczenie"
        case rodzajPaliwa = "rodzaj-paliwa"
        case rodzajPierwszegoPaliwaAlternatywnego = "rodzaj-pierwszego-paliwa-alternatywnego"
        case rodzajPojazdu = "rodzaj-pojazdu"
        case rodzajTabliczkiZnamionowej = "rodzaj-tabliczki-znamionowej"
        case rodzajZwieszenia = "rodzaj-zwieszenia"
        case rokProdukcji = "rok-produkcji"
        case rozstawKolOsiKierowanejPozostalychOsi = "rozstaw-kol-osi-kierowanej-pozostalych-osi"
        case wlascicielGmina = "wlasciciel-gmina"
        case wlascicielPowiat = "wlasciciel-powiat"
        case wlascicielWojewodztwo = "wlasciciel-wojewodztwo"
        case sposobProdukcji = "sposob-produkcji"
        case avgRozstawKol = "avg-rozstaw-kol    "
        case avgZuzyciePaliwa = "avg-zuzycie-paliwa    "
        case stosunekMocySilnikaDoMasyWlasnejMotocykle = "stosunek-mocy-silnika-do-masy-wlasnej-motocykle"
        case typ = "typ"
        case wariant = "wariant"
        case wersja = "wersja"
        case wyposazenieIRodzajUrzadzeniaRadarowego = "wyposazenie-i-rodzaj-urzadzenia-radarowego"
        case kierownicaPoPrawejStronie = "kierownica-po-prawej-stronie"
        case kierownicaPoPrawejStroniePierwotnie = "kierownica-po-prawej-stronie-pierwotnie"
        case hak = "hak"
        case katalizatorPochlaniacz = "katalizator-pochlaniacz"
        case wojewodztwoKod = "wojewodztwo-kod"
        case wlascicielWojewodztwoKod = "wlasciciel-wojewodztwo-kod"

    }
}
