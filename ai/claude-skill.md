# Claude Skill File

From [substack.com/@humzakhalid](https://substack.com/@humzakhalid)

## Components

The SKILL.md has 7 Components:

1. YAML Frontmatter (Your Skill's ID Card)

- This tells Claude what the skill is called and when to load it.
- Weak frontmatter = Claude ignores your skill completely.

2. Instructions Block (The Brain)

- Tell Claude exactly what to do inside this skill.
- Tell Claude exactly what never to do.

3. Examples Section (The Shortcut)

- Show Claude a sample input and the exact output you expect.
- Two examples cut mistakes in half.

4. Supporting Files (The Context Layer)

- Got extra templates, scripts, or reference docs?
- Link them here instead of pasting everything in one block.

5. The Trigger Rule (The Most Ignored Part)

- Claude reads your description to decide if it should load.
- Weak words = skill gets skipped every single time.

6. Negative Instructions (The Error Killer)

- Tell Claude what NOT to do.
- This one section prevents 80% of wrong outputs.

7. Composability (The Power Move)

- Skills can team up.
- Claude can load multiple skills at once.
