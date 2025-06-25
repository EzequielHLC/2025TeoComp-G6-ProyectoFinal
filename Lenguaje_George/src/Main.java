import java.io.FileReader;
import java_cup.runtime.Symbol;

public class Main {
    @SuppressWarnings("deprecation")
    public static void main(String[] args) {
        try {
            AnalizadorLexico lex = new AnalizadorLexico(new FileReader("entrada.txt"));

            // Mostrar tokens (Control del análisis léxico)
            System.out.println("=================== ANALIZADOR LÉXICO: TOKENS IDENTIFICADOS ===================");
            Symbol s;
            while ((s = lex.next_token()).sym != sym.EOF) {
                String nombre = sym.terminalNames[s.sym];
                String lexema = lex.yytext();
                System.out.printf("%-15s | lexema: '%s'%n",
                                  nombre,
                                  (lexema.isEmpty() ? nombre : lexema));
            }

            // Reiniciar lexer
            lex.yyreset(new FileReader("entrada.txt"));

            // Crear parser
            parser p = new parser(lex);

            System.out.println("\n=================== ANALIZADOR SINTÁCTICO: PROCESAMIENTO DE LA ESTRUCTURA GRAMATICAL ===================");
            p.debug_parse();  // imprime cada paso de shift/reduce, estados, etc.

            System.out.println("\n ¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡ÉXITO: Su entrada es válida para el lenguaje George !!!!!!!!!!!!!!!!!!!!!!");
        } catch (RuntimeException e) {
            // Errores léxicos
            System.err.println(e.getMessage());
        } catch (Exception e) {
            // Errores sintácticos ya impresos por report_fatal_error
        }
    }
}
