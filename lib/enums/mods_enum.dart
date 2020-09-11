import 'dart:ui';

enum ModsEnum {
  kids,
  plio,
  fit,
  silver,
  physio,
}

const ModsEnumToStringMap = {
  ModsEnum.kids: 'Kids',
  ModsEnum.plio: 'Plio',
  ModsEnum.fit: 'Fit',
  ModsEnum.silver: 'Silver',
  ModsEnum.physio: 'Physio'
};

const ModsEnumToColorMap = {
  ModsEnum.kids: Color.fromRGBO(252, 190, 3, 1),
  ModsEnum.plio: Color.fromRGBO(255, 0, 0, 1),
  ModsEnum.fit: Color.fromRGBO(143, 170, 220, 1),
  ModsEnum.silver: Color.fromRGBO(165, 165, 165, 1),
  ModsEnum.physio: Color.fromRGBO(169, 209, 142, 1),
};
