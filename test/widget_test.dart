import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_arquitetura_01/pages/login_page.dart';

void main() {
  testWidgets('deve exibir a tela de login com credenciais de teste', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('Acesso ao Sistema'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(
      find.text('Usuario de teste: emilys\nSenha: emilyspass'),
      findsOneWidget,
    );
  });
}
