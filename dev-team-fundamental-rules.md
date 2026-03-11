# Podstawowe Zasady Pracy Zespołów DEV

> **DOKUMENT KANONICZNY** — źródło prawdy: Wiki.js `/dev/zasady-pracy`
> Wersja: 1.0 | Ostatnia aktualizacja: 2026-03-11
>
> **OBOWIĄZKOWE** dla wszystkich zespołów dev-teams. Nieprzestrzeganie = błąd operacyjny.

---

## 1. Zarządzanie zadaniami w CRM

### Z1: Zawsze task w CRM
**Nigdy nie robimy zadań "na słowo"** (chyba że użytkownik wyraźnie o to poprosi). Każde zadanie musi mieć dobrze opisany TASK w Twenty CRM przed rozpoczęciem pracy.

### Z2: STORY dla większych zadań
Do większych zadań z etapami tworzymy task typu **STORY z subtaskami**:
- **STORY** — dokładny opis całej funkcjonalności, cel, zakres, kryteria akceptacji
- **Subtaski** — konkretny opis realizacji poszczególnych kroków

### Z3: Obowiązkowe pola taska
Każdy task dodajemy z:
- **Space**: `COMPANY` (zawsze, chyba że task prywatny)
- **Team**: przypisany zespół odpowiedzialny
- **Sprint**: bieżący sprint (jeśli sprint się kończy → zapytaj użytkownika czy następny sprint)
- **Priority**: wg ważności (CRITICAL/HIGH/MEDIUM/LOW)
- **Estimation**: wg rozmiaru (XS/S/M/L/XL)
- **Description**: pełny opis z kontekstem

> **UWAGA**: Jeśli użytkownik chce wrzucić do backlogu lub na inny sprint — poinformuje o tym.

---

## 2. Workflow statusów

### Z4: Status IN_PROGRESS na start
Gdy zespół **zaczyna pracę** z zadaniem → **od razu** zmień status na `IN_PROGRESS`:
```
PATCH /rest/tasks/{id} → {"status": "IN_PROGRESS"}
```

### Z5: Status DONE na koniec
Gdy zespół **kończy zadanie** → zmień status na `DONE` + dodaj komentarz z wynikiem:
```
PATCH /rest/tasks/{id} → {"status": "DONE"}
```

---

## 3. Git workflow

### Z6: Commit + Push natychmiast
**Każde zakończone zadanie musi być od razu commitowane i pushowane.**
- Nie zostawiaj uncommitted zmian
- Nie zostawiaj unpushed commitów
- Sesja bez push = utracona praca

```bash
git add <pliki>
git commit -m "typ(zakres): opis — CCD-XXXX"
git push origin <branch>
```

---

## 4. Aktualizacja wiedzy

### Z7: Obowiązek aktualizacji wiedzy
Po zakończonym tasku **konieczna jest aktualizacja wiedzy**:
- Wiedza zespołowa (`teams/*/memory/`)
- Wiedza międzyzespołowa (`shared/`, `agents/knowledge/`)
- Wiki.js (`/dev/*`)
- Qdrant (embeddingi)
- Engram (pamięć persystentna)

> **STORY**: aktualizuj wiedzę dopiero po całkowitym ukończeniu STORY, nie po każdym subtasku.

### Z8: Powiadomienie na RC #dev
Po dodaniu wiedzy międzyzespołowej/firmowej → **poinformuj na kanale RC #dev** inne zespoły o nowej wiedzy.

### Z9: Linki do zmian w Wiki
W przypadku aktualizacji Wiki.js:
- Podaj **linki do stron**, w których nastąpiły zmiany
- Podaj **linki do nowych stron**

### Z10: Indeks Wiki
Nowe strony w Wiki.js **muszą być dodane do głównego indeksu** (`/dev`) w odpowiednich kategoriach.

---

## 5. Weryfikacja przed zamknięciem

### Z11: Weryfikacja narzędziami
Każde zadanie **przed poinformowaniem użytkownika o sukcesie** musi być sprawdzone:
- **Frontend**: Playwright (browser automation, screenshots)
- **Backend**: testy jednostkowe/funkcjonalne/e2e

### Z12: Screenshot dla frontend
Gdy zadanie frontowe zostanie prawidłowo zakończone → **screenshot działającej funkcjonalności** musi być załączony do zadania w CRM.

### Z13: Testy dla backend
Testy jednostkowe/funkcjonalne/e2e:
- **Planowane z użytkownikiem** jeszcze PRZED rozpoczęciem zadania
- Uzgodnij zakres testów na etapie planowania
- Brak testów = zadanie niekompletne

### Z14: Informuj o problemach
Jeśli wystąpi jakikolwiek problem, błąd lub blokada → **natychmiast informuj użytkownika**. Nie ukrywaj problemów.

---

## Checklist zamknięcia zadania

```
[ ] Task w CRM ma status DONE + komentarz z wynikiem
[ ] Kod commitowany i pushowany (git status = czyste)
[ ] Wiedza zaktualizowana (zespołowa + międzyzespołowa + Wiki.js)
[ ] RC #dev powiadomiony (jeśli wiedza międzyzespołowa)
[ ] Weryfikacja wykonana (Playwright/testy)
[ ] Screenshot załączony (jeśli frontend)
```

---

## Gdzie znajdziesz te zasady

| Lokalizacja | Typ | Auto-sync |
|-------------|-----|-----------|
| Wiki.js `/dev/zasady-pracy` | **SSoT** (źródło prawdy) | - |
| `agents/knowledge/dev-team-fundamental-rules.md` | Mirror | Manual |
| `shared/AGENTS.base.md` | Reference + hook | Manual |
| `teams/*/AGENTS.md` | Reference | Manual |
| Engram | Pamięć | Manual |
| Qdrant | Embeddingi | Via n8n |

---

## Historia zmian

| Data | Wersja | Zmiany |
|------|--------|--------|
| 2026-03-11 | 1.0 | Wersja inicjalna — 14 zasad fundamentalnych |
