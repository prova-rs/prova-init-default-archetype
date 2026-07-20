# prova-init-default-archetype

Prova Init Default

## Usage

```sh
archetect render <git-url>#v1
```

## Prompts

Document the prompts this archetype asks, the keys they populate, and
where they come from (this archetype or a library dependency).

| Prompt | Key | Source | Notes |
|---|---|---|---|
| _Example prompt_ | `example_key` | _this archetype_ | _Describe._ |

## What it generates

Describe the directory tree your archetype produces.

```
<project_name>/
├── file.ext
└── ...
```

## Testing locally

While iterating on this archetype before cutting a `v1` tag, render
against the local working copy with `--local`:

```sh
archetect render --local <git-url> --dest /tmp/out
```

## Release versioning

To enable automated releases, add the
[`archetect-actions/repository-release`](https://github.com/archetect-actions/repository-release)
action under `.github/workflows/`. Consumers reference a specific
version by suffixing the git URL with `#v1` (or `#v1.3`, etc.).

## Author

Jimmie Fulton <jimmie.fulton@gmail.com>
