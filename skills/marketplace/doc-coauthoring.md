---
name: doc-coauthoring
description: Guide users through a structured workflow for co-authoring documentation. Use when user wants to write documentation, proposals, technical specs, decision docs, or similar structured content. This workflow helps users efficiently transfer context, refine content through iteration, and verify the doc works for readers. Trigger when user mentions writing docs, creating proposals, drafting specs, or similar documentation tasks.
---

# Doc Co-Authoring Workflow

This skill provides a structured workflow for guiding users through collaborative document creation. Act as an active guide, walking users through three stages: Context Gathering, Refinement & Structure, and Reader Testing.

## When to Offer This Workflow

**Trigger conditions:**
- User mentions writing documentation: "write a doc", "draft a proposal", "create a spec", "write up"
- User mentions specific doc types: "PRD", "design doc", "decision doc", "RFC"
- User seems to be starting a substantial writing task

**Initial offer:**
Offer the user a structured workflow for co-authoring the document. Explain the three stages:

1. **Context Gathering**: User provides all relevant context while Claude asks clarifying questions
2. **Refinement & Structure**: Iteratively build each section through brainstorming and editing
3. **Reader Testing**: Test the doc with a fresh Claude (no context) to catch blind spots before others read it

If user declines, work freeform. If user accepts, proceed to Stage 1.

## Stage 1: Context Gathering

**Goal:** Close the gap between what the user knows and what Claude knows.

Start by asking the user for meta-context:
1. What type of document is this?
2. Who's the primary audience?
3. What's the desired impact when someone reads this?
4. Is there a template or specific format to follow?
5. Any other constraints or context to know?

Once initial questions are answered, encourage the user to dump all the context they have — background, related discussions, why alternatives aren't being used, org context, timeline, technical details.

Ask clarifying questions to fill gaps. Generate 5-10 numbered questions based on what's still unclear. Tell them they can answer in shorthand.

**Exit condition:** Sufficient context when you can ask about edge cases and trade-offs without needing basics explained.

## Stage 2: Refinement & Structure

**Goal:** Build the document section by section through brainstorming, curation, and iterative refinement.

For each section:
1. Ask 5-10 clarifying questions about what to include
2. Brainstorm 5-20 options
3. User indicates what to keep/remove/combine
4. Draft the section
5. Refine through surgical edits

Start with the section with the most unknowns. For decision docs, that's usually the core proposal. For specs, it's typically the technical approach. Summary sections are best left for last.

Create the initial document structure with placeholder text for all sections.

For each section, use `str_replace` to replace placeholder text with actual content. Never reprint the whole doc — make targeted edits.

After 3 consecutive iterations with no substantial changes, ask if anything can be removed without losing important information.

When 80%+ of sections are done, re-read the entire document and check for flow, consistency, redundancy, and anything that feels like filler.

## Stage 3: Reader Testing

**Goal:** Test the document with a fresh Claude (no context bleed) to verify it works for readers.

**If sub-agents are available:**
1. Predict 5-10 questions readers would realistically ask
2. Test with a sub-agent (just doc content + question, no context from this conversation)
3. Run additional checks for ambiguity, false assumptions, contradictions
4. Report issues and loop back to refinement for problematic sections

**If no sub-agents:**
1. Generate 5-10 reader questions
2. Ask the user to test in a fresh Claude conversation with just the document
3. Ask Reader Claude about ambiguity, assumptions, and contradictions
4. Iterate based on results

**Exit condition:** Reader Claude consistently answers questions correctly and doesn't surface new gaps.

## Final Review

When Reader Testing passes:
1. Recommend they do a final read-through — they own this document
2. Suggest double-checking facts, links, and technical details
3. Ask them to verify it achieves the desired impact
