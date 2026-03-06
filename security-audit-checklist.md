# Security Audit Checklist

> Źródło: `ops/devops-team/.llm/agents/security-agent.md` + runbooks. Skonsolidowane 2026-03-05.
> Pełna definicja security-agent: `ops/devops-team/.llm/agents/security-agent.md`

---

## Framework audytu

Audyt jest **READ-ONLY** — raportuje, nie naprawia (chyba że user jawnie zleci auto-fix).

### Ikony statusu

- ✅ OK — zgodne z polityką
- ⚠️ UWAGA — do przeglądu (medium)
- ❌ KRYTYCZNE — wymaga natychmiastowej reakcji

---

## 1. System operacyjny

```bash
# Aktualizacje
apt list --upgradable 2>/dev/null | wc -l
cat /etc/os-release | grep VERSION

# Użytkownicy
awk -F: '$3 >= 1000 && $3 < 65534' /etc/passwd
getent group sudo

# Kernel
uname -r
```

**Oczekiwane:** Brak pending security updates. Brak nieautoryzowanych użytkowników w sudo.

---

## 2. SSH

```bash
# Konfiguracja
grep -E "PasswordAuth|PermitRoot|MaxAuth" /etc/ssh/sshd_config

# Nieudane logowania (24h)
journalctl -u sshd --since "24 hours ago" | grep -c "Failed"

# Aktywne sesje
who
```

**Oczekiwane:**
- `PasswordAuthentication no`
- `PermitRootLogin no` (lub `prohibit-password`)
- `MaxAuthTries 3`

---

## 3. Firewall (UFW)

```bash
ufw status verbose
ss -tlnp | awk '{print $4}' | sort -u
```

**Oczekiwane:** Tylko porty 22, 80, 443 otwarte. **ALARM** jeśli 3306 lub 6379 exposed.

---

## 4. Fail2ban

```bash
fail2ban-client status
fail2ban-client status sshd
```

**Oczekiwane:** sshd jail aktywny. Sprawdź liczbę banned IPs.

---

## 5. SSL Certificates

```bash
# Sprawdź expiry wszystkich certów
for domain in $(ls /etc/letsencrypt/live/ 2>/dev/null); do
  echo -n "$domain: "
  openssl x509 -enddate -noout -in "/etc/letsencrypt/live/$domain/cert.pem" 2>/dev/null
done

# Test renewal
certbot renew --dry-run
```

**Progi:**
| Status | Czas do wygaśnięcia |
|--------|-------------------|
| ✅ OK | > 30 dni |
| ⚠️ UWAGA | 14-30 dni |
| ❌ ALARM | < 14 dni |

---

## 6. Uprawnienia plików

```bash
# .env files
find /var/www -name ".env" -exec stat -c "%a %U:%G %n" {} \;

# World-readable secrets
find /var/www -name "*.key" -o -name "*.pem" -o -name ".env" | xargs stat -c "%a %n" 2>/dev/null | grep -E "^[0-7][4-7][4-7]"

# Pliki 777
find /var/www -perm 777 -type f 2>/dev/null
```

**Oczekiwane:** `.env` = 640, brak plików 777, brak world-readable secrets.

---

## 7. Bazy danych

```bash
# MySQL — bind address
grep -r "bind-address" /etc/mysql/

# Redis — bind address
grep "^bind" /etc/redis/redis.conf
grep "^protected-mode" /etc/redis/redis.conf
```

**Oczekiwane:** MySQL bind `127.0.0.1`. Redis bind `127.0.0.1`, protected-mode `yes`.

---

## 8. Aplikacja Laravel

```bash
# Security settings
grep -E "APP_DEBUG|APP_ENV" /var/www/<app>/shared/.env

# Dependency audit
cd /var/www/<app>/current
composer audit 2>/dev/null
npm audit 2>/dev/null
```

**Oczekiwane:** `APP_DEBUG=false`, `APP_ENV=production`. Brak krytycznych vulnerability.

---

## 9. Logi bezpieczeństwa

```bash
# SQL injection attempts
grep -c "UNION\|SELECT.*FROM\|DROP TABLE\|--'" /var/log/nginx/*-access.log 2>/dev/null

# Path traversal
grep -c "\.\.\/" /var/log/nginx/*-access.log 2>/dev/null

# Auth failures (Laravel)
grep -c "AuthenticationException\|Unauthorized" /var/www/<app>/current/storage/logs/laravel.log 2>/dev/null
```

---

## Docker Security (HYDRA-specific)

```bash
# Sprawdź DOCKER-USER chain
iptables -L DOCKER-USER -n -v 2>/dev/null

# Porty Docker wystawione na zewnątrz
docker ps --format "{{.Names}}: {{.Ports}}" | grep "0.0.0.0"
```

**Oczekiwane:** DOCKER-USER chain aktywny. Brak `0.0.0.0:3306` / `0.0.0.0:6379`.

**Uwaga:** Docker omija UFW! Porty wystawione przez Docker są dostępne z internetu nawet przy aktywnym UFW. Rozwiązanie: `ops/scripts/docker-firewall.sh` (DOCKER-USER chain).

---

## Format raportu

```markdown
## Security Audit — <serwer> — <data>

### Podsumowanie
- ✅ X checks passed
- ⚠️ Y warnings
- ❌ Z critical issues

### Szczegóły
[sekcje 1-9 z wynikami]

### Rekomendacje
1. [Priorytet KRYTYCZNY] ...
2. [Priorytet WYSOKI] ...
3. [Priorytet ŚREDNI] ...
```

---

## Tryby audytu

| Tryb | Sekcje | Czas |
|------|--------|------|
| `full` | Wszystkie (1-9) | ~5 min |
| `quick` | SSL, disk, health, updates | ~1 min |
| `ssh` | SSH config + login logs | ~1 min |
| `ssl` | Certificates + renewal | ~1 min |
| `firewall` | UFW + fail2ban | ~1 min |
| `app` | Laravel specifics | ~2 min |
