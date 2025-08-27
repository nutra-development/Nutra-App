enum EspecialidadeProfissional {
  nutricionista,
  psicologo,
  fonoaudiologo,
  terapeutaOcupacional,
  terapeutaAlimentar,
  psicopedagogo,
  neuropsicologo,
  pedagogo,
  psiquiatraInfantil,
  medicoPediatra,
  outro,
}

extension EspecialidadeProfissionalExtension on EspecialidadeProfissional {
  String get label {
    switch (this) {
      case EspecialidadeProfissional.nutricionista:
        return 'Nutricionista';
      case EspecialidadeProfissional.psicologo:
        return 'Psicólogo';
      case EspecialidadeProfissional.fonoaudiologo:
        return 'Fonoaudiólogo';
      case EspecialidadeProfissional.terapeutaOcupacional:
        return 'Terapeuta Ocupacional';
      case EspecialidadeProfissional.terapeutaAlimentar:
        return 'Terapeuta Alimentar';
      case EspecialidadeProfissional.psicopedagogo:
        return 'Psicopedagogo';
      case EspecialidadeProfissional.neuropsicologo:
        return 'Neuropsicólogo';
      case EspecialidadeProfissional.pedagogo:
        return 'Pedagogo';
      case EspecialidadeProfissional.psiquiatraInfantil:
        return 'Psiquiatra Infantil';
      case EspecialidadeProfissional.medicoPediatra:
        return 'Médico Pediatra';
      case EspecialidadeProfissional.outro:
        return 'Outro';
    }
  }
}
