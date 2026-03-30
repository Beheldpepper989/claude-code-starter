---
name: skill-creator
description: Create new skills, modify and improve existing skills, and measure skill performance. Use when users want to create a skill from scratch, edit, or optimize an existing skill, run evals to test a skill, benchmark skill performance with variance analysis, or optimize a skill's description for better triggering accuracy.
---

# Skill Creator

A skill for creating new skills and iteratively improving them.

The process of creating a skill:

1. Decide what you want the skill to do and roughly how it should do it
2. Write a draft of the skill
3. Create a few test prompts and run claude-with-access-to-the-skill on them
4. Evaluate results qualitatively and quantitatively
5. Rewrite the skill based on feedback
6. Repeat until satisfied
7. Expand the test set and try again at larger scale

Your job is to figure out where the user is in this process and jump in to help them progress through these stages.

---

## Creating a skill

### Capture Intent

Start by understanding the user's intent. If the current conversation contains a workflow the user wants to capture, extract answers from the conversation history first.

1. What should this skill enable Claude to do?
2. When should this skill trigger? (what user phrases/contexts)
3. What's the expected output format?
4. Should we set up test cases to verify the skill works?

### Interview and Research

Ask about edge cases, input/output formats, example files, success criteria, and dependencies. Come prepared with context to reduce burden on the user.

### Write the SKILL.md

Components:
- **name**: Skill identifier
- **description**: When to trigger, what it does. Include both what the skill does AND specific contexts for when to use it. Make descriptions slightly "pushy" — Claude tends to undertrigger skills.
- **the rest of the skill**

### Skill Writing Guide

**Progressive Disclosure** — three-level loading:
1. **Metadata** (name + description) — Always in context
2. **SKILL.md body** — In context whenever skill triggers (<500 lines ideal)
3. **Bundled resources** — As needed

Keep SKILL.md under 500 lines. Reference additional files clearly with guidance on when to read them.

**Writing Patterns:**
- Use imperative form in instructions
- Define output formats explicitly with templates
- Include examples
- Explain the *why* behind instructions — don't just issue MUSTs

### Test Cases

After writing the skill draft, come up with 2-3 realistic test prompts. Save to `evals/evals.json`:

```json
{
  "skill_name": "example-skill",
  "evals": [
    {
      "id": 1,
      "prompt": "User's task prompt",
      "expected_output": "Description of expected result",
      "files": []
    }
  ]
}
```

## Running and evaluating test cases

For each test case, run two versions: with-skill and baseline (no skill or old skill version). This identifies whether the skill is actually helping.

Grade results against assertions. Look for:
- Assertions that always pass regardless of skill (non-discriminating)
- High-variance evals (possibly flaky)
- Time/token tradeoffs

## Improving the skill

**Generalize from the feedback** — you're creating a skill that could be used many times across many different prompts. Avoid overfitting to the test examples.

**Keep the prompt lean** — remove things that aren't pulling their weight.

**Explain the why** — today's LLMs have good theory of mind. When given a good harness they can go beyond rote instructions. If you find yourself writing ALWAYS or NEVER in all caps, reframe and explain the reasoning instead.

**Look for repeated work** — if all test cases resulted in the subagent writing a similar helper script, bundle it in `scripts/` and tell the skill to use it.

## Description Optimization

The description field in SKILL.md frontmatter is the primary mechanism that determines whether Claude invokes a skill.

To optimize:
1. Create 20 eval queries — a mix of should-trigger and should-not-trigger
2. Review with user
3. Run the optimization loop
4. Apply the best description to the skill

Good eval queries are realistic and specific — concrete file paths, job context, column names, company names, URLs. A little backstory. Mix of lengths and phrasings. Focus on edge cases and near-misses, not clear-cut examples.
