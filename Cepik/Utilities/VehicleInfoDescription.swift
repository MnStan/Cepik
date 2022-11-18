//
//  VehicleInfoDescription.swift
//  Cepik
//
//  Created by Maksymilian Stan on 18/11/2022.
//

import Foundation

enum VehicleInfoDescription: String{
   case rejestracjaGmina
   case rejestracjaPowiat
   case rejestracjaWojewodztwo
   case dataOstatniejRejestracjiWKraju
   case dataPierwszejRejestracji
   case dataPierwszejRejestracjiwkraju
   case dataPierwszejRejestracjiZaGranica
   case dataWprowadzeniaDanych
   case dataWyrejestrowaniaPojazdu
   case dopuszczalnaLadownosc
   case dopuszczalnaMasaCalkowita
   case dopuszczalnaMasaCalkowitaZespoluPojazdow
   case poziomEmisjiCo2
   case poziomEmisjiCo2PierwszePaliwoAlternatwne
   case poziomEmisjiCo2DrugiePaliwoAlternatwne
   case kategoriaPojazdu
   case kodInstytutuTransportuSamochodowego
   case kodRodzajPodrodzajPrzeznaczenie
   case liczbaMiejscOgolem
   case liczbaMiejscSiedzacych
   case liczbaMiejscStojacych
   case liczbaOsi
   case maksymalnaLadownosc
   case maksymalnaMasaCalkowita
   case maxMasaCalkowitaCiagnietejPrzyczepyBezHamulca
   case maxMasaCalkowitaPrzyczepyBezHamulca
   case maxMocNettoSilnikowPojazduHybrydowego
   case maxRozstawKol
   case mocNettoSilnika
   case marka
   case masaPojazduGotowegoDoJazdy
   case masaWlasna
   case minRozstawKol
   case model
   case dopuszczalnyNaciskOsi
   case maksymalnyNaciskOsi
   case nazwaProducenta
   case pochodzeniePojazdu
   case podrodzajPojazdu
   case pojemnoscSkokowaSilnika
   case przeznaczeniePojazdu
   case przyczynaWyrejestrowaniaPojazdu
   case redukcjaEmisjiSpalin
   case rodzajDrugiegoPaliwaAlternatywnego
   case rodzajKodowaniaRodzajPodrodzajPrzeznaczenie
   case rodzajPaliwa
   case rodzajPierwszegoPaliwaAlternatywnego
   case rodzajPojazdu
   case rodzajTabliczkiZnamionowej
   case rodzajZwieszenia
   case rokProdukcji
   case rozstawKolOsiKierowanejPozostalychOsi
   case wlascicielGmina
   case wlascicielPowiat
   case wlascicielWojewodztwo
   case sposobProdukcji
   case avgRozstawKol
   case avgZuzyciePaliwa
   case stosunekMocySilnikaDoMasyWlasnejMotocykle
   case typ
   case wariant
   case wersja
   case wyposazenieIRodzajUrzadzeniaRadarowego
   case kierownicaPoPrawejStronie
   case kierownicaPoPrawejStroniePierwotnie
   case hak
   case katalizatorPochlaniacz
   case wojewodztwoKod
   case wlascicielWojewodztwoKod
    
