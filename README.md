# Intelligens rendszerfelügyelet PowerShell házi

Ezt a PowerShell házit a Intelligens rendszerfelügyelet tantárgyhoz készítettem a BME-s tanulmányaim során a 2013/2014/2 félévben.

## Feladat

Címtárunkban egy képzeletbeli egyetem és partnercégeinek dolgozóit, illetve a közös projekteket tároljuk. A címtár szerkezete kötött és a következő felépítésű. Az egyetem dolgozói a „University” egységben találhatók, a „Personnel” egységben az adminisztratív munkatársak, a „Faculties” egységben az oktatók. A „Faculties” egység alatt a hierarchiaszintek a karokat, a tanszékeket és a kutatócsoportokat jelentik. A partnercégek dolgozói a „Partners” egység alatti szinteken találhatók cégenkénti bontásban. A közös projekteket a „Projects” egységben szereplő csoportok jelölik. Minden ilyen csoportban szerepel pontosan egyadminisztratív munkatárs az egyetemről, aki a szerződésekért felel. A csoport további tagjai tetszőleges számban kerülnek ki az egyetem oktatói és a cégek dolgozói közül. Bár a címtárunk alapvető szerkezete kötött, arra fel kell készülnünk, hogy az egyes részek később szabadon bővíthetőek (pl. új partnercég vagy tanszék felvétele).

Képzeletbeli egyetemünk vezetősége szeretné megtudni, hogy melyek a legnagyobb projektek és ebben milyen arányban vesznek résztegyetemi oktatókés céges dolgozók. A mi feladatunk, hogy egy CSVfájlba kigyűjtsük minden egyes projekt esetén a projekt nevét és a projektben részt vevő egyetemi oktatók és céges dolgozók számát (az adminisztratív személyeket nem kell számolni).Opcionálisan lehessen megadni, hogy minimum hány fős projektek kerülhessenek be a listába (az adminisztratív személyek itt sem számítanak).

Készítsünk egy PowerShellv4szkriptet,ami megoldja a feladatot!

### A szkript elnevezése és paraméterezése

``` powershell
Get-ProjectStatistics.ps1 [-OutFile] <String> [[-MinimalMembers]<Int32>]
```

A szkriptnek kötelező ezt az elnevezést és paraméterezést használnia!A paraméterek sorrendje ne legyen megkötve.

A szkript a paramétereket a következő formában fogadja:

  - `OutFile`: kötelező, a kimeneti csvfájl neve és útvonala.
  - `MinimalMembers`: opcionális,ha meg van adva, akkor csak olyan projektek kerüljenek a listába, amelyeknek legalább ennyi résztvevője van.

  Álljon itt egy példa a szkript egy lehetséges, helyes használatára:

```powershell
  Get-ProjectStatistics.ps1 -MinimalMembers 12 -OutFile C:\test.csv
```

## Tesztelés

Tesztesetek:

  - teszt1: minden projekt megjelenítése
  - teszt2: Csak azoknak a teszteknek a megjelenítése, ahol legalább 90 ember van. Az 1. teszttel összehasonlítva könnyven látható az eredmény. Közben tesztelem azt, hogy   - felülírja-e a régi fájlt.
  - teszt3: Megfordítom a paraméterek sorrendjét, felülírom a régi fájlt, tovább szûkítem a projektek listáját.
  - teszt4: Egy üres listára várok, hiszen ennyi ember egy projekten sem dolgozik.
