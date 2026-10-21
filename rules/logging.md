---
description: Log clearly through the project's existing logger
---

# Logging

- Log every meaningful step of a flow that can fail or that someone will need to trace later: start and result of a job, external call (DB, HTTP, ERP, file, queue), import/export, state change, and every caught exception.
- Use the project's existing logger (`ILogger<T>`, Serilog, `console`/`logger` already set up). The sink (Seq, file, cloud) is configured once at startup: just write the log, never add a new sink, logger setup or custom log helper in feature code.
- Structured messages with named placeholders, not string interpolation: `logger.LogInformation("Imported {Count} rows for {BomId}", count, bomId)`, not `$"Imported {count} rows"`.
- Every message carries the IDs needed to find the case: entity id, code, user, factory/tenant, file name, count, duration.
- Pick the level by meaning: `Debug` detail for development, `Information` normal milestones, `Warning` unexpected but handled (skipped row, fallback used, retry), `Error` failed operation with the exception passed as the first argument (`LogError(ex, "...")`), `Critical` the app or a service cannot continue.
- A caught exception is logged once, where it is handled, with context; do not log and rethrow at every layer.
- Never log passwords, tokens, keys, connection strings, full request bodies or personal data.
- No log in tight loops per item at `Information` or above; log a summary (counts, failures) after the loop.
