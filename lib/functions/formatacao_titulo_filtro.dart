// Formatação de textos

String formatarTitulo(String chave) {
  return chave.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  ).replaceFirstMapped(
    RegExp(r'^\w'),
    (match) => match.group(0)!.toUpperCase(),
  );
}
