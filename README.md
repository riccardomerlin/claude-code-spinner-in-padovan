# Claude Code Spinner Verbs — Padova Edition

> Claude Code spinner verbs in puro diaeto padovan. *"Forsa e coragio che la vita xe on viajo!"*

Quando Claude Code xe drío laorare in tel terminal, el mostra on spinner co on verbo
de fianco — *Pondering…*, *Crunching…*, e via discorendo. Da la version 2.1.23, chei
verbi se poe cambiare. Qua drento ghe xe on pacheto in puro diaeto padovan: 74 verbi
e modi de dire che te senti in tei campi, in ostaria, in cusina da to nona, o al marcà
in Piassa dee Erbe.

Ispirà dal fantastico [claude-code-spinner-verbs-irish](https://github.com/tabman83/claude-code-spinner-verbs-irish)
de `tabman83` — lori i parla dublinese, qua parlemo Padovan. Forza Padova!

## Na ociada veoce

Qualche verbo, tanto par capirse:

```
Rumegando...
Ndando a remengo...
Funfignando...
Porchesando...
Bevendo na obra...
Tirando zó santi e madone...
Girando a vodo...
Baucando...
```

La lista intiera te a cati so [`spinner-verbs.json`](./spinner-verbs.json).

## Cossa che vol dire?

Par chi no xe da ste bande, tradussion in italian come se deve:

| Verbo padovan | Traduzione in italiano |
|---|---|
| **Batendo pisoco** | Sonnecchiare, appisolarsi |
| **Baucando** | Fare lo sciocco, fingere di non capire |
| **Bevendo na obra** | Bere un bicchiere di vino, pausa bevuta |
| **Ciapando fià** | Riprendere fiato, fare una pausa |
| **Ciapando l'acqua col sesto** | Prendere l'acqua col cesto, impresa impossibile |
| **Cincionando** | Gingillarsi, perdere tempo |
| **Descartossando** | Scartare, togliere l'involucro |
| **Faxendo puito** | Fare con cura, fare per bene |
| **Fracando** | Pigiare, comprimere |
| **Funfignando** | Stropicciare |
| **Incalmando** | Innestando, unendo due rami |
| **Ingropando** | Annodando, legando |
| **Limegando** | Andando piano come le lumache |
| **Mastegando** | Masticando, rimuginando |
| **Metendo raíse** | Mettendo radici, processo a lungo termine |
| **Ndando a palpeto** | Andando a tentoni, debuggare al buio |
| **Onfegando** | Ungendo, lubrificare i meccanismi |
| **Parando via le mosche** | Scacciando le mosche, ignorare avvisi |
| **Petando el naso** | Sbattere il naso, rendersi conto |
| **Porchesando** | Imprecando pesantemente |
| **Rumando** | Rovistando, frugare tra le cose |
| **Sbragagnando** | Rovistando disordinatamente |
| **Sercando l'ere** | Cercando il bandolo della matassa |
| **Sgnacando** | Schiacciando con forza |
| **Spuacciando** | sputacchiare, perdere saliva |
| **Tacando boton** | Attaccando bottone, chiacchierare senza fine |
| **Tirando zó santi e madone** | Tirando giù santi e madonne, bestemmiare forte |

El resto te lo trovi... tra nonni e bisnonni de Padova e provincia.

## Instaeassion

### In te on colpo solo

**macOS / Linux**

```bash
curl -fsSL https://raw.githubusercontent.com/riccardomerlin/claude-code-spinner-in-padovan/master/install.sh | bash
```

**Windows (PowerShell)**

```powershell
irm https://raw.githubusercontent.com/riccardomerlin/claude-code-spinner-in-padovan/master/install.ps1 | iex
```

El script el fa sto laoro:

1. El scarga i verbi da sto repo.
2. Se esiste za on `~/.claude/settings.json`, el te domanda: **merge** (tegno el resto) o **overwrite** (sbrego tuto).
3. El fa backup in `settings.json.bak.<timestamp>` in tuti i casi.

Dopo, sara e verzi Claude Code e te si a piombo.

### Cossa te serve

- **Linux/macOS**: `curl` + `jq`
- **Windows**: PowerShell 5.1 o pi novo (de serie su Win 10/11)

### Instaeassion a man

Verzi `~/.claude/settings.json` e zontaghe queo che te cati so `spinner-verbs.json`:

```json
{
  "spinnerVerbs": {
    "mode": "replace",
    "verbs": [
      "Rumegando",
      "Tirando su le maneghe",
      "Ndando a remengo",
      "..."
    ]
  }
}
```

Do maniere:

- `"mode": "replace"` — i default de Claude i sparisse. Solo sti verbi qua resta.
- `"mode": "append"` — sti verbi i se mescola coi default.

## Personaisassion

No te piase on verbo? Cancea la riga. Xe JSON, no serve compíare.

Vuto zontarghene? Fa pure, brao, daghene!.

## Par contribuire

Géto on verbo padovan che manca? Verzi na PR. Regola: che sia autentico, genèrico (gnente
referense a persone reali o blasfemitá), e che fa ridare chi che leze. Pi el xe tipico de nonni e
osterie de provincia, mejo xe.

## Licensa

MIT. Fa queo che te vol. Ma no star fare el bauco.

## Ringrassiamenti

- [`tabman83`](https://github.com/tabman83) par l'idea originale e el pacheto irlandese
- Noni e none de Padova e provincia
- Osterie storiche
