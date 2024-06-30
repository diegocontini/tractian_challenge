enum EnumUnit { apex, jaguar, tobias }

extension EnumUnitName on EnumUnit {
  String get getDisplayableText {
    switch (this) {
      case EnumUnit.apex:
        return 'Apex Unit';
      case EnumUnit.jaguar:
        return 'Jaguar Unit';
      case EnumUnit.tobias:
        return 'Tobias Unit';
    }
  }
}
