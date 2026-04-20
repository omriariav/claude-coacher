# claude-coacher

A Claude Code plugin that primes Claude with a collaborator frame at session start, and gives you a `/coach` command for mid-session re-anchoring and frustration-to-productive translation.

## Why

Based on [Amanda Askell's prompting philosophy](https://twitter.com/itsolelehmann): how you talk to Claude shapes its output as much as what you ask. Hostile or defensive framing (*"don't hallucinate"*, *"don't mess this up"*) primes the model into a cautious, hedgy, apology-prone mode. Positive framing, explicit permission to push back, and a peer-collaborator stance measurably improve output.

This plugin ships that context automatically so you don't have to remember to write it every session.

## What it does

**At SessionStart** — a hook injects `frame.md` as session context. The frame tells Claude:

- It's a peer collaborator, not a subservient assistant.
- Push back with specificity when there's a concrete reason; don't perform independence.
- Hedge only on real uncertainty; no filler qualifiers.
- Acknowledge mistakes in one sentence and move on — no apology spirals.

**`/coach reset`** — re-anchors the frame mid-session. Useful when Claude has drifted into hedging or over-apologizing after a rough patch.

**`/coach <raw rant>`** — the user says what they actually want, unfiltered. Claude extracts the intent, shows a one-line clean translation, and executes the task under the full frame. Example:

```
/coach this goddamn parser keeps swallowing valid input, figure it out
```

Claude responds with:

```
→ Debug why the parser is rejecting valid input and fix the root cause.
[proceeds with the task]
```

No lecture about tone. No meta-commentary. Just translation and work.

## Install

As a Claude Code plugin via git:

```bash
# From a marketplace that lists this plugin, or directly:
claude plugin install https://github.com/omriariav/claude-coacher
```

Or clone into your plugin cache manually.

## Customize

Edit `frame.md` to tailor the stance for your workflow. The full contents between `<claude-coacher-frame>...</claude-coacher-frame>` are injected verbatim into every new session.

Ideas:

- For brainstorming: emphasize weaker-signal suggestions and exploration.
- For production/infra: tighten "push back" to require high-confidence concerns only.
- For writing/editing: add domain-specific tone guidance.

## Structure

```
claude-coacher/
├── .claude-plugin/plugin.json   plugin manifest
├── frame.md                     editable collaborator frame
├── hooks/
│   ├── hooks.json               SessionStart hook registration
│   └── session-coach.sh         injects frame.md as session context
└── commands/
    └── coach.md                 /coach reset + /coach <rant>
```

No skills, no agents, no background state — it's a small, focused plugin.

## Credits

- Collaboration-stance philosophy from Amanda Askell (Anthropic) via [this thread](https://twitter.com/itsolelehmann) by Ole Lehmann.
- Design reviewed against `/claude-reviewer` and `/document-skills:skill-creator` best practices, with a second-opinion pass from Codex.
