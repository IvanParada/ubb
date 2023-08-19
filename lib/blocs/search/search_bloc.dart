import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';

import 'package:ubb/models/models.dart';
import 'package:ubb/services/services.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  TrafficService trafficService;

  SearchBloc({
    required this.trafficService,
  }) : super(const SearchState()) {
    on<OnActivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: true)));
    on<OnDeactivateManualMarkerEvent>(
        (event, emit) => emit(state.copyWith(displayManualMarker: false)));
    on<OnNewPlacesFoundEvent>(
        (event, emit) => emit(state.copyWith(places: event.places)));
    on<AddToHistoryEvent>((event, emit) =>
        emit(state.copyWith(history: [event.place, ...state.history])));
  }

  Future<RouteDestination> getCoorsStartToEnd(LatLng start, LatLng end) async {
    final trafficResponse = await trafficService.getCoorsStartToEnd(start, end);

    //Informacion del destino
    final endPlace = await trafficService.getInformationByCoors(end);

    final geometry = trafficResponse.routes[0].geometry;
    final distance = trafficResponse.routes[0].distance;
    final duration = trafficResponse.routes[0].duration;

    final points = decodePolyline(geometry, accuracyExponent: 6);
    final latLngList = points
        .map((coor) => LatLng(
              coor[0].toDouble(),
              coor[1].toDouble(),
            ))
        .toList();

    return RouteDestination(
      points: latLngList,
      duration: duration,
      distance: distance,
      endPlace: endPlace,
    );
  }


  Future getPlacesByQuery(LatLng proximity, String query) async {
    final newPlaces = <Feature>[];

//Cración de lugares
    Feature plazaExteriorUBB = createCustomPlace(
      'plaza-exterior',
      'Plaza Exterior',
      'Plaza Exterior, Universidad del BioBio',
      [-73.0153504402849, -36.820460728849575],
    );
    Feature plazaAulaMagnaUBB = createCustomPlace(
      'plaza-aula-magna',
      'Plaza Aula Magna',
      'Plaza Aula Magna, Universidad del BioBio',
      [-73.013245, -36.822510],
    );
    Feature planetarioUBB = createCustomPlace(
      'planetario',
      'Planetario',
      'Planetario, Universidad del BioBio',
      [-73.01561379475291, -36.820955875894356],
    );
    Feature lagunaUBB = createCustomPlace(
      'laguna',
      'Laguna',
      'Laguna , Universidad del BioBio',
      [-73.01589095927775, -36.82137210312746],
    );
    Feature jardinesUBB = createCustomPlace(
      'jardines',
      'Jardines',
      'Jardines, Universidad del BioBio',
      [-73.01525135312855, -36.82113895896988],
    );
    Feature oficinaInformacionesUBB = createCustomPlace(
      'oficina-informaciones',
      'Oficina de Informaciones ',
      'Oficina de Informaciones, Universidad del BioBio',
      [-73.0149587064697, -36.82058427412565],
    );
    Feature estacionamientosGimnasioUBB = createCustomPlace(
      'estacionamientos-gimnasio',
      'Estacionamientos Gimnasio',
      'Estacionamientos Gimnasio, Universidad del BioBio',
      [-73.0154501742581, -36.821620351834426],
    );
    Feature gimnasioUBB = createCustomPlace(
      'gimnasio',
      'Gimnasio',
      'Gimnasio, Universidad del BioBio',
      [-73.01555195945721, -36.82189548101085],
    );
    Feature raubbBoulder = createCustomPlace(
      'rama-andinismo',
      'Rama Andinismo',
      'Rama Andinismo, Universidad del BioBio',
      [-73.015504963593, -36.822090598125804],
    );
    Feature canchaRugbyUBB = createCustomPlace(
      'cancha-rugby',
      'Cancha Rugby',
      'Cancha Rugby, Universidad del BioBio',
      [-73.01553658118888, -36.82265923510146],
    );
    Feature jamaicaUBB = createCustomPlace(
      'jamaica',
      'Jamaica',
      'Jamaica, Universidad del BioBio',
      [-73.01501025046915, -36.82303554853736],
    );
    Feature canchaUBB = createCustomPlace(
      'cancha-pasto-sintetico',
      'Cancha',
      'Cancha, Universidad del BioBio',
      [-73.01501025046915, -36.82303554853736],
    );
    Feature estacionamientoCanchaUBB = createCustomPlace(
      'estacionamiento-cancha',
      'Estacionamiento Cancha',
      'Estacionamiento Cancha, Universidad del BioBio',
      [-73.01501025046915, -36.82303554853736],
    );
    Feature parkourparkUBB = createCustomPlace(
      'parkpur-park',
      'Parkour Park',
      'Parkour Park, Universidad del BioBio',
      [-73.01431540946841, -36.82275077499071],
    );
    Feature parqueCalisteniaUBB = createCustomPlace(
      'parque-calistenia',
      'Parque de Calistenia',
      'Jamaica, Universidad del BioBio',
      [-73.01396529015231, -36.82266903005002],
    );
    Feature canchasTenisUBB = createCustomPlace(
      'canchas-tenis',
      'Canchas de Tenis',
      'Canchas de Tenis, Universidad del BioBio',
      [-73.01412576224908, -36.822342049964945],
    );
    Feature centroInnovacionUBB = createCustomPlace(
      'centro-innovacion',
      'Centro de Innovación',
      'Centro de Innovación, Universidad del BioBio',
      [-73.01480655054475, -36.82225641282157],
    );
    Feature estacionamientoGantesUBB = createCustomPlace(
      'estacionamiento-gantes',
      'Estacionamiento Gantes',
      'Estacionamiento Gantes, Universidad del BioBio',
      [-73.0141233318405, -36.821997552261436],
    );
    Feature rectoriaUBB = createCustomPlace(
      'rectoria',
      'Rectoría, Vicerrectoría Académica,Dirreción de Docencia, Dirección de Admisión y Registro Académico',
      'Rectoría, Vicerrectoría Académica,Dirreción de Docencia, Dirección de Admisión y Registro Académico, Universidad del BioBio',
      [-73.01430289893341, -36.82113092522013],
    );
    Feature auditorioHermannGammUBB = createCustomPlace(
      'auditorio-hermann',
      'Auditorio Hermann Gamm',
      'Auditorio Hermann Gamm, Universidad del BioBio',
      [-73.01423980983913, -36.821661012520686],
    );
    Feature facultadCienciasUBB = createCustomPlace(
      'facultad-ciencias',
      'Facultad de Ciencias',
      'Facultad de Ciencias, Universidad del BioBio',
      [-73.0135650076763, -36.82101421862468],
    );
    Feature departamentoEstadisticasUBB = createCustomPlace(
      'departamento-estadisticas',
      'Departamento de Estadisticas',
      'Departamento de Estadisticas, Universidad del BioBio',
      [-73.01367202459946, -36.82150803896075],
    );
    Feature bancoCorpbanca = createCustomPlace(
      'banco-corpbanca',
      'Banco Corpanca, Cajero',
      'Banco Corpbanca, Universidad del BioBio',
      [-73.01405798258688, -36.82152395296069],
    );
    Feature facultadIngenieriaUBB = createCustomPlace(
      'facultad-ingenieria',
      'Facultad de Ingenieria',
      'Facultad de Ingenieria, Universidad del BioBio',
      [-73.01378383204116, -36.821780734192856],
    );
    Feature edificioGantesUBB = createCustomPlace(
      'edificio-gantes',
      'Edificio Gantes',
      'Edificio Gantes, Universidad del BioBio',
      [-73.01378383204116, -36.821780734192856],
    );
    Feature escuelaIngenieriaConstruccionUBB = createCustomPlace(
      'escuela-ingenieria-construccion',
      'Escuela de Ingenieria en Construccion ',
      'Escuela de Ingenieria en Construccion , Universidad del BioBio',
      [-73.01280870175296, -36.821222220553345],
    );
    Feature paraninfoUBB = createCustomPlace(
      'paraninfo',
      'Paraninfo',
      'Paraninfo, Universidad del BioBio',
      [-73.01286893576328, -36.82142124719916],
    );
    Feature plazaDemocraciaUBB = createCustomPlace(
      'plaza-democracia',
      'Plaza de la Democracia',
      'Plaza de la Democracia, Universidad del BioBio',
      [-73.01286893576328, -36.82142124719916],
    );
    Feature escuelaTrabajoSocialUBB = createCustomPlace(
      'trabajo-social',
      'Escuela de Trabajo Social',
      'Escuela de Trabajo Social, Universidad del BioBio',
      [-73.01302829054036, -36.82185341915902],
    );
    Feature aulaMagnaUBB = createCustomPlace(
      'aula-magna',
      'Aula Magna',
      'Aula Magna, Universidad del BioBio',
      [-73.01314909590728, -36.82228667499436],
    );
    Feature escuelaArquitecturaUBB = createCustomPlace(
      'escuela-arquitectura',
      'Escuela de Arquitectura',
      'Escuela de Arquitectura, Universidad del BioBio',
      [-73.01324054535345, -36.82129632974265],
    );
    Feature salaExposicionesUBB = createCustomPlace(
        'sala-exposiciones',
        'Sala de Exposiciones',
        'Sala de Exposiciones, Universidad del BioBio',
        [-73.01350862146745, -36.82290295568258]);
    Feature espacio1202UBB = createCustomPlace(
        'espacio-1202',
        'Espacio 1202',
        'Espacio 1202, Universidad del BioBio',
        [-73.01329634037104, -36.82303526629553]);
    Feature ddeUBB = createCustomPlace(
        'dde',
        'Dirección de Desarrollo Estudiantil ',
        'DDE, Dirección de Desarrollo Estudiantil , Universidad del BioBio',
        [-73.01349158503193, -36.8233899889007]);
    Feature estacionamientoDDEUBB = createCustomPlace(
        'estacionamiento-dde',
        'Estacionamiento DDE ',
        'Estacionamiento DDE, Universidad del BioBio',
        [-73.0134356829278, -36.823196754794644]);
    Feature estacionamientoFederacionUBB = createCustomPlace(
        'estacionamiento-federacion',
        'Estacionamiento Federación ',
        'Estacionamiento Federación, Universidad del BioBio',
        [-73.01323796483089, -36.82362799338529]);
    Feature laboratorioCienciasConstruccionUBB = createCustomPlace(
        'laboratorio-ciencias-construccion',
        'Laboratorio Ciencias de la Construcción ',
        'Laboratorio Ciencias de la Construcción, Universidad del BioBio',
        [-73.01290316053763, -36.82383186765058]);
    Feature departamentoCienciasConstruccionUBB = createCustomPlace(
        'departamento-ciencias-construccion',
        'Departamento Ciencias de la Construcción ',
        'Departamento Ciencias de la Construcción, Universidad del BioBio',
        [-73.0126207318842, -36.82377804507284]);
    Feature citecUBB = createCustomPlace(
        'citec',
        'CITEC UBB',
        'CITEC, Universidad del BioBio',
        [-73.0137282338395, -36.8240443379694]);
    Feature estacionamientoCitecUBB = createCustomPlace(
        'estacionamiento-citec',
        'Estacionamiento CITEC ',
        'Estacionamiento CITEC, Universidad del BioBio',
        [-73.01334734409615, -36.8241412908316]);
    Feature laboratorioProcesosSustentablesUBB = createCustomPlace(
        'laboratorio-procesos-sustentables',
        'Laboratorio de Procesos Sustentables UBB',
        'Laboratorio de Procesos Sustentables, Universidad del BioBio',
        [-73.01302185140796, -36.82349924861111]);
    Feature incubadoraEmpresasUBB = createCustomPlace(
        'incubadora-empresas',
        'Incubadora de Empresas UBB',
        'Incubadora de Empresas, Universidad del BioBio',
        [-73.01249045103822, -36.82300580687556]);
    Feature pabellonTecnologicoMaderaUBB = createCustomPlace(
        'pabellon-tecnologico-madera',
        'Pabellón Tecnológico de la Madera UBB',
        'Pabellón Tecnológico de la Madera, Universidad del BioBio',
        [-73.0128373569203, -36.82309381938699]);
    Feature lcgpaUBB = createCustomPlace(
        'lcgpa',
        'LCGPA UBB',
        'LCGPA, Universidad del BioBio',
        [-73.01215867160751, -36.82307159429834]);
    Feature estacionamientoMaderasUBB = createCustomPlace(
        'estacionamiento-maderas',
        'Estacionamiento de Maderas UBB',
        'Estacionamiento de Maderas, Universidad del BioBio',
        [-73.01207915885723, -36.823345557993235]);
    Feature cbnUBB = createCustomPlace(
        'cbn',
        'CBN UBB',
        'CBN, Universidad del BioBio',
        [-73.01240574782511, -36.823447145712166]);
    Feature facultadDisenoIndustrialUBB = createCustomPlace(
        'facultad-diseno-industrial',
        'Facultad de Diseño Industrial UBB',
        'Facultad de Diseño Industrial, Universidad del BioBio',
        [-73.01183388861404, -36.823193214508]);
    Feature edicionesUBB = createCustomPlace(
        'ediciones',
        'Ediciones UBB',
        'Ediciones, Universidad del BioBio',
        [-73.01212623730615, -36.82354071145458]);
    Feature departamentoIngenieriaCivilAmbientalUBB = createCustomPlace(
        'departamento-ingenieria-civil-ambiental',
        'Departamento Ingeniería Civil y Ambiental UBB',
        'Departamento Ingeniería Civil y Ambiental, Universidad del BioBio',
        [-73.01129791345598, -36.82338409137286]);
    Feature laboratoriosTalleresDIMecUBB = createCustomPlace(
        'laboratorios-talleres-dimec',
        'Laboratorios y Talleres DIMec UBB',
        'Laboratorios y Talleres DIMec, Universidad del BioBio',
        [-73.01171863301998, -36.823827265730785]);
    Feature cipaUBB = createCustomPlace(
        'cipa',
        'CIPA, Centro de Investigación de Polímeros Avanzados UBB',
        'CIPA, Centro de Investigación de Polímeros Avanzados, Universidad del BioBio',
        [-73.01201944617053, -36.8240534418508]);
    Feature departamentoIngenieriaMecanicaUBB = createCustomPlace(
        'departamento-ingenieria-mecanica',
        'Departamento de Ingeniería Mecánica UBB',
        'Departamento de Ingeniería Mecánica, Universidad del BioBio',
        [-73.01218111465829, -36.821653226044255]);
    Feature aulasExIMUBB = createCustomPlace(
        'aulas-ex-im',
        'Aulas Ex IM UBB',
        'Aulas Ex IM, Universidad del BioBio',
        [-73.01243045071809, -36.82158807192213]);
    Feature impresionUBB = createCustomPlace('impresion', 'Impresión UBB',
        'Impresión UBB', [-73.01234745564797, -36.822020008565346]);
    Feature salaEstudioUBB = createCustomPlace(
        'sala-estudio',
        'Sala de Estudio UBB',
        'Sala de Estudio UBB',
        [-73.0124630667595, -36.822053718810565]);
    Feature ingenieriaCivilIndustrialUBB = createCustomPlace(
        'ingenieria-civil-industrial',
        'Escuela de Ingeniería Civil Industrial UBB',
        'Escuela de Ingeniería Civil Industrial UBB',
        [-73.01262852459375, -36.82227119027796]);
    Feature ingenieriaMaderasUBB = createCustomPlace(
        'ingenieria-maderas',
        'Departamento Ingeniería en Maderas UBB',
        'Departamento Ingeniería en Maderas UBB',
        [-73.0127862966134, -36.82272274227057]);
    Feature aulasAAUBB = createCustomPlace('aulas-aa', 'Aulas AA UBB',
        'Aulas AA UBB', [-73.01208477165912, -36.82215201874491]);
    Feature aulasABUBB = createCustomPlace('aulas-ab', 'Aulas AB UBB',
        'Aulas AB UBB', [-73.01139244900415, -36.82231677111968]);
    Feature aulasACUBB = createCustomPlace('aulas-ac', 'Aulas AC UBB',
        'Aulas AC UBB', [-73.0110199502019, -36.82208229332249]);
    Feature aulasADUBB = createCustomPlace('aulas-ad', 'Aulas AD UBB',
        'Aulas AD UBB', [-73.01152851276187, -36.82258555097241]);
    Feature edificioSistemaTerritorialUBB = createCustomPlace(
        'edificio-sistema-territorial',
        'Edificio Sistema Territorial UBB',
        'Edificio Sistema Territorial UBB',
        [-73.0117541706447, -36.82284948924725]);
    Feature directorioExtensionUBB = createCustomPlace(
        'directorio-extension',
        'Directorio de Extensión UBB',
        'Directorio de Extensión UBB',
        [-73.0122752646328, -36.82271338639085]);
    Feature departamentoArteUBB = createCustomPlace(
        'departamento-arte',
        'Departamento Arte, Cultura y Comunicación UBB',
        'Departamento Arte, Cultura y Comunicación UBB',
        [-73.01213801537808, -36.822633841419794]);
    Feature cimUBB = createCustomPlace(
        'cim', 'CIM UBB', 'CIM UBB', [-73.01190487283094, -36.822808503831]);
    Feature plazaChemamullUBB = createCustomPlace(
        'plaza-chemamull',
        'Plaza Chemamull UBB',
        'Plaza Chemamull UBB',
        [-73.01119397673214, -36.82268563870563]);
    Feature bibliotecaUBB = createCustomPlace(
        'biblioteca',
        'Biblioteca Universidad del Bio-Bio "Hilario Hernandez Gurruchaga" UBB',
        'Biblioteca Universidad del Bio-Bio "Hilario Hernandez Gurruchaga" UBB',
        [-73.0117503048976, -36.821544003447904]);
    Feature pastosUBB = createCustomPlace('pastos', 'Pastos UBB', 'Pastos UBB',
        [-73.01162208630586, -36.82193475141963]);
    Feature plazaBibliotecaUBB = createCustomPlace(
        'plaza-biblioteca',
        'Plaza Biblioteca UBB',
        'Plaza Biblioteca UBB',
        [-73.0116190136438, -36.82153838589379]);
    Feature auditorioFACEUBB = createCustomPlace(
        'auditorio-face',
        'Auditorio FACE UBB',
        'Auditorio FACE UBB',
        [-73.01118945821361, -36.8218038566358]);
    Feature estacionamientoAulasACUBB = createCustomPlace(
        'estacionamiento-aulas-ac',
        'Estacionamiento Aulas AC UBB',
        'Estacionamiento Aulas AC UBB',
        [-73.01068990543648, -36.822086187969035]);
    Feature faceUBB = createCustomPlace(
        'face',
        'FACE, Facultad de Ciencias Empresariales UBB',
        'FACE, Facultad de Ciencias Empresariales UBB',
        [-73.01109723762696, -36.82174804919615]);
    Feature estacionamientoPersonalFACEUBB = createCustomPlace(
        'estacionamiento-personal-face',
        'Estacionamiento Personal FACE UBB',
        'Estacionamiento Personal FACE UBB',
        [-73.01061578346635, -36.82162724187765]);
    Feature casinoUBB = createCustomPlace('casino', 'Casino UBB', 'Casino UBB',
        [-73.01072661815245, -36.82308075843948]);
    Feature estacionamientoCasinoUBB = createCustomPlace(
        'estacionamiento-casino',
        'Estacionamiento Casino UBB',
        'Estacionamiento Casino UBB',
        [-73.0109888697642, -36.82380398374272]);
    Feature estacionamientoFiscalUBB = createCustomPlace(
        'estacionamiento-fiscal',
        'Estacionamiento Fiscal UBB',
        'Estacionamiento Fiscal UBB',
        [-73.01452572760134, -36.82050117901974]);
    Feature sigloXXIUBB = createCustomPlace('siglo-xxi', 'Siglo XXI UBB',
        'Siglo XXI UBB', [-73.01416234272469, -36.82077375584268]);
    Feature arquitecturaUBB = createCustomPlace(
        'arquitectura',
        'Facultad de Arquitectura, Construcción y Diseño UBB',
        'Facultad de Arquitectura, Construcción y Diseño UBB',
        [-73.0131542051368, -36.820791098911194]);
    Feature estacionamientoMecanicaUBB = createCustomPlace(
        'estacionamiento-mecanica',
        'Estacionamiento Mecánica UBB',
        'Estacionamiento Mecánica UBB',
        [-73.01187355187255, -36.821094910539365]);
    Feature estacionamientoFACEUBB = createCustomPlace(
        'estacionamiento-face',
        'Estacionamiento FACE UBB',
        'Estacionamiento FACE UBB',
        [-73.01079137418117, -36.821303686692886]);
    Feature jardinInfantilUBB = createCustomPlace(
        'jardin-infantil',
        'Jardín Infantil Entre Valles UBB',
        'Jardín Infantil Entre Valles UBB',
        [-73.00827959677228, -36.8252594603797]);
//Se añaden los lugares creados

    final filteredPlaces = [
      plazaAulaMagnaUBB,
      plazaChemamullUBB,
      bibliotecaUBB,
      pastosUBB,
      plazaBibliotecaUBB,
      auditorioFACEUBB,
      estacionamientoAulasACUBB,
      faceUBB,
      estacionamientoPersonalFACEUBB,
      casinoUBB,
      estacionamientoCasinoUBB,
      estacionamientoFiscalUBB,
      sigloXXIUBB,
      arquitecturaUBB,
      estacionamientoMecanicaUBB,
      estacionamientoFACEUBB,
      jardinInfantilUBB,
      plazaExteriorUBB,
      planetarioUBB,
      lagunaUBB,
      jardinesUBB,
      oficinaInformacionesUBB,
      estacionamientosGimnasioUBB,
      gimnasioUBB,
      raubbBoulder,
      canchaRugbyUBB,
      jamaicaUBB,
      canchaUBB,
      estacionamientoCanchaUBB,
      parkourparkUBB,
      parqueCalisteniaUBB,
      canchasTenisUBB,
      centroInnovacionUBB,
      estacionamientoGantesUBB,
      rectoriaUBB,
      auditorioHermannGammUBB,
      facultadCienciasUBB,
      departamentoEstadisticasUBB,
      bancoCorpbanca,
      facultadIngenieriaUBB,
      edificioGantesUBB,
      escuelaIngenieriaConstruccionUBB,
      paraninfoUBB,
      plazaDemocraciaUBB,
      escuelaTrabajoSocialUBB,
      aulaMagnaUBB,
      escuelaArquitecturaUBB,
      salaExposicionesUBB,
      espacio1202UBB,
      ddeUBB,
      estacionamientoDDEUBB,
      estacionamientoFederacionUBB,
      laboratorioCienciasConstruccionUBB,
      laboratorioProcesosSustentablesUBB,
      departamentoCienciasConstruccionUBB,
      citecUBB,
      estacionamientoCitecUBB,
      incubadoraEmpresasUBB,
      pabellonTecnologicoMaderaUBB,
      lcgpaUBB,
      estacionamientoMaderasUBB,
      cbnUBB,
      facultadDisenoIndustrialUBB,
      edicionesUBB,
      departamentoIngenieriaCivilAmbientalUBB,
      laboratoriosTalleresDIMecUBB,
      cipaUBB,
      departamentoIngenieriaMecanicaUBB,
      aulasExIMUBB,
      impresionUBB,
      salaEstudioUBB,
      ingenieriaCivilIndustrialUBB,
      ingenieriaMaderasUBB,
      aulasAAUBB,
      aulasABUBB,
      aulasACUBB,
      aulasADUBB,
      edificioSistemaTerritorialUBB,
      directorioExtensionUBB,
      departamentoArteUBB,
      cimUBB,
    ]
  .where((place) =>
            place.text.toLowerCase().contains(query.toLowerCase()) ||
            place.placeName.toLowerCase().contains(query.toLowerCase()))
        .toList(); 

    newPlaces.addAll(filteredPlaces);

    add(OnNewPlacesFoundEvent(filteredPlaces));
  }
  
}
