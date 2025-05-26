# homebrew-tap

Homebrew Tap of my personal projects and tools

## What is Homebrew?

Package manager for macOS (or Linux), see more at <https://brew.sh>

## Formulae

| Formula     | Description                                                                                               | Repository                             |
| :---------- | :-------------------------------------------------------------------------------------------------------- | :------------------------------------- |
| **donezo**  | Simple TUI to-do app written in Go using Bubble Tea and SQLite.                                           | <https://github.com/rhajizada/donezo>  |
| **copycat** | CLI tool to copy your project source code as Markdown to clipboard for context-aware responses from LLMs. | <https://github.com/rhajizada/copycat> |

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