    var info: (String) {
        switch self {
        case .rejestracjaGmina:
            return "Rejestracja gmina"
        case .rejestracjaPowiat:
            return "Rejestracja powiat"
        case .rejestracjaWojewodztwo:
            return "Rejestracja województwo"
        case .dataOstatniejRejestracjiWKraju:
            return "Data ostatniej rejestracji w kraju"
        case .dataPierwszejRejestracji:
            return "Data pierwszej rejestracji"
        case .dataPierwszejRejestracjiwkraju:
            return "Data pierwszej rejestracji wkraju"
        case .dataPierwszejRejestracjiZaGranica:
            return "Data pierwszej rejestracji za granica"
        case .dataWprowadzeniaDanych:
            return "Data wprowadzenia danych"
        case .dataWyrejestrowaniaPojazdu:
            return "Data wyrejestrowania pojazdu"
        case .dopuszczalnaLadownosc:
            return "Dopuszczalna ładowność"
        case .dopuszczalnaMasaCalkowita:
            return "Dopuszczalna masa całkowita"
        case .dopuszczalnaMasaCalkowitaZespoluPojazdow:
            return "Dopuszczalna masa całkowita zespołu pojazdów"
        case .poziomEmisjiCo2:
            return "Poziom emisji co2"
        case .poziomEmisjiCo2PierwszePaliwoAlternatwne:
            return "Poziom emisji co2 pierwsze paliwo alternatywne"
        case .poziomEmisjiCo2DrugiePaliwoAlternatwne:
            return "Poziom emisji co2 drugie paliwo alternatywne"
        case .kategoriaPojazdu:
            return "Kategoria pojazdu"
        case .kodInstytutuTransportuSamochodowego:
            return "Kod instytutu transportu samochodowego"
        case .kodRodzajPodrodzajPrzeznaczenie:
            return "Kod rodzaj podrodzaj przeznaczenie"
        case .liczbaMiejscOgolem:
            return "Liczba miejsc ogółem"
        case .liczbaMiejscSiedzacych:
            return "Liczba miejsc siedzących"
        case .liczbaMiejscStojacych:
            return "Liczba miejsc stojących"
        case .liczbaOsi:
            return "Liczba osi"
        case .maksymalnaLadownosc:
            return "Maksymalna ładowność"
        case .maksymalnaMasaCalkowita:
            return "Maksymalna masa całkowita"
        case .maxMasaCalkowitaCiagnietejPrzyczepyBezHamulca:
            return "Max masa całkowita ciągniętej przyczepy bez hamulca"
        case .maxMasaCalkowitaPrzyczepyBezHamulca:
            return "Max masa całkowita przyczepy bez hamulca"
        case .maxMocNettoSilnikowPojazduHybrydowego:
            return "Max moc netto silników pojazdu hybrydowego"
        case .maxRozstawKol:
            return "Max rozstaw kol"
        case .mocNettoSilnika:
            return "Moc netto silnika"
        case .marka:
            return "Marka"
        case .masaPojazduGotowegoDoJazdy:
            return "Masa pojazdu gotowego do jazdy"
        case .masaWlasna:
            return "Masa wlasna"
        case .minRozstawKol:
            return "Min rozstaw kol"
        case .model:
            return "Model"
        case .dopuszczalnyNaciskOsi:
            return "Dopuszczalny nacisk osi"
        case .maksymalnyNaciskOsi:
            return "Maksymalny nacisk osi"
        case .nazwaProducenta:
            return "Nazwa producenta"
        case .pochodzeniePojazdu:
            return "Pochodzenie pojazdu"
        case .podrodzajPojazdu:
            return "Podrodzaj pojazdu"
        case .pojemnoscSkokowaSilnika:
            return "Pojemność skokowa silnika"
        case .przeznaczeniePojazdu:
            return "Przeznaczenie pojazdu"
        case .przyczynaWyrejestrowaniaPojazdu:
            return "Przyczyna wyrejestrowania pojazdu"
        case .redukcjaEmisjiSpalin:
            return "Redukcja emisji spalin"
        case .rodzajDrugiegoPaliwaAlternatywnego:
            return "Rodzaj drugiego paliwa alternatywnego"
        case .rodzajKodowaniaRodzajPodrodzajPrzeznaczenie:
            return "Rodzaj kodowania rodzaj podrodzaj przeznaczenie"
        case .rodzajPaliwa:
            return "Rodzaj paliwa"
        case .rodzajPierwszegoPaliwaAlternatywnego:
            return "Rodzaj pierwszego paliwa alternatywnego"
        case .rodzajPojazdu:
            return "Rodzaj pojazdu"
        case .rodzajTabliczkiZnamionowej:
            return "Rodzaj tabliczki znamionowej"
        case .rodzajZwieszenia:
            return "Rodzaj zwieszenia"
        case .rokProdukcji:
            return "Rok produkcji"
        case .rozstawKolOsiKierowanejPozostalychOsi:
            return "Rozstaw kol osi kierowanej pozostałych osi"
        case .wlascicielGmina:
            return "Właściciel gmina"
        case .wlascicielPowiat:
            return "Właściciel powiat"
        case .wlascicielWojewodztwo:
            return "Właściciel województwo"
        case .sposobProdukcji:
            return "Sposób produkcji"
        case .avgRozstawKol:
            return "Średni rozstaw kol"
        case .avgZuzyciePaliwa:
            return "Średnie zużycie paliwa"
        case .stosunekMocySilnikaDoMasyWlasnejMotocykle:
            return "Stosunek mocy silnika do masy własnej motocykle"
        case .typ:
            return "Typ"
        case .wariant:
            return "Wariant"
        case .wersja:
            return "Wersja"
        case .wyposazenieIRodzajUrzadzeniaRadarowego:
            return "Wyposażenie I rodzaj urządzenia radarowego"
        case .kierownicaPoPrawejStronie:
            return "Kierownica po prawej stronie"
        case .kierownicaPoPrawejStroniePierwotnie:
            return "Kierownica po prawej stronie pierwotnie"
        case .hak:
            return "Hak"
        case .katalizatorPochlaniacz:
            return "Katalizator pochłaniacz"
        case .wojewodztwoKod:
            return "Województwo kod"
        case .wlascicielWojewodztwoKod:
            return "Właściciel województwo kod"
        }
    }
}
