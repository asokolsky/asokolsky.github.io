# Claude

Claude Cowork is not supported on Linux. Cowork requires the Claude Desktop app
for macOS or Windows and is not available on web or mobile. That said, there's
an active community working around this. A few unofficial projects bring Cowork
to Linux:

- aaddrick/claude-desktop-debian — the most popular option, with over 3,300
  GitHub stars, providing .deb, .rpm, AppImage, AUR, and Nix packages. It
  includes experimental Cowork mode with pluggable sandbox isolation
  (bubblewrap, KVM/QEMU, or host).
- johnzfitch/claude-cowork-linux — a reverse-engineered project that stubs the
  macOS-native pieces so Cowork can run directly on Linux (x86_64) without a VM.
  It's an unofficial research preview and may break when Claude Desktop updates.

These are community projects — not officially supported by Anthropic — so they can be fragile and break with new Claude Desktop releases. If you want something stable on Linux, Claude Code (the CLI) is your best bet, as it natively supports Linux.

## Claude vs Cursor vs Codex

| Attribute / Product | [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview)                                                 | [Cursor](https://docs.cursor.com/)                        | [Codex](https://platform.openai.com/docs/codex/overview)                                                             |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| Company             | Anthropic                                                                                                              | Anysphere                                                 | OpenAI                                                                                                               |
| Shape               | CLI, with optional IDE integration                                                                                     | VS Code-like editor with completion, chat, and agent mode | CLI, IDE extension, Codex app, and cloud tasks                                                                       |
| Best fit            | Terminal-first work in an existing repo                                                                                | Daily editing with AI built into the IDE                  | Delegating coding tasks locally or in parallel                                                                       |
| Notes               | Codebase Q&A, debugging, refactors, and command-line workflows. Edit files, run commands, and use MCP-connected tools. | Inline edits, autocomplete.                               | Repo-wide changes, tests, PR-sized tasks, review, and background work when the project has clear setup instructions. |

## Gui App Install

Follow steps from the [repo](https://github.com/aaddrick/claude-desktop-debian):

```sh
# Add the GPG key
curl -fsSL https://pkg.claude-desktop-debian.dev/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/claude-desktop.gpg
# Add the repository
echo "deb [signed-by=/usr/share/keyrings/claude-desktop.gpg arch=amd64,arm64] https://pkg.claude-desktop-debian.dev stable main" | sudo tee /etc/apt/sources.list.d/claude-desktop.list
# Update and install
sudo apt update
sudo apt install claude-desktop
```

Launch it with

```sh
claude-desktop&
```

## Claude Code Install

```sh
curl -fsSL https://claude.ai/install.sh | bash
```

Requires subscription
