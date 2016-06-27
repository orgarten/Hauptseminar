---------
Hinweise:
---------

- Das Erscheinungsbild des Posters kann mit den Optionen 
   - tnt, hf, tk, mns (für die einzelnen Lehrstühle des Instituts),
   - diplom, master   (für Diplom- oder Masterarbeit),
   - extern           (im Falle einer extern angefertigten Arbeit - erlaubt zusätzlichen externen Betreuer + Firma)
  angepasst werden.

- Die Parameter für den Posterkopf werden mit den Befehlen
   - \setDAParameter
   - \setStudentPassbild
   - \setStudentWerdegang
  übergeben.

  Zur Benutzung der Befehle (Beispiele siehe beiliegende LaTeX-Datei):

  - \setDAParameter[Param1]{Param2}{Param3}
    -> Param2 ist eines der Schlüsselwörter
        'Thema',
        'Student',
        'BetreuerTUD',
        'BetreuerExternName',  (nur mit Option 'extern')
        'BetreuerExternFirma', (nur mit Option 'extern')
        'Hochschullehrer',
        'VerteidigungDatum'. 
    -> Param3 ist der jeweils an den Posterkopf zu übergebende Inhalt.
    -> Param1 ist optional und erlaubt die Änderung der Größe des Postertitels (nur mit Param2 = 'Thema') durch
        '\LARGE',
        '\Large',
        '\large'.

  - \setStudentPassbild[Param1]{Param2}
    -> Param2 ist der Pfad des Passbildes.
    -> Param1 ist optional und erlaubt die Änderung der Breite des Passbildes.

  - \setStudentWerdegang[Param1][Param2]{Param3}
    -> Param3 ist der an den Posterkopf zu übergebende Inhalt, d.h. der Werdegang des Autors - in getrennten Absätzen und mit Zeilenumbruch nach dem Datum.
    -> Param1 ist optional und erlaubt die Änderung der Schriftgröße für diesen Bereich durch
        '\normalsize',
        '\small',
        '\footnotesize',
        '\scriptsize'.
    -> Param2 ist optional und erlaubt die Änderung des Abstandes der Absätze für diesen Bereich.

- Überschriften bitte nicht nummerieren (\section* statt \section) und möglichst nur zwei Ebenen (\section* und \subsection*) verwenden.

- Das fertige Poster (vorm Druck) bitte als PDF an den Betreuer senden, damit der noch einen prüfenden Blick drauf werfen kann.


---------------------------------------------
Nutzungshinweise für die vorliegende Version:
---------------------------------------------

- Die derzeitige Version der Vorlage verwendet die Schriftart Computer Modern Sans Serif.
  Die TU-Schriftart wird noch nicht unterstützt.

- Bitte überprüfen, ob alle Textelemente korrekt in serifenloser Schrift auftauchen.
  Da kann es bei "exotischeren" Umgebungen und Paketen noch Probleme geben.

- Probleme mit der Vorlage - am besten mit Lösung! ;-) - an: Anne Wolf <anne.wolf@tu-dresden.de>


---------------------------------------------
bekannte (noch ungelöste) Probleme:
---------------------------------------------

- Bei Verwendung des Mathe-Fonts von Computer Modern werden eigentlich skalierbare Mathesymbole (Summenzeichen u.ä.) in Relation zum Rest der Gleichung zu klein dargestellt.
-> Werden Schriften mit einem anderen Mathe-Font verwendet, scheint das Problem nicht aufzutreten:
   z.B. Libertine: \usepackage{libertine} oder   
        txfonts:   \usepackage{txfonts}