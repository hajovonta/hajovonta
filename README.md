# Hajovonta

A dependency manager for the Hajovonta Common Lisp ecosystem.

## What it does

When you `(ql:quickload "some-hajovonta-project")`, any missing dependencies that belong to the Hajovonta ecosystem are automatically cloned from [sr.ht](https://sr.ht/~hajovonta/) into your `~/quicklisp/local-projects/` directory.

## Setup

Clone this repo into your Quicklisp local-projects:

```sh
git clone https://git.sr.ht/~hajovonta/hajovonta ~/quicklisp/local-projects/hajovonta
```

That's it. Any project that lists `"hajovonta"` as a dependency will automatically activate the resolver when loaded.

## How it works

1. Loading the `hajovonta` system registers an ASDF search function
2. When ASDF can't find a system, the search function checks the [registry](https://hajovonta.srht.site/registry/systems.sexp)
3. If found, the repo is cloned and the `.asd` path is returned to ASDF
4. ASDF loads the system normally

## Pinning versions

By default, the latest `main` branch is used. To pin a project to a specific ref:

```lisp
(hajovonta:pin "fast-csv" :ref "v1.0.0")
```

To remove a pin:

```lisp
(hajovonta:unpin "fast-csv")
```

Pins are stored in `~/.config/hajovonta/pins.sexp`.

## Configuration

- `hajovonta:*registry-url*` — URL of the registry file (default: `https://hajovonta.srht.site/registry/systems.sexp`)
- `hajovonta:*local-projects-dir*` — where repos are cloned (default: `~/quicklisp/local-projects/`)

## License

MIT
