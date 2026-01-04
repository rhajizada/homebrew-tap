# homebrew-tap

![tests](https://github.com/rhajizada/homebrew-tap/actions/workflows/ci.yml/badge.svg)

Homebrew Tap of my personal projects and tools

## What is Homebrew?

Package manager for macOS (or Linux), see more at <https://brew.sh>

## Formulae

| Formula     | Description                                                                                               | Repository                             |
| :---------- | :-------------------------------------------------------------------------------------------------------- | :------------------------------------- |
| **copycat** | CLI tool to copy your project source code as Markdown to clipboard for context-aware responses from LLMs. | <https://github.com/rhajizada/copycat> |
| **cradle**  | CLI to build and launch Docker images with a consistent, pre-configured setup.                            | <https://github.com/rhajizada/cradle>  |
| **donezo**  | Simple TUI to-do app written in Go using Bubble Tea and SQLite.                                           | <https://github.com/rhajizada/donezo>  |
| **signum**  | SVG badge generator written in Go.                                                                        | <https://github.com/rhajizada/signum>  |

## How do I install these formulae?

`brew install rhajizada/tap/<formula>`

Or `brew tap rhajizada/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "rhajizada/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
